@CountDownTimer =
  states:
    started: 1
    stopped: 2
    idle:    3
  stopAnimator: ->
    clearInterval(@animator)
  start: ->
    $('#timer .toggle-timer').text('Stop')
    @currentState = @states.started
    @endTime = Date.now() + 60000
    @animator = setInterval =>
      @propagateTimer()
    , 30
  reset: ->
    $('#timer .toggle-timer').text('Start')
    @currentState = @states.idle
    @stopAnimator(true)
    @setTime(0)
    @stopAudio(@timerAudio)
  stop: ->
    $('#timer .toggle-timer').text('Reset')
    @currentState = @states.stopped
    @stopAnimator()
    @stopAudio(@timerAudio)
  toggle: ->
    switch @currentState
      when @states.idle then @start()
      when @states.stopped then @reset()
      when @states.started then @stop()
  propagateTimer: ->
    currentTime = Date.now()
    if currentTime > @endTime
      @reset()
      @startAudio(@bellAudio)
    else
      @setTime(@endTime - currentTime)
  setTime: (time) ->
    time = Math.floor(time / 10)
    centiSeconds = time % 100
    time = Math.floor(time/100)
    seconds = time%60
    $('#timer .time').text("#{@padZero(seconds)}:#{@padZero(centiSeconds)}")
  padZero: (num) ->
    num = num + ''
    if num.length == 1
      num = "#{0}#{num}"
    return num
  startAudio: (audio) ->
    audio.currentTime = 0
    audio.play()
  stopAudio: (audio) ->
    audio.pause() if audio
  init: ->
    @reset()
    @timerAudio = new Audio('public/audio/adrenaline.mp3')
    @timerAudio.volume = 0.3
    @bellAudio = new Audio('public/audio/ting.mp3')
    $('#timer .toggle-timer').click (ev) =>
      ev.preventDefault()
      @startAudio(@timerAudio)
      @toggle()

$ ->
  CountDownTimer.init()
