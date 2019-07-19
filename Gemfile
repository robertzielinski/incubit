source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby File.read(File.expand_path('.ruby-version', __dir__)).chomp

#======
# CORE
#====

gem 'rails', '~> 5.2.3'
gem 'pg', '>= 0.18', '< 2.0'

gem 'bootsnap', '>= 1.1.0', require: false
gem 'puma', '~> 4.0.1'

#==========
# Frontend
#========

gem 'coffee-rails', '>= 5.0.0'
gem 'haml', '>= 5.1.1'
gem 'haml-rails'
gem 'sass-rails', '>= 5.0'
gem 'turbolinks', '>= 5'
gem 'uglifier', '>= 1.3.0'

#==========
# Security
#=======

gem 'bcrypt', '~> 3.1.12'

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'

  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :development, :test do
  gem 'pry'
end

group :test do
  gem 'rails-controller-testing'
  gem 'rspec-rails', '~> 3.8'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
