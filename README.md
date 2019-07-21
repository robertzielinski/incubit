# README

## Before commit

Make sure you have overcommit set before commit.

```
bundle install --gemfile=.overgems.rb
overcommit --sign
```

## Run locally

Ruby version 2.6.3

Set reCAPTCHA v2 Checkbox ("I'm not a robot" Checkbox) keys in .env file.
You can get your own keys [here](https://www.google.com/recaptcha).
Keys provided below are just sample keys to run project quickly on localhost. Generate your own and keep securely when deploying on production.

```
RECAPTCHA_SITE_KEY = '6Le4r64UAAAAALdE2Pouj83oy01nKySAHukpxEzF'
RECAPTCHA_SECRET_KEY = '6Le4r64UAAAAABXf8rpAbS9ou8S2Ezxh65tkqgWp'
```

```shell
bundle
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rails s
```

## Run tests

```shell
bundle exec rake db:create RAILS_ENV=test
bundle exec rake db:schema:load RAILS_ENV=test
bundle exec rake rspec
```
