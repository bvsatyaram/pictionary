@Pictionary =
  words:
    person: ["Ape", "Bat", "Cat", "Dog"]
    object: ["Pen", "Book", "TV"]
    action: ["Run", "Sleep", "Eat"]
  randomInteger: (limit) ->
    return Math.floor(Math.random() * limit)
  randomWordInArray: (arr, wordsToExclude = []) ->
    word = null
    while (word == null) || (wordsToExclude.indexOf(word) != -1)
      word = arr[@randomInteger(arr.length)]
    return word
  generateCard: ->
    @hideCard()
    @currentWords = {}
    @currentWords.person =
      word: @randomWordInArray(@words.person)
      allPlay: (@randomInteger(5) == 0)
    @currentWords.object =
      word: @randomWordInArray(@words.object)
      allPlay: (@randomInteger(5) == 0)
    @currentWords.action =
      word: @randomWordInArray(@words.action)
      allPlay: (@randomInteger(5) == 0)
    @currentWords.difficult =
      word: @randomWordInArray(@words.all, [@currentWords.person.word, @currentWords.object.word, @currentWords.action.word])
      allPlay: (@randomInteger(5) == 0)
    @currentWords.allPlay =
      word: @randomWordInArray(@words.all, [@currentWords.person.word, @currentWords.object.word, @currentWords.action.word, @currentWords.difficult.word])
      allPlay: true
  revealCard: ->
    @cardRevealed = true
    $('.word-container.person .word').text(@currentWords.person.word)
    if @currentWords.person.allPlay
      $('.word-container.person').addClass('allPlay')
    else
      $('.word-container.person').removeClass('allPlay')
    $('.word-container.object .word').text(@currentWords.object.word)
    if @currentWords.object.allPlay
      $('.word-container.object').addClass('allPlay')
    else
      $('.word-container.object').removeClass('allPlay')
    $('.word-container.action .word').text(@currentWords.action.word)
    if @currentWords.action.allPlay
      $('.word-container.action').addClass('allPlay')
    else
      $('.word-container.action').removeClass('allPlay')
    $('.word-container.difficult .word').text(@currentWords.difficult.word)
    if @currentWords.difficult.allPlay
      $('.word-container.difficult').addClass('allPlay')
    else
      $('.word-container.difficult').removeClass('allPlay')
    $('.word-container.all-play .word').text(@currentWords.allPlay.word)
    $('.word-container.all-play').addClass('allPlay')
    $('.toggle-card span').text('Hide Card')
  hideCard: ->
    @cardRevealed = false
    $('.word-container.person .word').text("Person/Place/Animal")
    $('.word-container.object .word').text("Object")
    $('.word-container.action .word').text("Action")
    $('.word-container.difficult .word').text("Difficult")
    $('.word-container.all-play .word').text("All Play")
    $('.word-container').removeClass('allPlay')
    $('.toggle-card span').text('Reveal Card')
  toggleCard: ->
    if @cardRevealed
      @hideCard()
    else
      @revealCard()
  init: ->
    @words.all = []
    @words.all.push(word) for word in @words.person
    @words.all.push(word) for word in @words.object
    @words.all.push(word) for word in @words.action
    @generateCard()
    @hideCard()
    $('.toggle-card').click (ev) =>
      @toggleCard()
    $('.change-card').click (ev) =>
      @generateCard()

$ ->
  Pictionary.init()
