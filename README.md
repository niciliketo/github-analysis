# README

This is a  Rails application to retrieve data from the github API and present some reports.

It runs on Rails 6 and has beeen tested on Mac OS and Ubuntu using SQLLite

To get started

* Install dependencies
`bundle`

* Create database
`bundle exec rake db:migrate`

* Create cron job (to import new data hourly)
`whenever --update-crontab`
...or import it as a one-time thing
`rails runner 'PullRequest.generate_data'`

* Run server
`rails s`

* Visit `http://localhost:3000/reports/new` to see some reports