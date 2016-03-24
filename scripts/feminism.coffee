# Description:
#   Feminism Me
#
# Dependencies:
#   "jsdom": "0.2.14"
#
# Configuration:
#   None
#
# Commands:
#   hubot feminism me - Pull a random entry from feministmemes.tumblr.com
#
# Author:
#   williammck

http = require 'http'
jsdom = require 'jsdom'

module.exports = (robot) ->
  robot.respond /feminism me/i, (msg) ->
    options =
      host: 'feministmemes.tumblr.com',
      port: 80,
      path: '/random'

    # Random redirects us to another article, grab that url and respond.
    http.get options, (res) ->
      location = res.headers.location
      jsdom.env location, [ 'http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js' ], (errors, window) ->
        (($) ->
          img = $('#main article img').attr('src')

          msg.send img
        )(window.jQuery)
