# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

###
class Baccarat 
   constructor: (data) ->
    @daaename
###


win_list = (a) ->
  return a.map (w) -> w.winner 


underdog = (ary, idx) ->
  filtered = win_list(ary).filter (p) -> p != 'T' 
  return count_elements(filtered[-3..])


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
    console.log(underdog(games))
    
   
