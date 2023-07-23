FROM ruby:3.1.4
RUN apt-get update -qq && apt-get install -y postgresql-client
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

# Install Node
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
RUN apt-get install -y nodejs
RUN npm install --global yarn
# Update as per latest miniracer troubleshooting advice
# Can probably be removed in the future
# https://github.com/rubyjs/mini_racer
#RUN gem update --system
RUN bundle install

# Dont copy the app directory, as we will link the directory instead in docker-compose.yml
COPY . /app

# Add a script to be executed every time the container starts.
#COPY entrypoint.sh /usr/bin/
#RUN chmod +x /usr/bin/entrypoint.sh
#ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
