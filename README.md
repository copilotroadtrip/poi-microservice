# Co-Pilot - Points of Interest (POI) Microservice

`poi-microservice` is a Sinatra microservice as part of Co-Pilot.

**Co-Pilot** is a full stack application that allows users who are road tripping to keep track of all the cities and towns they will encounter on their journey. Information regarding the distance and time is displayed between each city. And upon clicking a particular city users can find weather, hotel, gas, food, and google maps information.

Live poi-mircoserive lin: https://poi-microservice.herokuapp.com/

Backend Rails API Repo: https://github.com/copilotroadtrip/CoPilotBackend

Frontend React Native Repo: https://github.com/copilotroadtrip/Co-Pilot


## Contributors

Backend Team
- [Matt Levy](https://github.com/milevy1)
- [William Peterson](https://github.com/wipegup)

Frontend Team
- [Saad Baradan](https://github.com/saadricklamar)
- [Theo Bean](https://github.com/b3an5)


## Tech Stack

- [Ruby 2.4.1](https://www.ruby-lang.org/en/)
- [Sinatra 2.0.5](http://sinatrarb.com/)
- [Heroku](https://heroku.com)


## Setup

1. Install Ruby 2.4.1.  For instructions on setting up multiple versions of Ruby, we reccomend [rbenv](https://github.com/rbenv/rbenv)

2. Install database system [PostgreSQL](https://www.postgresql.org/).

3. From your terminal, clone down this repo:

`git clone git@github.com:copilotroadtrip/CoPilotBackend.git`

4. Install Ruby gem dependencies

`bundle install`

6. Database creation, migrations, and seed with data about points of interest

`rake db:{create,migrate,seed}`

7. Start your local Sinatra server

`bundle exec shotgun`

8. Start up your local Redis server

`redis-server`


## Endpoints

### `POST https://poi-microservice.herokuapp.com/api/v1/build_trip`

- Converts "steps data" (coming from [Google Directions API](https://developers.google.com/maps/documentation/directions/intro)) and populates CoPilotBackend database with relevant information about a trip.  
- This was done to allow long running calculations to run asynchronously to allow a better user experience.

Required body:

```json
{
  "step": "<step_info>",
  "token": "<token>"
}
```

Response:

- The response currently times out due to Heroku behavior for long running processes.  However, the process still runs and populates the CoPilotBackend database correctly.
