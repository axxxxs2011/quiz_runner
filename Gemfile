source 'https://rubygems.org'

gem 'rails', '4.0.0'
gem 'slim'
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
gem 'jquery-rails'
gem 'jbuilder', '~> 1.2'

group :doc do
  gem 'sdoc', require: false
end

group :development do
  gem 'pry-rails'
end

group :development, :test do
  gem 'thin'
  gem 'sqlite3'
end

group :production do
  gem 'unicorn'
  gem 'pg'
  gem 'rails_12factor'
end
