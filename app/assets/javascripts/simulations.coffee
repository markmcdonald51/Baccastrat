# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

###
class Baccarat 
   constructor: (data) ->
    @daaename
###


win_list = (a) -> a.map (w) -> w.winner 
  

sort_hash_vars = (hsh) ->
  keys = Object.keys(hsh).sort (a, b) -> hsh[b] - hsh[a] 


underdog = (ary, idx) ->
  filtered = win_list(ary).filter (p) -> p != 'T'
  h = count_elements(filtered[-3..])
  console.log("the counted ary is")
  console.log(h)
  return sort_hash_vars(h)[1]
  
count_elements  = (ary) -> 
  resultSummary = {}
  $.each ary, (index, value) ->
    if !resultSummary[value]
      resultSummary[value] = 0
      console.log(value)
    resultSummary[value] += 1

  return resultSummary
  

$ -> 
  console.log("DOM is ready")
  games = $('#all_game_results').data('games')

  $("#show_winners").on "click", ->
    console.log("show_winners clicked!")
    console.log("the underdog is #{underdog(games)}")
    # console.log(sort_hash_vars(underdog(games)))
    
    
   
