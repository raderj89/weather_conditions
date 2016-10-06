defmodule XMLParserTest do
  use ExUnit.Case
  require Record
  Record.defrecord :xmlElement, Record.extract(:xmlElement, from_lib: "xmerl/include/xmerl.hrl")
  Record.defrecord :xmlText, Record.extract(:xmlText, from_lib: "xmerl/include/xmerl.hrl")

  def sample_xml do
    """
    <?xml version="1.0" encoding="ISO-8859-1"?>
    <?xml-stylesheet href="latest_ob.xsl" type="text/xsl"?>
    <?xml-stylesheet href='latest_ob.xsl' type='text/xsl'?>
    <current_observation version="1.0">
    	<credit>NOAA's National Weather Service</credit>
    	<credit_URL>http://weather.gov/</credit_URL>
    	<image>
    		<url>http://weather.gov/images/xml_logo.gif</url>
    		<title>NOAA's National Weather Service</title>
    		<link>http://weather.gov</link>
    	</image>
    	<suggested_pickup>15 minutes after the hour</suggested_pickup>
    	<suggested_pickup_period>60</suggested_pickup_period>
    	<location>Oklahoma City, Will Rogers World Airport, OK</location>
    	<station_id>KOKC</station_id>
    	<latitude>35.38861</latitude>
    	<longitude>-97.60028</longitude>
    	<observation_time>Last Updated on Oct 5 2016, 3:52 pm CDT</observation_time>
      <observation_time_rfc822>Wed, 05 Oct 2016 15:52:00 -0500</observation_time_rfc822>
    	<weather>A Few Clouds</weather>
    	<temperature_string>89.0 F (31.7 C)</temperature_string>
    	<temp_f>89.0</temp_f>
    	<temp_c>31.7</temp_c>
    	<relative_humidity>43</relative_humidity>
    	<wind_string>from the South at 15.0 gusting to 23.0 MPH (13 gusting to 20 KT)</wind_string>
    	<wind_dir>South</wind_dir>
    	<wind_degrees>200</wind_degrees>
    	<wind_mph>15.0</wind_mph>
    	<wind_gust_mph>23.0</wind_gust_mph>
    	<wind_kt>13</wind_kt>
    	<wind_gust_kt>20</wind_gust_kt>
    	<pressure_string>1007.8 mb</pressure_string>
    	<pressure_mb>1007.8</pressure_mb>
    	<pressure_in>29.81</pressure_in>
    	<dewpoint_string>64.0 F (17.8 C)</dewpoint_string>
    	<dewpoint_f>64.0</dewpoint_f>
    	<dewpoint_c>17.8</dewpoint_c>
    	<heat_index_string>90 F (32 C)</heat_index_string>
      <heat_index_f>90</heat_index_f>
      <heat_index_c>32</heat_index_c>
    	<visibility_mi>10.00</visibility_mi>
     	<icon_url_base>http://forecast.weather.gov/images/wtf/small/</icon_url_base>
    	<two_day_history_url>http://www.weather.gov/data/obhistory/KOKC.html</two_day_history_url>
    	<icon_url_name>few.png</icon_url_name>
    	<ob_url>http://www.weather.gov/data/METAR/KOKC.1.txt</ob_url>
    	<disclaimer_url>http://weather.gov/disclaimer.html</disclaimer_url>
    	<copyright_url>http://weather.gov/disclaimer.html</copyright_url>
    	<privacy_policy_url>http://weather.gov/notice.html</privacy_policy_url>
    </current_observation>
    """
  end

  test "parsing the credit out" do
    { xml, _rest } = :xmerl_scan.string(String.to_char_list(sample_xml))
    # elements = :xmerl_xpath.string('/current_observation', xml)
    # mapped = Enum.map elements, &(xmlElement(&1, :content))

    content =
      ~w{credit suggested_pickup}
      |> Enum.flat_map(&(:xmerl_xpath.string('/current_observation/#{&1}', xml)))
      |> Enum.flat_map(&(xmlElement(&1, :content)))
      |> Enum.map(&(xmlText(&1, :value)))

    IO.inspect content
    # credit = credit_text.value

    # assert(credit == 'NOAA\'s National Weather Service')
  end
end
