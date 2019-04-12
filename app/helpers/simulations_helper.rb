module SimulationsHelper
  CARD_SUITS =      ["Spades", "Clubs", "Hearts", "Diamonds"]
  CARD_SUITS_SHORT =["S",      "C",     "H",      "D"]
  
  CARD_NAMES       = ["Ace", *(2..10), "Jack", "Queen", "King"].map(&:to_s)  
  CARD_NAMES_SHORT = ["A",   *(2..10), "J",    "Q",     "K"].map(&:to_s)
  
    
  def get_card_sgv(card)   
    n, s = card.split('-')
    suit = CARD_SUITS[CARD_SUITS_SHORT.index(s)].downcase
    name = CARD_NAMES[CARD_NAMES_SHORT.index(n)].downcase       
    img_name = "#{name}_of_#{suit}.svg"           
    #return image_tag("svg-cards/#{img_name}", height: '96', width: '70')
    return image_tag("svg-cards/#{img_name}", height: '76', width: '50')
  end   
  
  def get_cards_div(game: :game, player: :player)  
    game.send("#{player}_cards").split(',').map {|c| get_card_sgv(c) }.join.html_safe
  end
  
  def  get_winner_class(player: :player, game: :game) 
    #if game.winner = player.to_s.first.upcase
    p = player.to_s.first.upcase
    return "#{p}_color" if  p == game.winner 
  end
end
