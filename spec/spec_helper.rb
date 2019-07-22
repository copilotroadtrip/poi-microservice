
ENV["RACK_ENV"] = "test"

require 'bundler'
# require 'webmock/rspec'
Bundler.require(:default, :test)
require File.expand_path('../../config/environment.rb', __FILE__)
require 'capybara/dsl'

Capybara.app = PoiServiceApp
Capybara.save_path = 'tmp/capybara'

DatabaseCleaner.strategy = :truncation

module RSpecMixin
  include Rack::Test::Methods
  def app() PoiServiceApp end
end

RSpec.configure do |c|
  c.include Capybara::DSL
  c.include FactoryBot::Syntax::Methods
  c.before(:all) do
    DatabaseCleaner.clean
  end
  c.after(:each) do
    DatabaseCleaner.clean
  end

  c.before(:suite) do
    FactoryBot.find_definitions
  end


  c.include RSpecMixin
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec

    # Keep as many of these lines as are necessary:
    with.library :active_record
    with.library :active_model
  end
end
