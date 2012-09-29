# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

()->
  $(".simple_carousel_content").simpleCarousel
    "speed":500
    'multiplication':3
    'type': 'horizontal'



(($) ->
  $.fn.simpleCarousel = ( options )->
    $my_this  = $(this)
    settings = $.extend
      'speed': 5000      # domyślna szybkość
      'multiplication':3 # jak mamy mało elementów to możemy wstawić żeby więcej razy się 1 powielał
      'type':'horizontal'
    ,options

    inter =  setInterval () ->
      true
    , 1
    methods = {
    # ruch w lewo
    left : ()->
      #pierwszy ruch po najechaniu
      $("ul", $my_this).filter(':not(:animated)').animate
        left: "-="+element_width
      ,settings.speed, () ->
        if parseInt($("ul", $my_this).css("left")) < -1*(width-1)
          $("ul", $my_this).css("left", 0)
      inter = setInterval () ->
        $("ul", $my_this).stop(true, true).animate
          left: "-="+element_width
        ,settings.speed, () ->
          if parseInt($("ul", $my_this).css("left")) < -1*(width-1)
            $("ul", $my_this).css("left", 0)

      ,settings.speed

    # ruch w prawo
    right : ()->
      #pierwszy ruch po najechaniu
      $("ul", $my_this).filter(':not(:animated)').animate
        left: "+="+element_width
      ,settings.speed, () ->
        if parseInt($("ul", $my_this).css("left")) > (-1)
          $("ul", $my_this).css("left", (-1)*width)
      inter = setInterval () ->
        $("ul", $my_this).stop(true, true).animate
          left: "+="+element_width
        ,settings.speed, () ->
          if parseInt($("ul", $my_this).css("left")) > (-1)
            $("ul", $my_this).css("left", (-1)*width)

      ,settings.speed
    # ruch w górę
    down : ()->
      #pierwszy ruch po najechaniu
      $("ul", $my_this).filter(':not(:animated)').animate
        top: "-="+element_height
      ,settings.speed, () ->
        if parseInt($("ul", $my_this).css("top")) < -1*(height-1)
          $("ul", $my_this).css("top", 0)
      inter = setInterval () ->
        $("ul", $my_this).stop(true, true).animate
          top: "-="+element_height
        ,settings.speed, () ->
          if parseInt($("ul", $my_this).css("top")) < -1*(height-1)
            $("ul", $my_this).css("top", 0)
      ,settings.speed

    # ruch w dół
    up : ()->
      #pierwszy ruch po najechaniu
      $("ul", $my_this).filter(':not(:animated)').animate
        top: "+="+element_height
      ,settings.speed, () ->
        if parseInt($("ul", $my_this).css("top")) > (-1)
          $("ul", $my_this).css("top", (-1)*height)
      inter = setInterval () ->
        $("ul", $my_this).stop(true, true).animate
          top: "+="+element_height
        ,settings.speed, () ->
          if parseInt($("ul", $my_this).css("top")) > (-1)
            $("ul", $my_this).css("top", (-1)*height)

      ,settings.speed

    move : (move_value)->
      if settings.type == "horizontal"
        $("ul", $my_this).filter(':not(:animated)').animate
          left: "+="+move_value
        ,settings.speed, () ->
          if parseInt($("ul", $my_this).css("left")) > (-1)
            $("ul", $my_this).css("left", (-1)*width)
          else  if parseInt($("ul", $my_this).css("left")) < -1*(width-1)
            $("ul", $my_this).css("left", 0)

      else
        $("ul", $my_this).filter(':not(:animated)').animate
          top: "+="+move_value
        ,settings.speed, () ->
          if parseInt($("ul", $my_this).css("top")) > (-1)
            $("ul", $my_this).css("top", (-1)*height)
          else  if parseInt($("ul", $my_this).css("top")) < -1*(height-1)
            $("ul", $my_this).css("top", 0)


    # stop
    stop : () ->
      clearInterval inter
    }
    if settings.type=="horizontal"
      element_width = parseInt $("ul li", $my_this).css("width") # długość li z css
      element_length = $("ul li", $my_this).length # ilość elementów
      width = element_width * element_length # długość ul
      width_multiplication = settings.multiplication * width
      $("ul", $my_this).css("width",width_multiplication)
    else
      element_height = parseInt $("ul li", $my_this).css("height") # wysokość li z css
      element_length = $("ul li", $my_this).length # ilość elementów
      height = element_height * element_length # długość ul
      height_multiplication = settings.multiplication * height
      $("ul", $my_this).css("height",height_multiplication)




    for i in [1..settings.multiplication-1]
      $("ul", $my_this).append($("ul", $my_this).html())

    if settings.type=="horizontal"
      $("ul", $my_this).css("left", (-1)*width)
    else
      $("ul", $my_this).css("top", (-1)*height)


    methods['stop']()
    $(".rt_left", $my_this.parents("simple_carousel_container")).hover () ->
      methods['left']()
    ,() ->
      methods['stop']()
    $(".rt_right", $my_this.parents("simple_carousel_container")).hover () ->
      methods['right']()
    ,() ->
      methods['stop']()
    $(".rt_up", $my_this.parents(".simple_carousel_container")).hover () ->
      methods['up']()
    ,() ->
      methods['stop']()
    $(".rt_down", $my_this.parents(".simple_carousel_container")).hover () ->
      methods['down']()
    ,() ->
      methods['stop']()






    touch = false
    tap = false
    firstY = 0
    secondY = 0
    firstX = 0
    secondX = 0
    if $my_this.length>0
      $my_this[0].ontouchstart = (event)->
        event.preventDefault()
        methods['stop']()
        tap = true
        touch = true
        firstY = event.targetTouches[0].pageY
        firstX = event.targetTouches[0].pageX

      $my_this[0].ontouchmove = (event)->
        event.preventDefault();
        if touch
          secondY = event.targetTouches[0].pageY
          secondX = event.targetTouches[0].pageX
          diffY = secondY - firstY
          diffX = secondX - firstX
          tap = false
          if settings.type=='horizontal'
            methods['move'](diffX)
          else
            methods['move'](diffY)
          firstY = secondY
          firstX = secondX


      $my_this[0].ontouchend = (event)->
        event.preventDefault()


)(jQuery)
 
