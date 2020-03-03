# README

Project Setup:

* Create `.env` file, with structure from `.env.example`

* Generete secret_key_base through `rake secret`  and add to .env

* Run `bundle install`

* Run `rails db:create db:migrate`

* For delay jobs in second tab run `bundle exec sidekiq -q default`

* Run `rails s`

