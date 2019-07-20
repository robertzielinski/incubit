# README

## Before commit

Make sure you have overcommit set before commit.

```
bundle install --gemfile=.overgems.rb
overcommit --sign
```

## Run locally

Ruby version 2.6.3

```
bundle
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rails s
```

## Run tests

```
bundle exec rake db:create RAILS_ENV=test
bundle exec rake db:schema:load RAILS_ENV=test
bundle exec rake rspec
```
