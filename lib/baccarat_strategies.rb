module BaccaratStrategies

  def underdog(game)
      s = game.simulation
      g = game

    if s.position_on_a_run       
      g.bet_position = s.position_on_a_run
      g.bet_amount   = s.unit_cost
      
    elsif s.current_underdog
      ud = s.current_underdog
      puts "betting underdog #{s.unit_cost} on #{ud}" 
      g.bet_position = ud
      g.bet_amount = s.martingale_wager
    end
  end

end
