# Ruby on Rails Tutorial

## [sample_app](https://tranquil-thicket-95668.herokuapp.com/)

This is the third application for the [*Ruby on Rails Tutorial*](http://railstutorial.jp/)
by [Michael Hartl](http://www.michaelhartl.com/). Hello, world!

### Tips I lerned from this app

### Install

Clone this repo.

    git clone https://github.com/MasayaHayashi724/rails-tutorial-sample-app.git

Update and install Ruby Gems.

    bundle update
    bundle install --without production

Implement migration into database.

    rails db:migrate

Get through test.

    rails test

Build server if you pass the test.

    rails server

### Deployment on Heroku server

Log in to heroku, and add SSH key.

    heroku login
    heroku keys:add

Create Heroku App.

    heroku create

Deploy on Heroku.

    git push heroku master

If failed, add remote.

    heroku git:remote -a <Heroku App name>

Reset database, and implement migration, seed.

    heroku pg:reset DATABASE -c <Heroku App name>
    heroku run rails db:migrate
    heroku run rails db:seed
    heroku restart

---

Get more infomation from [*Ruby on Rails Tutorial*](http://railstutorial.jp/)
