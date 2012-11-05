#= require jquery

jQuery ($) ->
  setTimeout ->
    $('body').html('<h1 id="loaded">Page loaded!</h1>')
  , 1500
