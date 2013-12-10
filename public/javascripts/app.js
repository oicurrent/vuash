$(function() {
  var clip = new ZeroClipboard($("#copy-button"), {
      moviePath: "/swfs/ZeroClipboard.swf"
  });

  clip.on("load", function(client) {
    client.on("complete", function(client, args) {
      $('#to-copy').trigger('click')
      console.log("Copied text to clipboard: " + args.text );
    });
  });

  $('#to-copy').on('click', function(){
    $(this).focus()
    $(this).select()
  });
})
