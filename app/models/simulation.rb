class Simulation < ApplicationRecord
  #belongs_to :strategy  
  
  has_many :strategy_simulations
  has_many :strategies, through: :strategy_simulations , class_name: 'Strategy'
  has_many :games
  
  
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
    #r = games.where.not(bet_result: 'T').pluck(:bet_result).last(4)
    r = games.where.not(bet_result: 'T').limit(4).order(:id).pluck(:bet_result)
 
    bet_amt = unit_cost
    # Return the bet amount unless martingale > 1
    return bet_amt unless martingale > 0

    r.each_with_index do |result,i|      
        return bet_amt * (i + 1) && i == 0 if result == 'W'
        return bet_amt if result == 'W'
        bet_amt = bet_amt * (i + 1)       
      end  
    end
    puts "Martingale: #{bet_amt}"
    return bet_amt
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
