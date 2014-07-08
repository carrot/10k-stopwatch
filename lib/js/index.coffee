current_data_id = 0
active_timeout_id = null
active_input = null
parent = null

###*
 * insert button function
 * @param {event} event returned from listener
###
insertListener = (event) ->
  if $(event.target).hasClass("personPageEditInputContainerTiny")
    current_data_id += 1

    parent = $(event.target).parent()

    $(event.target).children('input')
      .attr('data-id', "#{current_data_id}")

    #Appending our stopwatch button
    parent.append(
      """
      <div class="stopwatch" data-id="#{current_data_id}">
      <label for="stopwatch-button">Start Timer</label>
      <input id="stopwatch-button" type="checkbox" style="display: none;">
      </div>
      """
    )

    # Applying onClick to the stopwatch button
    parent.find(".stopwatch").click( () ->

      # If it's active, stop it
      if $(@).hasClass('active-btn')
        stop(@)

      # If it's not active, start it (given that nothing else is running)
      else
        if active_timeout_id is null
          start($(@).parent(), @)

      false #Consuming the onClick
    )

###*
 * This function starts to update an input, given a parent
 * @param  {jQuery Object} parent timer's parent
 * @return
###
timer = (parent) ->
  active_input = parent.find('input.personPageInputTiny')
  active_timeout_id = window.setInterval(
    () ->
      # round new value to hundredths
      newValue = Math.round(100 * (+active_input.val() + .01)) / 100
      active_input.val(newValue)

      # Forcing an update
      last_focus = $(document.activeElement)
      active_input.focus()
      active_input.blur()
      last_focus.focus()
    , 36000
  )

###*
 * This function starts the timer on an element
 * @param  {[type]} parent current parent of timer
 * @param  {jQuery Object} ele    element to start updating
 * @return
###
start = (parent, ele) ->
  timer(parent)
  $(ele).addClass('active-btn')
  $(ele).children('label').text('Stop Timer')

###*
 * This function stops the timer on an element
 * @param  {jQuery Object} ele element to stop updating
 * @return
###
stop = (ele) ->
  window.clearTimeout(active_timeout_id)
  active_timeout_id = null

  unless ele is null
    $(ele).removeClass('active-btn')
    $(ele).children('label').text('Start Timer')

  #Forcing 10k to update
  if active_input isnt null
    active_input.focus()
    active_input.blur()
    active_input = null

# Listen for DOM insert
document.addEventListener('DOMNodeInserted', insertListener)

# Listening to onClicks to disable the timer when modal is closed
$('body').click( (event) ->

  target = $(event.target)

  # If what we clicked is not a child of a popup container,
  # and isn't the popup container itself
  if not target.parents('div.popupContainer').length and not target.hasClass('popupContainer')
    stop(null)

  #If the user presses the X button
  if target.hasClass('cancelButtonNotification')
    stop(null)

  #If user clicked add line item
  if target.hasClass('timeEntryAddLineContainer') or (target.parents('.timeEntryAddLineContainer').length > 0)
    event.stopPropagation()
    stop(null)

  false #Consuming the onClick
)
