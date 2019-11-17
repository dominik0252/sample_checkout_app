require 'faraday'
require 'json'

module OpenWeatherMap

  class Connection
    BASE = 'http://api.openweathermap.org/data/2.5/'

    def self.api
      Faraday.new(url: BASE) do |faraday|
        faraday.response :logger
        faraday.adapter  Faraday.default_adapter
        faraday.headers['Content-Type'] = 'application/json'
      end
    end
  end

end
