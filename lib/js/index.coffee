
console.log "The wind is silent in the dom..."
i = 0
activeTimeoutid = null
parent = ""

# insert button function
insertListener = (event) ->
  if $(event.target).hasClass("personPageEditInputContainerTiny")
    i += 1

    parent = $(event.target).parent()

    $(event.target).children('input')
      .attr('data-id', "#{i}")

    parent.append(
      """
      <div class="stopwatch" data-id="#{i}">
      <label for="stopwatch-button">Start Timer</label>
      <input id="stopwatch-button" type="checkbox" style="display: none;">
      </div>
      """
    )

    parent.find(".stopwatch").click( () ->

      if $(@).hasClass('active-btn')
        console.log "Stop"
        stop(@)

      else
        if activeTimeoutid is null
          console.log "start"
          start($(@).parent(), @)

      false
    )

timer = (ele) ->
  input = ele.find('input.personPageInputTiny')
  activeTimeoutid = window.setInterval(
    () ->
      input.val(+input.val() + .01)
    , 5
  )

start = (parent, ele) ->
  timer(parent)
  $(ele).addClass('active-btn')
  $(ele).children('label').text('Stop Timer')

stop = (ele) ->
  window.clearTimeout(activeTimeoutid)
  activeTimeoutid = null

  unless ele is null
    $(ele).removeClass('active-btn')
    $(ele).children('label').text('Start Timer')


# Listen for DOM insert
document.addEventListener('DOMNodeInserted', insertListener)

$('body').click( (event) ->

  target = $(event.target)

  if not target.hasClass('popupContainer') and not target.parent('.popupContainer')
    stop(null)

  if target.parent('.popupContainer') is null
    stop(null)

  if target.hasClass('cancelButtonNotification')
    stop(null)

  false
)
