FROM ruby:2.2-slim

MAINTAINER marko@kreyman.com

# Install apt based dependencies required to run Rails as
# well as RubyGems. As the Ruby image itself is based on a
# Debian image, we use apt-get to install those.
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  nodejs \
  libmysqlclient-dev \
  mysql-client \
  vim && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Configure the main working directory.
RUN mkdir -p /app

# Copy the Gemfile as well as the Gemfile.lock and install
# the RubyGems. This is a separate step so the dependencies
# will be cached unless changes to one of those two files
# are made.
WORKDIR /tmp
#COPY Gemfile Gemfile
#COPY Gemfile.lock Gemfile.lock
COPY Gemfile Gemfile.lock /tmp/
RUN bundle install && bundle install --jobs 20 --retry 5

# This is the base directory used in any
# further RUN, COPY, and ENTRYPOINT commands.
WORKDIR /app

# Copy the main application.
ADD . /app

# Expose port 3000 to the Docker host, so we can access it
# from the outside.
EXPOSE 3000

# Configure an entry point, so we don't need to specify
# "bundle exec" for each of our commands.
ENTRYPOINT ["bundle", "exec"]

# The main command to run when the container starts. Also
# tell the Rails dev server to bind to all interfaces by
# default.
CMD ["rails", "server", "-b", "0.0.0.0"]
