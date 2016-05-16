// Placeholder manifest file.
// the installer will append this file to the app vendored assets here: vendor/assets/javascripts/spree/frontend/all.js'

// This js is for adding no. of characters left for input in textarea to a span#span-char-left

// Add data field max-limit to textarea(optional) and a span with id span-char-left below textarea

function SpreeQuotesManagement(divSelector) {
  this.$div = $(divSelector);
  this.maxLimit = this.$div.find('textarea').data('max-limit') || 240;
  this.$spanCharLeft = this.$div.find('span#span-char-left');
}

SpreeQuotesManagement.prototype.init = function() {
  var _this = this;
  _this.$spanCharLeft.css('display', 'none');

  this.$div.on('keyup', 'textarea', function() {
    _this.$spanCharLeft = $('span#span-char-left');
    var lengthCount = this.value.length,
        charactersLeft;
    if (lengthCount > _this.maxLimit) {
      this.value = this.value.substring(0, _this.maxLimit);
      charactersLeft = 0;
    } else {
      charactersLeft = _this.maxLimit - lengthCount;
    }
    _this.$spanCharLeft.css('display', 'block');
    _this.$spanCharLeft.text(charactersLeft + ' Characters left');
  });
}


$(function () {
  var divSelector = '#user_quotes_new_form';
  new SpreeQuotesManagement(divSelector).init()
});
