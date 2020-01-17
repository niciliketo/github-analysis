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

* Create a github application
(this is used to authenticate users)
https://developer.github.com/apps/building-github-apps/creating-a-github-app/
Save the credentials in the credentials file
`EDITOR="code --wait" rails credentials:edit`
Format this way:
`````
github_oath_app:
  client_id: '<CLIENT_ID_FROM_GITHUB>'
  client_secret: '<CLIENT_SECRET_FROM_GITHUB>'
`````
* Run server
`rails s`

* Visit `http://localhost:3000/reports/new` to login and see some reports