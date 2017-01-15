@DiceRoller =
  init: ->
    $('.roll-dice').click (ev) =>
      ev.preventDefault()
      @multiRoll()
    @rollDice()
    @enableRollTrigger()
  faces: ['front', 'back', 'right', 'left', 'top', 'bottom']
  disableRollTrigger: ->
    $('.roll-dice').addClass('disabled').text('Rolling...')
  enableRollTrigger: ->
    $('.roll-dice').removeClass('disabled').text('Roll')
  randomFace: (oldFace) ->
    newFace = oldFace
    while newFace == oldFace
      newFace = @faces[Math.floor(Math.random() * @faces.length)]
    return newFace
  rollDice: ->
    oldFace = @activeFace
    newFace = @randomFace(@activeFace)
    @activeFace = newFace
    $('.dice').removeClass("show-#{oldFace}").addClass("show-#{newFace}")
  multiRoll: ->
    if @rollingInProgress
      return
    @rollingInProgress = true
    @disableRollTrigger()
    limit = 20 + Math.floor(Math.random() * 5)
    rollCounter = 0
    multiRoller = setInterval =>
      rollCounter += 1
      @rollDice()
      if rollCounter >= limit
        @rollingInProgress = false
        @enableRollTrigger()
        clearInterval(multiRoller)
    , 300

$ ->
  DiceRoller.init()
