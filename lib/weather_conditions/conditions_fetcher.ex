defmodule WeatherConditions.ConditionsFetcher do
  @conditions_url Application.get_env(:weather_conditions, :conditions_url)
  alias WeatherConditions.XMLParser


  def fetch(location_code) do
    conditions_url(location_code)
    |> HTTPoison.get
    |> handle_response
  end

  def conditions_url(location_code) do
    "#{@conditions_url}#{location_code}"
  end

  def handle_response({:ok, %{status_code: 200, body: body}}) do
    {:ok, XMLParser.parse(body)}
  end

  def handle_response({:_, %{status_code: status, body: body}}) do
    {:error, XMLParser.parse(body)}
  end
end
