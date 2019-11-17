module ApplicationHelper
  def app_title
    "Sample Checkout App"
  end

  def full_title(page_title='')
    page_title.empty? ? app_title : page_title + " | " + app_title
  end

  def current_temperature
    OpenWeatherMap::Weather.for_city('Zagreb').current_temperature.round
  end

  def current_weather_icon
    OpenWeatherMap::Weather.for_city('Zagreb').current_weather_icon
  end
end
