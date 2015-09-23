$(document).ready ->
  if location.hash == ''
    $('html, body').animate { scrollTop: 0 }, 600

  $('.sign_in_button').click ->
    $('#sign_in_modal').modal('show')

  $('header#header').addClass('alt').removeClass('header')
