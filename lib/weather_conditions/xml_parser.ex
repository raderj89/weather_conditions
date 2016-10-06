defmodule WeatherConditions.XMLParser do
  require Record
  Record.defrecord :xmlElement, Record.extract(:xmlElement, from_lib: "xmerl/include/xmerl.hrl")
  Record.defrecord :xmlText, Record.extract(:xmlText, from_lib: "xmerl/include/xmerl.hrl")

  def parse(string) do
    string |> scan_text
  end

  def scan_text(text) do
    {xml, _rest } = text |> String.to_char_list |> :xmerl_scan.string
    xml
  end

  def convert_xml_to_map(xml, columns) do
    content =
      columns
      |> Enum.flat_map(&(:xmerl_xpath.string('/current_observation/#{&1}', xml)))
      |> Enum.flat_map(&(xmlElement(&1, :content)))
      |> Enum.map(&(xmlText(&1, :value)))

    [Enum.zip(columns, content)
    |> Enum.into(Map.new)]
  end
end
