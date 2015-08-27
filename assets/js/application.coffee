$ ->
  csrf = -> $('[name=_csrf]').attr('content')

  uuid = ->
    'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace /[xy]/g, (c) ->
      r = Math.random() * 16 | 0
      v = if c == 'x' then r else r & 0x3 | 0x8
      v.toString 16

  $(document).on 'click', '.send-message', (e) ->
    e.preventDefault()

    body = $('textarea').val()

    if body is ''
      $('.validation-error').addClass('visible').attr('aria-hidden', false)
      return false

    secret    = uuid()
    encrypted = CryptoJS.AES.encrypt(body, secret)

    $('#message_data').val(encrypted)

    $.ajax
      url     : '/',
      type    : 'POST',
      dataType: 'json',
      data    : { message_data: $('#message_data').val(), '_csrf': csrf },
      success : (data) ->
        $('.share-link').text window.location + data.uuid + "/#" + secret
        $("#new").slideUp()
        $("#created").slideDown()

      error   : (xhr, err) -> alert(err)

  $('.read-message').on 'click', (e) ->
    e.preventDefault()

    $.ajax
      url     : '/' + $(this).data('uuid'),
      type    : 'POST',
      dataType: 'json',
      data    : { '_csrf': csrf },
      success : (data) ->
        secret    = location.hash.slice(1)
        decrypted = CryptoJS.AES.decrypt(data.message, secret)
        $('pre.message').text(decrypted.toString(CryptoJS.enc.Utf8))
        $("#show").slideUp()
        $("#read").slideDown()
      error   : (xhr, err) -> alert(err)
