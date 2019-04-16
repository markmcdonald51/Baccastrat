class SimulatorWorker
  include Sidekiq::Worker
  include BaccaratStrategies
  require "#{Rails.root}/lib/baccarat.rb"
  
  def perform(simulation_id)
    @simulation = Simulation.find(simulation_id)
    @simulation.games.delete_all
   
    n_decks = @simulation.number_of_decks_in_shoe
    cards = (Deck.new(BaccaratRules::CARD_VALUES).cards * n_decks).shuffle
    b = Baccarat.new(cards)
    
    scores = {}
    num_of_games = cards.count / 6
    
    @simulation.current_bankroll ||= @simulation.bankroll_start 
    
    begin
      1.upto(num_of_games) do |count|
        b.play
        #b.print
        puts "------ game #{count} "        
        game = @simulation.games.build
        
        # Call Strategy
        #underdog_Nx(game)
        easy_baccarat(game)
        
        
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
        if game.bet_result == 'W'
          @simulation.current_bankroll += game.bet_amount 
        elsif game.bet_result == 'L'
          @simulation.current_bankroll -= game.bet_amount  
        end
        game.save!
      end
    rescue => e
      puts "#{ e } caused by #{ e.cause }"
      puts 'rescued' 
    end  
    @simulation.sleep! 
  end
end
