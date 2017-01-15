@Pictionary =
  words:
    person: [
      "Jesus", "Muhammad", "Michael Jackson", "Adolf Hitler", "Albert Einstein", "Leonardo Da Vinci", "Sir Isaac Newton", "Abraham Lincoln", "Mahatma Gandhi", "Aristotle",
      "London", "Bangkok", "Paris", "Dubai", "Istanbul", "New York", "Singapore", "Kuala Lumpur", "Seoul", "Hong Kong", "Tokyo", "Barcelona", "Amsterdam", "Rome", "Milan", "Taipei", "Shanghai", "Vienna", "Prague", "Los Angeles",
      "Ape", "Bat", "Cat", "Dog", "Lion", "Leopard", "Tiger", "Donkey", "Fox",
    ]
    object: ["Diary", "Bottle", "Water", "Packet", "Chewing gum", "Tissue", "Glasses", "Watch", "Sweet", "Photo", "Camera", "Stamp", "Postcard", "Dictionary", "Coin", "Brush", "Credit card", "Identity card", "Key", "Mobile phone", "Phone card", "Wallet", "Button", "Umbrella", "Pen", "Pencil", "Lighter", "Cigarette", "Match", "Lipstick", "Purse", "Case", "Clip", "Scissors", "Rubber", "File", "Banknote", "Passport", "Driving licence", "Comb", "Notebook", "Laptop", "Rubbish", "Mirror", "Painkiller", "Sunscreen", "Toothbrush", "Headphone", "Player", "Battery", "Light bulb", "Bin", "Newspaper", "Magazine", "Alarm clock"]
    action: ["Buy", "Sell", "Run", "Walk", "Stand", "Sit", "Sleep", "Wake", "Eat", "Chew", "Swallow", "Speak", "Talk", "Say", "Drink", "Look", "See", "Watch", "Listen", "Hear", "Write", "Draw", "Sign", "Go", "Come", "Want", "Have", "Hit", "Kick", "Push", "Pull", "Open", "Close", "Put", "Take", "Enter", "Leave", "Order", "Demand", "Request", "Ask", "Answer"]
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
