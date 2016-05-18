// Placeholder manifest file.
// the installer will append this file to the app vendored assets here: vendor/assets/javascripts/spree/frontend/all.js'

//= require spree/characters_left_counter

$(function() {
  new CharactersLeftCounter('#user_quotes_new_form').init();
});
