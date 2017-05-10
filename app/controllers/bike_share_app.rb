class BikeShareApp < Sinatra::Base

  get '/' do
    erb :index
  end

#station dashboard with statistics
  get '/stations-dashboard' do
    @dashboard_data = Station.dashboard
    erb :'stations/dashboard'
  end

#station index landing page
  get '/stations' do
    @stations = Station.all
    erb :"stations/index"
  end

#form for new stations
  get '/stations/new' do
    @city = City.all
    erb :"stations/new"
  end

#single station page
  get '/stations/:id' do
    @station = Station.find(params[:id])
    @trip_individual_data = Station.individual_dashboard(params[:id].to_i)
    erb :"stations/show"
  end

#route after filling new station form
  post '/stations' do
    @station = Station.create_new(params)
    redirect "/stations/#{@station.id}"
  end

#form to edit station
  get '/stations/:id/edit' do
    @city = City.all
    @station = Station.find(params[:id])
    erb :"stations/edit"
  end

#route to update after editing station
  put '/stations/:id' do
    @station = Station.update_record(params)
    redirect "/stations/#{@station.id}"
  end

#route to delete single station
  delete '/stations/:id' do
    @station = Station.destroy(params[:id])
    redirect "/stations"
  end

  ###################################
  ##TRIPS
  ###################################

#trip dashboard with statistics
  get '/trips-dashboard' do
    @trips_dashboard_data = Trip.dashboard
    # binding.pry
    erb :'trips/dashboard'
  end

#trips index landing page
  get '/trips' do
    @params = {
      page: params['page'].to_i,
      status: true
    }
    @trips = Trip.limit(30).offset(@params[:page].to_i * 30)
    @params[:status] = false if @trips.count < 30
    erb :"/trips/index"
  end

  #trips index landing page
  get '/trips/page/:id' do
    @trips = Trip.limit(30).offset(params[:page].to_i*30)
    erb :"/trips/index_b"
  end

#form for new trips
  get '/trips/new' do
    @stations = Station.all
    @subscriptions = SubscriptionType.all
    erb :"trips/new"
  end

#single trip page
  get '/trips/:id' do

    @trip = Trip.find(params[:id])
    erb :'trips/show'
  end

#route after filling new trip form
  post '/trips' do
    trip = Trip.create_new(params)
    redirect "/trips/#{trip.id}"
  end

#form to edit trips
  get '/trips/:id/edit' do
    @trip = Trip.find(params[:id])
    @stations = Station.all
    @subscriptions = SubscriptionType.all
    erb :'trips/edit'
  end

  put '/trips/:id' do
    trip = Trip.update_record(params)
    redirect "/trips/#{trip.id}"
  end

#route to delete single trip
  delete '/trips/:id' do
    @trip = Trip.destroy(params[:id])
    redirect "/trips"
  end


###################################
##WEATHER
###################################

#weather dashboard with statistics
  get '/weather-dashboard' do
    @dashboard_data = WeatherStatistic.dashboard
    erb :'weather/dashboard'
  end

#weather index landing page
  get "/conditions" do
    @weather = WeatherStatistic.all
    erb :'weather/index'
  end

#form for new weather
  get '/conditions/new' do
    erb :'weather/new'
  end

#single weather page
  get '/conditions/:id' do
    @weather = WeatherStatistic.find(params[:id])
    erb :'weather/show'
  end

#route after filling new weather form
  post '/conditions' do
    @weather = WeatherStatistic.create_new(params)
    redirect "/conditions/#{@weather.id}"
  end

#form to edit weather
  get '/conditions/:id/edit' do
    @weather = WeatherStatistic.find(params[:id])
    erb :"weather/edit"
  end

#route to update after editing weather
  put '/conditions/:id' do
    @weather = WeatherStatistic.update_record(params)
    redirect "/conditions/#{@weather.id}"
  end

#route to delete single weather record
  delete 'conditions/:id' do
    @weather = WeatherStatistic.destroy(params[:id])
    redirect "/conditions"
  end

end
