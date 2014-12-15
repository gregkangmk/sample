require 'json'
require 'redis'

class CloudCredo < Sinatra::Base
  configure do
    redis_service = JSON.parse(ENV['VCAP_SERVICES'])["redis"]
    credentials = redis_service.first["credentials"]
    $redis = Redis.new(:host => credentials["hostname"], :port => credentials["port"])
  end

  get '/' do
    'Cloud Foundry 도커 테스트!'
  end

  get '/set/:key/to/:value' do
    $redis.set(params[:key], params[:value])
    "set #{params[:key]} to #{params[:value]}"
  end
  
  get '/get/:key' do
    $redis.get(params[:key])
  end
end
