$(document).ready ->
  if location.hash == ''
    $('html, body').animate { scrollTop: 0 }, 600

  $('header#header').addClass('alt').removeClass('header')
