# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/



win_list = (a) ->
  return a.map (w) -> w.winner
  
#underdog = (idx) ->
#  return win_list[-3..idx]

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

  $("#show_winners").on "click", ->
    console.log("show_winners clicked!")
    console.log(count_elements(win_list(winners)))

