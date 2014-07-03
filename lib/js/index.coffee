
console.log "The wind is silent in the dom..."

# Execute if the animation matches nodeInstered
insertListener = (event) ->
  console.log event
  if event.animationName is "nodeInserted"
    console.log "Another node has been inserted! ", event, event.target

# Listen for DOM insert
mainCon = document.getElementById('mainCon')
mainCon.addEventListener('DOMNodeInserted', insertListener)
mainCon.addEventListener('DOMNodeInserted', insertListener)

###
$("""
<div id="stopwatch">
<label for="stopwatch-button"></label>
<input id="stopwatch-button" type="checkbox">
</div>
""").appendTo.('.timeEntryInputContainer')
###
