Backbone.$ = $

class InputSearchView extends Backbone.View

  selectedMode: null

  selectedInput: null

  userMode: 'username'

  locationMode: 'location'

  events:
    "submit": "inputSubmitHandler"
    "focusout input.tag": "blurHandler"
    "keydown input.tag": "inputValidation"

  el: $('form.tag-input')

  elInputs: $('input.tag')

  initialize: (options) ->
    @options = options || {}

    _.bindAll @, 'inputSubmitHandler'

    @elTagPicker = $(@el)

    @elLocationInput = @elTagPicker.find('input#location')
    @elUsernameInput = @elTagPicker.find('input#username')
    @elTagPickerSubmit = @elTagPicker.find('input[type=submit]')

    if not @options.mobile
      tooltipContent = $('.tooltip-content').html()
      $('.username-help').tooltip
        content: tooltipContent
        position:
          my: "top"
          at: "bottom"
        "open"

  inputValidation: (e) =>
    otherInput = @elInputs.not(e.target)

    if e.keyCode isnt 9
      if otherInput.val()
        otherInput.val('')

    if @elLocationInput.val() or @elUsernameInput.val()
      @elTagPickerSubmit.removeAttr 'disabled'

  blurHandler: (e) =>
    if not @elLocationInput.val() and not @elUsernameInput.val()
      @elTagPickerSubmit.attr 'disabled', 'disabled'

  inputSubmitHandler: (e) =>
    e.preventDefault()

    @validateFields(e)

  validateFields: (e) ->
    locationValue = @elLocationInput.val()
    usernameValue = @elUsernameInput.val()

    if locationValue isnt "" and usernameValue isnt ""
      alert "Please limit your input to location or username"

    else if locationValue is "" and usernameValue is ""
      alert "Please enter a username or location."

    else
      if locationValue isnt ""
        @selectedMode = @locationMode
        @selectedInput = @elLocationInput

      else if usernameValue isnt ""
        @selectedMode = @userMode
        @selectedInput = @elUsernameInput

      @submitTag()

  submitTag: () ->
    selectedTagName = @selectedInput.val()
    @tagToRoute(@selectedMode, selectedTagName)
    @selectedInput.blur()

    window.scrollTo(0, 0)

  reset: () ->
    @elTagPicker.fadeIn()
    @elInputs.val('')
    @elTagPickerSubmit.attr 'disabled', 'disabled'

  tagToRoute: (mode = @selectedMode, selectedTagName) ->
    Backbone.history.navigate "#/#{mode}/#{@encodeTagName(selectedTagName)}", trigger: true

  setTagName: (mode = @selectedMode, selectedTagName) ->
    @selectedTagName = selectedTagName

    $("##{mode}").val @decodeTagName(selectedTagName)

  getTagName: () ->
    @selectedTagName

  encodeTagName: (selectedTagName = @selectedTagName) ->
    selectedTagName.replace(' ','+')

  decodeTagName: (selectedTagName = @selectedTagName) ->
    selectedTagName.replace('+', ' ')

module.exports = InputSearchView
