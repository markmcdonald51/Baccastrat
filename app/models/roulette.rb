class Roulette < ApplicationRecord

  NUMBERS = [0, 2, 14, 35, 23, 4, 16, 33, 21, 6, 18, 31, 19, 8, 12, 29, 25, 10,
     27, 37, 1, 13, 36, 24, 3, 15, 34, 22, 5, 17, 32, 20, 7, 11, 30, 26, 9, 28]

  class << self
    def first_12_win?(n)
      n <= 12
    end

    def second_12_win?(n)
      n > 12 && n < 25 
    end

    def third_12_win?(n)
      n > 24
    end

    def draw_number
      NUMBERS[rand(NUMBERS.length)]
    end

    def underdog(depth: 7)
      underdogs = []
      lb = Roulette.last(depth).pluck(:number_drawn)
      puts lb
      [:first_12, :second_12,:third_12].map do |m|
        if (lb.detect{|n| send(:"#{m}_win?", n)}).blank?      
          underdogs << m
        end       
      end
      return underdogs
    end
  end

  def draw
    number_drawn = Roulette.draw_number
  end


end
