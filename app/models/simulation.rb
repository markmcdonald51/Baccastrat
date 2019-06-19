class Simulation < ApplicationRecord
  #belongs_to :strategy  
  
  has_many :strategy_simulations
  has_many :strategies, through: :strategy_simulations , class_name: 'Strategy'
  has_many :games
  
  validates_presence_of :bankroll_start, :unit_cost, :number_of_decks_in_shoe
  
  
  include AASM
  
  aasm do
    state :sleeping, initial: true
    state :running, :cleaning

    event :run do
      transitions from: :sleeping, to: :running, after: :run_simulation
    end

    event :clean do
      transitions from: :running, to: :cleaning
    end

    event :sleep do
      transitions from: [:running, :cleaning], to: :sleeping
    end
  end
  
  def run_simulation
    SimulatorWorker.perform_async(self.id)
  end
  
  def martingale_wager
    martinagle = 4
  
    bet_amount = unit_cost   
    bet_res = games.where.not(bet_result: 'T').limit(martinagle).order(id: :desc)
    r = bet_res.map(&:bet_result)
       
    last_bet = bet_res.first
    last_win_idx = r.index('W')

    return bet_amount if r.first == 'W' or martinagle == 0 or  last_win_idx.blank?  
    bet_amount = last_bet.bet_amount * 2  
    return bet_amount
  end
  
  def current_underdog 
    return nil if games.count < 5
    ud_seq, ud_hsh = game_score
    dominant = ud_hsh.invert.max&.last
    return oppsite(dominant)
  end
  
  def advanced_inversion_method #  AIM
    # P B P          B P B 
    # P        or        B
    # P                  B
    max_aim_loss = 3
    aim_hash = {bet_position: nil, 
                bet_sequence: 0}
    
    ud = current_underdog
    last_game = games.last(1)
    ud_seq, ud_hsh = game_score(limit: 4) 
    if (ud_seq[1] == ud or ud_seq.reverse[1] == ud)
    
      bet_aim_count = 1
      aim_hash = {bet_position: ud, 
                  last_game.bet_aim_count + 1, 
                  bet_sequence: 1}
                  
    elsif position_on_a_run and 
      last_game.bet_aim_count > max_aim_loss and 
      last_game.winner == false
      
      aim_hash = {bet_position: ud, 
        bet_sequence: last_game.bet_aim_count + 1,
        bet_aim_count:last_game.bet_aim_count + 1  }      
    end 
    return aim_hash
  end
  def oppsite(position)
    return 'P' if position == 'B'
    return 'B'
  end
  
  def position_on_a_run(min: 3)
    ud_seq, ud_hsh = game_score(limit: 4)
    return ud_seq.first if ud_hsh.values.detect{|v| v == min}   
  end
  
  def game_score(limit: 3)
    ud = games.where.not(winner: 'T').order(id: :desc).limit(limit) #.group(:winner).count
    ud_hsh = ud.map{|o| o.winner}.each_with_object(Hash.new(0)) { |n,h| h[n] += 1 }
    ud_seq = ud.pluck(:winner)
    return [ud_seq, ud_hsh]
  end
end
