$(function() {
  function reload() {
    var clip = new ZeroClipboard($("#copy-button"), {
        moviePath: "/swfs/ZeroClipboard.swf"
    });

    clip.on("load", function(client) {
      client.on("complete", function(client, args) {
        $('#to-copy').focus()
        $('#to-copy').select()
        //console.log("Copied text to clipboard: " + args.text );
      });
    });
  }

  $('#to-copy').on('click', function(){
    $(this).focus()
    $(this).select()
  });

  $('#vuash-form').on('submit', function(ev){
    ev.preventDefault();

    var url  = $(this).attr('href');
    var data = $(this).serialize();

    $.ajax({
      url: url,
      data: data,
      type: 'POST',
    }).done(function(html){
      $('.result').hide();
      $('.result').html(html);
      $('.result').slideDown();
      reload();

    });
  });
})
