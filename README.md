# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

### Start Application USING FOREMAN

* In development mode:
```ruby
foreman start -f Procfile.dev
```

* In production mode:
```ruby
PORT=3000 foreman start -f Procfile
```