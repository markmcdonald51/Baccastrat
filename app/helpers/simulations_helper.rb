module SimulationsHelper
  CARD_SUITS =      ["Spades", "Clubs", "Hearts", "Diamonds"]
  CARD_SUITS_SHORT =["S",      "C",     "H",      "D"]
  
  CARD_NAMES       = ["Ace", *(2..10), "Jack", "Queen", "King"].map(&:to_s)  
  CARD_NAMES_SHORT = ["A",   *(2..10), "J",    "Q",     "K"].map(&:to_s)
  
    
  def get_card_sgv(card)

    
    n, s = card.split('-')
    #10_of_clubs.svg
    
    suit = CARD_SUITS[CARD_SUITS_SHORT.index(s)].downcase
    name = CARD_NAMES[CARD_NAMES_SHORT.index(n)].downcase
       
    img_name = "#{name}_of_#{suit}.svg"    
    
    return image_tag("svg-cards/#{img_name}", height: '96', width: '70')
  end   
end
