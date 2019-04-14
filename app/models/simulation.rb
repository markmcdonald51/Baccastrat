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
    #return bet_amount if (martinagle == 0 or last_win_idx.blank? or last_win_idx >= martinagle)
    bet_amount = last_bet.bet_amount * 2  

    return bet_amount
  end
  
  def current_underdog 
    #last three games where winner > 2
    # select last three, group by winner where count > 1 and tie is 0
    return nil if games.count < 5
    ud_seq, ud_hsh = game_score
    dominant = ud_hsh.invert.max&.last
    return oppsite(dominant)
  end
  
  def oppsite(position)
    return 'P' if position == 'B'
    return 'B'
  end
  
  def position_on_a_run
    ud_seq, ud_hsh = game_score
    return ud_seq.first if ud_hsh.values.detect{|v| v == 3 }   
  end
  
  def game_score
    ud = games.where.not(winner: 'T').order(id: :desc).limit(3) #.group(:winner).count
    ud_hsh = ud.map{|o| o.winner}.each_with_object(Hash.new(0)) { |n,h| h[n] += 1 }
    ud_seq = ud.pluck(:winner)
    return [ud_seq, ud_hsh]
  end
end
