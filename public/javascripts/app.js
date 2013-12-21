$(function() {

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
    $('form').hide()
    $('.loading').show()
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
          .hide()
          .html(html)
          .slideDown()
      }
    })
  })
})
