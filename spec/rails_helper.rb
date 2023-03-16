ENV['RACK_ENV'] = 'test'
ENV['RAILS_ENV'] = 'test'
require 'spec_helper'
require_relative '../config/environment'
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'

Dir[Rails.root.join(*%w[spec support ** *.rb])].each { |file| require file }

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => exception
  abort exception.to_s.strip
end
RSpec.configure do |config|
  config.fixture_path = Rails.root.join('spec/fixtures')
  config.include FactoryBot::Syntax::Methods
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end

RSpec::Sidekiq.configure do |config|
  config.warn_when_jobs_not_processed_by_sidekiq = false
end

RSpec::Matchers.define_negated_matcher :not_change, :change

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
