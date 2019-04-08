class SimulatorWorker
  include Sidekiq::Worker
  require "#{Rails.root}/lib/baccarat.rb"
  
  def perform(strategy_id)
    # Do something
    @strategy = Strategy.find(strategy_id)
   
    n_decks = @strategy.number_of_decks_per_shoe
    cards = (Deck.new(BaccaratRules::CARD_VALUES).cards * n_decks).shuffle
    b = Baccarat.new(cards)
    
    scores = {}
    1.upto(32) do |count|
      b.play
      b.print
      puts "------ game #{count} "
      
      binding.pry
      
      if ! b.winner.nil?
        scores[b.winner.name] ||= 0
        scores[b.winner.name] += 1
      else
        scores['tie'] ||= 0
        scores['tie'] += 1
      end
    end
    puts scores
  end
end
