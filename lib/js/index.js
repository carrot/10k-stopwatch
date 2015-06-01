/**
 * @file index.js, holds all of 10k-stopwatch's logic
 * {@link https://github.com/carrot/10kft-stopwatch}
 * @version 2.0.0
 * @author Brandon Romano [brandon@carrotcreative.com]
 * @author Henry Snopek [henry.snopek@carrotcreative.com]
 * @license MIT
 */

var currentDataId = 0;
var activeTimeoutId = null;
var activeInput = null;
var parent = null;

/**
 * createBtn - Creates 'start/stop' button
 *
 * @param {event} event returned from listener
 */
var createBtn = function(event) {
  if ($(event.target).hasClass("tk-time-tracker-cel")) {
    currentDataId += 1;

    parent = $(event.target);

    $(event.target).children('input')
      .attr('data-id', "#{currentDataId}");

    // Appending our stopwatch button
    parent.append(
      `
      <div class="stopwatch" data-id="#{currentDataId}">
      <label for="stopwatch-button">Start Timer</label>
      <input id="stopwatch-button" type="checkbox" style="display: none;">
      </div>
      `
    );

    // Applying onClick to the stopwatch button
    $(event.target).find(".stopwatch").click(function() {
      // If it's active, stop it
      if ($(this).hasClass('active-btn'))
        stop(this);
      // If it's not active, start it (given that nothing else is running)
      else if (activeTimeoutId === null)
        start($(this).parent(), this);

      return false; // Consuming the onClick
    });
  }
};

/**
 * This function starts to update an input, given a parent
 * @param  {jQuery Object} parent timer's parent
 * @return
 */
var timer = function(parent) {
  activeInput = parent.find('input.personPageInputTiny');
  activeTimeoutId = window.setInterval(function() {
    // round new value to hundredths
    activeInputVal = activeInput.val();

    // if input has a colon, convert to decimal
    if (activeInputVal.indexOf(":") > -1) {
      let hours = activeInputVal.substring(0, activeInputVal.indexOf(":"));
      let minutes = activeInputVal.substring(activeInputVal.indexOf(":") + 1);
      let decimalMinutes = Math.round(100 * (minutes / 60)) / 100;

      let newValue = (+hours + (+decimalMinutes)) + 0.01;
    }

    else
      newValue = Math.round(100 * (+activeInput.val() + 0.01)) / 100;

    activeInput.val(newValue);

    // Forcing an update
    let lastFocus = $(document.activeElement);
    activeInput.focus();
    activeInput.blur();
    lastFocus.focus();
  }, 36000);
};

/**
 * This function starts the timer on an element
 * @param  {jQuery Object} parent current parent of timer
 * @param  {jQuery Object} ele    element to start updating
 * @return
 */
var start = function(parent, ele) {
  timer(parent);
  $(ele).addClass('active-btn');
  $(ele).children('label').text('Stop Timer');
};

/**
 * This function stops the timer on an element
 * @param  {jQuery Object} ele element to stop updating
 * @return
 */
var stop = function(ele) {
  window.clearTimeout(activeTimeoutId);
  activeTimeoutId = null;

  if (ele !== null) {
    $(ele).removeClass('active-btn');
    $(ele).children('label').text('Start Timer');
  }

  // Forcing 10k to update
  if (activeInput !== null) {
    activeInput.focus();
    activeInput.blur();
    activeInput = null;
  }
};

// Listen for DOM insert
// document.addEventListener('DOMNodeInserted', insertListener)
$('body').click(function(event) { createBtn(event); });

// Listening to onClicks to disable the timer when model is closed
$('body').click(function(event) {
  target = $(event.target);
  console.log(event);

  if (!target.parent().hasClass('stopwatch')) {
    stop(null);
    // console.log('stopwatch');
  }

  // If what we clicked is not a child of a popup container,
  // and isn't the popup container itself
  if (!(target.parents('div.popupContainer').length) &&
    !(target.hasClass('popupContainer'))) {
    stop(null);
    // console.log('Not div.popupContainer or popupContainer');

    }

  // If the user presses the X button
  if (target.hasClass('cancelButtonNotification')) {
    stop(null);
    // console.log('pressed X');
  }

  // If user clicked add line item
  if (target.hasClass('timeEntryAddLineContainer') ||
      (target.parents('.timeEntryAddLineContainer').length > 0)) {
    event.stopPropagation();
    stop(null);
    console.log("is timeEntryAddLineContainer or parent is .timeEntryAddLineContainer");
  }

  // false Consuming the onClick
});
