// Placeholder manifest file.
// the installer will append this file to the app vendored assets here: vendor/assets/javascripts/spree/frontend/all.js'


function SpreeQuotesManagement(max_limit, span_char_left, quotes_textarea) {
  this.max_limit = max_limit;
  this.$span_char_left = $(span_char_left);
  this.$quotes_textarea = $(quotes_textarea)
}

SpreeQuotesManagement.prototype.init = function() {
  var _this = this;
  _this.$span_char_left.css('display', 'none');

  _this.$quotes_textarea.keyup(function () {
    var lengthCount = this.value.length;
    if (lengthCount > _this.max_limit) {
      this.value = this.value.substring(0, _this.max_limit);
      var charactersLeft = _this.max_limit - lengthCount + 1;
    }
    else {
      var charactersLeft = _this.max_limit - lengthCount;
    }
    _this.$span_char_left.css('display', 'block');
    _this.$span_char_left.text(charactersLeft + ' Characters left');
  });
}


$(function () {
  var max_limit = 240;
  var span_char_left = $('#spnCharLeft');
  var quotes_textarea = $('#quote_description');
  new SpreeQuotesManagement(max_limit, span_char_left, quotes_textarea).init()
});
