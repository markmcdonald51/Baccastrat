class SimulatorWorker
  include Sidekiq::Worker
  require "#{Rails.root}/lib/baccarat.rb"
  
  def perform(simulation_id)
    # Do something
    @simulation = Simulation.find(simulation_id)
    @simulation.games.delete_all
   
    n_decks = @simulation.number_of_decks_in_shoe
    cards = (Deck.new(BaccaratRules::CARD_VALUES).cards * n_decks).shuffle
    b = Baccarat.new(cards)
    
    scores = {}
    
    num_of_games = cards.count / 6
    
    begin
      1.upto(num_of_games) do |count|
        b.play
        #b.print
        puts "------ game #{count} "
        
        game = @simulation.games.build
        
        if @simulation.position_on_a_run       
          puts "on a run!!! need to do something but nothing for now"
        elsif @simulation.current_underdog
          ud = @simulation.current_underdog
          puts "betting underdog #{@simulation.unit_cost} on #{ud}" 
          game.bet_position = ud
          game.bet_amount = @simulation.martingale_wager
        end
        
        if ! b.winner.nil?
          scores[b.winner.name] ||= 0
          scores[b.winner.name] += 1
        else
          scores['tie'] ||= 0
          scores['tie'] += 1
        end
        
        pr = b.player_results
        br = b.banker_results
       
        game.attributes = {
          player_cards: pr[:cards],
          player_score: pr[:score],
          banker_cards: br[:cards],
          banker_score: br[:score],
          winner:       b.winner.nil? ? 'T' : b.winner.name.first
        }
        if game.bet_position.present?        
          game.bet_result = (game.bet_position == game.winner) ? "W" : "L"
          game.bet_result = 'T' if  game.winner == 'T'
        end
        game.save!
      end
      #puts scores
    rescue => e
      puts "#{ e } caused by #{ e.cause }"
      puts 'rescued' 
    end  
    @simulation.sleep! 
  end
end
