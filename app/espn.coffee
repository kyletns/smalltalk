request = require('request')
apiKey = 'n5u6v22j4525znf95x8qcssj'

module.exports = ()->
  api
  # api.GetAthleteTrivia 2330, (headlines)->
  #   console.log headlines

	# api.GetAthleteDetails 'football', 'nfl', 2330, (details)->
	# 	console.log details

	# api.GetAthleteHeadlines 'football', 'nfl', 2330, (headlines)->
	# 	console.log headlines

api =

  GetSchedule: () ->
    url = "http://api.espn.com/v1/sports/basketball/mens-college-basketball/events/?disable=links%2Cvenues%2Cstats%2Cathletes%2Clinescores&dates=20130428&apikey=#{apiKey}"
    request url, (error, response, body) ->
      if (!error and response.statusCode is 200)
        results = JSON.parse(body)
        console.log results.sports[0].leagues[0].events


  GetAthleteTrivia: (athleteId, callback) ->
    url = "http://api.espn.com/v1/sports/news/notes/?athletes=#{athleteId}&apikey=#{apiKey}"
    request url, (error, response, body) ->
      if (!error and response.statusCode is 200)
        results = JSON.parse(body)
        console.log results
        #console.log results
        headlines = []
        for note in results.notes
          if (note.text.length < 400)
            headlines.push
              id: note.id
              headline: note.headline
              text: note.text

        return callback headlines

  GetAthleteHeadlines: (sport, league, athleteId, callback) ->
    url = "http://api.espn.com/v1/sports/#{sport}/#{league}/news/?athletes=#{athleteId}&apikey=#{apiKey}"
    #console.log url          
    request url, (error, response, body) ->
      if (!error and response.statusCode is 200)
        results = JSON.parse(body)
        headlines = []
        for headline in results.headlines
          headlines.push
            id: headline.id
            headline: headline.headline
            text: headline.description

        return callback headlines

  GetAthleteDetails: (sport, league, athleteId, callback) ->
    url = "http://api.espn.com/v1/sports/#{sport}/#{league}/athletes/#{athleteId}?apikey=#{apiKey}"
    request url, (error, response, body) ->
      if (!error and response.statusCode is 200)
        results = JSON.parse(body)
        details = results.sports?[0].leagues?[0].athletes?[0]
        return callback details

  GetTeamHeadlines: (opts) ->
    opts.teams = [6]
    opts.sport = 'basketball'
    opts.league = 'mens-college-basketball'

    url = "http://api.espn.com/v1/sports/#{sport}/#{league}/news/headlines/?teams=#{teams.join(',')}&_accept=application%2Fjson&apikey=#{apiKey}"
    request url, (error, response, body) ->
      if (!error and response.statusCode is 200)
        results = JSON.parse(body)
        headlines = results.headlines?[0].leagues?[0].athletes?[0]
        return opts.success headlines
      else
        return opts.failure()
