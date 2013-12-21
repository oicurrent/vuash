$(function() {
  function reload() {
    var clip = new ZeroClipboard($("#copy-button"), {
        moviePath: "/swfs/ZeroClipboard.swf"
    });

    clip.on("load", function(client) {
      client.on("complete", function(client, args) {
        $('#to-copy').focus()
        $('#to-copy').select()
      });
    });
  }

  $('#to-copy').on('click', function(){
    $(this).focus()
    $(this).select()
  });

  $('.result').on('click', 'a.button', function(ev){
    ev.preventDefault();
    $('.result').hide();
    $('form')
      .show()
      .find('textarea')
      .val('')
      .focus();
  })

  $('#vuash-form').on('submit', function(ev){
    ev.preventDefault();
    $(this).slideUp()
    $('.loading').fadeIn()

    var url  = $(this).attr('href');
    var data = $(this).serialize();

    $.ajax({
      url: url,
      data: data,
      type: 'POST',
    }).done(function(html){
      $('.loading').fadeOut()
      $('.result').hide();
      $('.result').html(html);
      $('.result').slideDown();
      reload();
    });
  });
})
