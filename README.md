# WeatherConditions

A simple application that prints weather conditions fetched from [National Weather Service's Hourly Aviation Weather Observations](http://w1.weather.gov/). This is a project challenge from [Programming Elixir](https://pragprog.com/book/elixir13/programming-elixir-1-3).

The data are only retrievable in XML format so I had to learn how to parse XML using the Erlang XML libraries.

### Use it

- Make sure you've got Erlang installed.
- Clone the repo: `git clone git@github.com:raderj89/weather_conditions.git`
- `cd weather_conditions`
- Run the app from the command line: `$ ./weather_conditions <location-code>`
  - e.g.: `$ ./weather_conditions kokc`

### TODO:
1. Add more tests
2. Add documentation
3. Scrape all the codes and match them to their locations so that users don't have to memorize codes and can look up which location codes they're interested in.
