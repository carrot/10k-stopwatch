# 10K Stopwatch

A stopwatch extension for [10000ft.com](10000ft.com) time tracker.

Download & install from the [Google Chrome Web Store]()


## Dev Requirements
- Node / NPM
- Google Chrome

## Setting up

There's already a Makefile set up, so to get set up initially run `make build` to install all dependencies and compile the coffeescript.

After you've compiled for the first time, go in Google Chrome and go to [chrome://extensions/](chrome://extensions/).

Turn on developer mode (should be a checkbox) and click the `Load unpacked extension...` button.

Point it to `../path/to/10k-stopwatch/app`, and you'll be good to go.

## Updating

To update, simply update the coffeescript/css, and re run `make`.

Go back to `chrome://extensions/` in Google Chrome, and click the hyperlink `Reload (⌘R)` at the bottom of the 10k-stopwatch extension, or simply press ⌘R on a Mac.  

Go to [app.10000ft.com/](https://app.10000ft.com/) to see your changes.
