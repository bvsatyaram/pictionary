@DiceRoller =
  init: ->
    $('.roll-dice').click (ev) =>
      ev.preventDefault()
      @rollDice()
    @rollDice()
  faces: ['front', 'back', 'right', 'left', 'top', 'bottom']
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

$ ->
  DiceRoller.init()
