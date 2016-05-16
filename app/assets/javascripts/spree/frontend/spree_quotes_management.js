// Placeholder manifest file.
// the installer will append this file to the app vendored assets here: vendor/assets/javascripts/spree/frontend/all.js'

//= require ../characters_left_counter.js

$(function() {
  var divSelector = '#user_quotes_new_form';
  new CharactersLeftCounter(divSelector).init()
});
