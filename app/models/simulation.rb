class Simulation < ApplicationRecord
  belongs_to :strategy  
  has_many :games
  
  
  def current_underdog 
    #last three games where winner > 2
    # select last three, group by winner where count > 1 and tie is 0
    return nil if games.count < 5
    ud_seq, ud_hsh = game_score
    dominant = ud_hsh.invert.max&.last
    return oppsite(dominant)
  end
  
  def oppsite(position)
    return 'player' if position == 'banker'
    return 'banker'
  end
  
  def position_on_a_run
    ud_seq, ud_hsh = game_score
    return ud_seq.first if ud_hsh.values.detect{|v| v == 3 }   
  end
  
  def game_score
    ud = games.where.not(winner: 'tie').order(id: :desc).limit(3) #.group(:winner).count
    ud_hsh = ud.map{|o| o.winner}.each_with_object(Hash.new(0)) { |n,h| h[n] += 1 }
    ud_seq = ud.pluck(:winner)
    return [ud_seq, ud_hsh]
  end
end
