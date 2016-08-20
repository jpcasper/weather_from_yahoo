class ReportsController < ApplicationController
  def index
    city = params[:city] || "Chicago"
    state = params[:state] || "IL"


    initial_response = Unirest.get("https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22#{city}%2C%20#{state}%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys").body
      @report = initial_response["query"]["results"]["channel"]
      @temp = @report["item"]["condition"]["temp"]
      @temp_unit = @report["units"]["temperature"]

      @forecasts = @report["item"]["forecast"].first(5)
      @city = @report["location"]["city"]
      @state = @report["location"]["region"]

      image_description = @report["item"]["description"]
    
  end
end
