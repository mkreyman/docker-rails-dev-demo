# Following tutorials at
# http://blog.codeship.com/running-rails-development-environment-docker/
# http://blog.carbonfive.com/2015/03/17/docker-rails-docker-compose-together-in-your-development-workflow/

# https://docs.docker.com/articles/dockerfile_best-practices/
# Docker Compose https://docs.docker.com/compose/

# Command history
$ cd ..
$ chruby
$ chruby ruby-2.2.2
$ gem install rails bundler
$ rails new docker-rails-dev-demo
$ cd docker-rails-dev-demo/
$ bundle exec spring binstub --all
$ bundle install
$ subl Dockerfile
$ subl Readme.txt
$ subl .ruby-version
$ docker build -t docker-rails-dev-demo .
$ docker run -it docker-rails-dev-demo "rake test"
$ docker ps
$ eval $(docker-machine env default)
$ docker ps
$ docker run -itP docker-rails-dev-demo
$ docker-machine ip
$ docker ps

# Adding a volume
# https://docs.docker.com/reference/builder/#volume
$ docker run -itP -v $(pwd):/app docker-rails-dev-demo

$ subl .dockerignore
$ subl docker-compose.yml
$ docker pull mysql:5.6
$ subl Gemfile
$ docker-compose build
$ docker-compose run -it web env
$ docker-compose run -it mysql env
$ subl .gitignore
$ subl .env.web
$ subl config/database.yml
$ docker-compose build
$ touch .env.db
$ docker-compose build
$ docker-compose up
$ docker images
$ docker-machine ls
$ docker ps -a

# One liner to stop / remove all of Docker containers:
$ docker stop $(docker ps -a -q)
$ docker rm $(docker ps -a -q)
$ docker rmi $(docker images -a | grep "^<none>" | awk "{print $3}")

$ docker images
$ docker rmi dockerrailsdevdemo_web
$ docker rmi dockerrailsdevdemo_app
$ docker images
$ docker rmi docker-rails-dev-demo
$ docker images
$ docker rmi $(docker images -a | grep "^<none>" | awk "{print $3}")
$ docker images
$ docker-compose build
$ docker ps

# To start containers in 'detached' mode
$ docker-compose up -d

# A way to run migrations without spinning up a new container
$ docker exec web_1 rake db:create db:migrate

# Access shell
$ docker exec -it web_1 /bin/bash

$ docker-compose run web env
$ docker-compose stop
$ docker-compose --help

# Add docker-machine IP to /etc/hosts, i.e.
  192.168.99.100 dockerhost

# ... then use it to connect via web browser:
  http://dockerhost:3000

# ... or with mysql client:
  host: dockerhost
  username: root
  database: docker_rails_dev_demo
  port: 13306



