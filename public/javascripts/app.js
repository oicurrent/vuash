jQuery(function($) {

  $('.result').on('click', 'a.button', function(ev){
    ev.preventDefault()
    $('.result').hide()
    $('form')
      .show()
      .find('textarea')
      .val('')
      .focus()
  })

  $(document).ajaxStart(function() {
    $('form').fadeOut()
    $('.loading').delay(500).fadeIn()
  })


  $('#vuash-form').on('submit', function(ev){
    ev.preventDefault()

    var url  = $(this).attr('href')
    var data = $(this).serialize()


    $.ajax({
      url: url,
      data: data,
      type: 'POST',
      success: function(html) {
        $('.loading').fadeOut()
        $('.result')
          .fadeOut()
          .html(html)
          .delay(500)
          .fadeIn()
      }
    })
  })

  $('.toggle-fullscreen').click(function(){
    $(this).toggleClass('active');
    $('.wrapper').toggleClass('fullscreen');
    $('textarea.new').focus();
  })
})
