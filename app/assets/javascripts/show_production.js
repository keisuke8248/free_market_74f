$(function() {
  $('.imageSelection').each(function(i){
    if (0 == i) {
      $(`#${i}`).css('opacity', '1');
    } else {
      $(`#${i}`).css('opacity', '0.4');
    }
  });
  $('.imageSelection').on('mouseover', function(e) {
    let id = $(this).attr('id');
    let ID = $(`#${id}`)
    let smallImage = ID.attr('src');
    let largeImage = $('.itemBox__image--large');
    largeImage.attr('src', smallImage);
    $('.imageSelection').each(function(i){
      if (id != i) {
        $(`#${i}`).css('opacity', '0.4');
      } else {
        $(`#${i}`).css('opacity', '1.0');
      }
    });
  });
});