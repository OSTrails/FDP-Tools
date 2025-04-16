# frozen_string_literal: false

require_relative '../../lib/fdp_tools'

def set_routes(classes: allclasses)
  set :server_settings, timeout: 180
  set :public_folder, 'public'
  set :server, 'webrick'
  set :bind, '0.0.0.0'
  set :views, 'application/views'
  enable :cross_origin
  options '*' do
    response.headers['Allow'] = 'GET, PUT, POST, DELETE, OPTIONS'
    response.headers['Access-Control-Allow-Headers'] = 'Authorization, Content-Type, Accept, X-User-Email, X-Auth-Token'
    response.headers['Access-Control-Allow-Origin'] = '*'
    200
  end

  before do
    response.headers['Access-Control-Allow-Origin'] = '*'
  end

  abort 'FDP_PROXY_HOST not set' unless ENV['FDP_PROXY_HOST']
  abort 'FDP_PROXY_METHOD not set' unless ENV['FDP_PROXY_METHOD']
  abort 'FDP_INDEX not set' unless ENV['FDP_INDEX']

  get '/' do
    redirect '/fdp-tools/'
  end
  get %r{/fdp-tools/?} do
    content_type :json
    '{}' # eventually return the interface
  end

  # this is the FDP Index calling us for a record
  get '/fdp-tools/tests' do # ?url=https://....
    unless params[:metricid]
      error 400
      halt
    end
    @metrics = FdpTools::FDP.get_tests_for_metric(metricid: params[:metricid])

    unless graph # might be false if it doesn't exist
      error 400
      halt
    end

    request.accept.each do |type|
      case type.to_s
      when 'application/json'
        content_type :json
        halt @metrics.to_json
      when 'text/plain'
        content_type :text
        halt @metrics.join ','
      when 'text/html'
        content_type :html
        halt @metrics.join ','
      else # for the FDP index send turtle by default
        error 406
        halt
      end
    end
    error 406
  end
end
