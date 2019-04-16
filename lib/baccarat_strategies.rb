module BaccaratStrategies

  def underdog_Nx(game)
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
  
  
=begin  
  NEW when you win  [Easyway Baccarat]
  1,3,2,4 (increase/decrease unit_amount)
  
  THis system just bets on banker the entire session. If it wins it increases 
  bet from 1 unit to 3 tp 2 then finally 4 units.
  
=end  


  def easy_baccarat(game) 
    s = game.simulation
    g = game
    last_bet  = game.simulation.games.last.bet_amount
    unit_cost = game.simulation.unit_cost
    
    bet_amounts_matrix = [1,3,2,4]    
    m = bet_amounts_matrix.detect{|i| last_bet == unit_cost * i} 
    
    last_bet_idx = bet_amounts_matrix.index(m)
    
    if last_bet == 0 || bet_amounts_matrix.index(m) ==  bet_amounts_matrix.last 
      game.bet_amount = unit_cost 
    else
      game.bet_amount = unit_cost *  bet_amounts_matrix[last_bet_idx +1]
    end
  
    unless s.position_on_a_run == 'P'
      game.bet_position = 'B'
    end    
    
  end

end 
