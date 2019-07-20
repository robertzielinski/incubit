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
rake db:create
rake db:migrate
bundle
rails s
```
