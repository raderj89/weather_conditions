defmodule WeatherConditions.CLI do
  alias WeatherConditions.{ConditionsFetcher, XMLParser}
  import Issues.TableFormatter, only: [print_table_for_columns: 2]

  @columns ~w{
    location
    weather
    temperature_string
    wind_string
  }

  def main(argv) do
    argv
    |> parse_args
    |> process
  end

  def parse_args(argv) do
    parse = OptionParser.parse(
      argv,
      switches: [help: :booelan],
      aliases: [h: :help]
    )

    case parse do
      {[help: true], _} -> :help

      {_, [location_code], _} -> location_code

      _ -> :help
    end
  end

  def process(:help) do
    IO.puts """
    usage: weather_conditions <airport-code>
    """
    System.halt(0)
  end

  def process(location_code) do
    ConditionsFetcher.fetch(location_code)
    |> decode_response
    |> XMLParser.convert_xml_to_map(@columns)
    |> print_table_for_columns(@columns)
  end

  def decode_response({:ok, xml}), do: xml

  def decode_response({:error, error}) do
    {_, message} = List.keyfind(error, "message", 0)
    IO.puts "Error fetching from weather.gov: #{message}"
    System.halt(2)
  end
end
