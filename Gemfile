source 'https://rubygems.org'
git_source(:github) { |_repo| "https://github.com/#{repo}.git" }

ruby '3.2.0'

gem 'bootsnap', require: false
gem 'dotenv-rails'
gem 'dry-monads'
gem 'dry-transaction'
gem 'health_check'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.4', '>= 7.0.4.2'
gem 'rest-client'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  # Debug
  gem 'pry-nav'
  gem 'pry-rails'

  # Quality assurance
  gem 'brakeman'
  gem 'reek'
  gem 'rubocop'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'

  # RSpec
  gem 'parallel_tests'
  gem 'rspec-rails'

  # Graphiql
  gem 'graphiql-rails'
end

group :development do
  gem 'solargraph', require: false
  gem 'spring'
  gem 'web-console'
end

group :test do
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rails-controller-testing'
  gem 'rspec-sidekiq'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
  gem 'vcr'
  gem 'webmock'
end
