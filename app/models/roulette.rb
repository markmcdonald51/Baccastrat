class Roulette < ApplicationRecord

  NUMBERS = [0, 2, 14, 35, 23, 4, 16, 33, 21, 6, 18, 31, 19, 8, 12, 29, 25, 10,
     27, 37, 1, 13, 36, 24, 3, 15, 34, 22, 5, 17, 32, 20, 7, 11, 30, 26, 9, 28]

  def Roulette::draw_number
    NUMBERS[rand(NUMBERS.length)]
  end

  def draw
    number_drawn = Roulette::draw_number
  end

  def first_12_win?
    if number_drawn <= 12
      win_amount = bet_amount * 3
      return true
    end
    return false 
  end

  def second_12_win?
    if number_drawn > 12 && result < 25 
      win_amount = bet_amount * 3
      return true
    end
    return false 
  end

  def third_12_win?
    if number_drawn > 24
     win_amount = bet_amount * 3
      return true
    end
    return false 
  end
end
