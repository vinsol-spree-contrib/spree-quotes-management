// Placeholder manifest file.
// the installer will append this file to the app vendored assets here: vendor/assets/javascripts/spree/backend/all.js'

//= require ../characters_left_counter.js

$(function() {
  var divSelector = '#quote_description_field';
  new CharactersLeftCounter(divSelector).init()
});
