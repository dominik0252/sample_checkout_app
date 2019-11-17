module OpenWeatherMap

  class Request
    class << self
      def api
        OpenWeatherMap::Connection.api
      end

      def get_json(root_path, query = {})
        query['appid'] = Rails.application.credentials.openweather_api_key
        query_string = query.map{|k,v| "#{k}=#{v}"}.join('&')
        path = query.empty? ? root_path : root_path + '?' + query_string
        response = api.get path
        [JSON.parse(response.body), response.status]
      end
    end
  end

end
