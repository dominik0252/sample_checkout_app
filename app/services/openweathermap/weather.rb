module OpenWeatherMap

  class Weather
    def initialize(args = {})
      args.each do |name, value|
        attr_name = name.to_s.underscore
        send("#{attr_name}=", value) if respond_to?("#{attr_name}")
      end
    end

    attr_accessor :coord,
                  :weather,
                  :main,
                  :wind,
                  :clouds,
                  :sys


    def self.for_city(name_en)
      path = 'weather'
      query_params = { 'q': "#{name_en}", 'units': 'metric' }
      response, status = OpenWeatherMap::Request.get_json(path, query_params)

      if status == 200
        return Weather.new(response)
      else
        return nil
      end
    end

    def current_temperature
      return self.main['temp']
    end
    def current_weather_icon
      return self.weather[0]['icon']
    end
  end
end
