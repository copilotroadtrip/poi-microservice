require 'sinatra/base'

class PoiServiceApp < Sinatra::Base
  set :root, File.expand_path("..",__dir__)
end
