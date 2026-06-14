source "https://rubygems.org"

ruby "3.2.0"

gem "rails", "~> 7.1.0"
gem "sprockets-rails"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "bootsnap", require: false
gem "devise"
gem "active_hash"
gem "payjp"

group :development, :test do
  gem "debug", platforms: %i[ mri windows ]
  gem "mysql2", "~> 0.5"
  gem "dotenv-rails"
  gem "rspec-rails"
  gem "factory_bot_rails"
  gem "faker"
end

group :development do
  gem "web-console"
  gem "rubocop", "1.71.2", require: false
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end

group :production do
  gem "pg"
end