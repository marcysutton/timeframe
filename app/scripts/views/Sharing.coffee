config = require '../config'

class Sharing extends Backbone.View

  options:
    twitterUrl: 'https://twitter.com/share?url='
    id: 'ShareTimeframe'
    menubar: 'yes'
    location: 'yes'
    scrollbars: 'yes'
    status: 'no'
    resizable: 'yes'
    popupHeight: 490
    popupWidth: 600

  url: null

  el: '.share'

  events:
    "click a" : "openWindow"

  initialize: (router, options = {}) ->
    @router = router

    @$el = $(@el)

    _.defaults(options, @options)

    @setPopupOptions()

  getUrl: () ->
    @options.twitterUrl +
    '&text=' + encodeURI config.tweetText
    @router.getPageUrl() +

  setPopupOptions: (options) ->
    @optionsString = "width=#{@options.popupWidth},height=#{@options.popupHeight}"

  getPopupOptions: () ->
    @optionsString

  openWindow: (e) ->
    e.preventDefault()
    window.open(@getUrl(), @options.id, @getPopupOptions())

module.exports = Sharing
