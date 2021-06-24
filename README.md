
1 - Create folder docker with files:
 1.1 - docker/api/Dockerfile
 1.2 - docker/api/entrypoint.sh
 1.3 - docker/sidekiq/entrypoint.sh
 1.4 - docker/web/Dockerfile
2 - Create .env file and api/.env file
3 - Create docker-compose.yml

mkdir api
touch api/Gemfile.lock
touch api/Gemfile
  source 'https://rubygems.org'
  gem 'rails'

Run a command to create rails project 
 cd api/ && docker-compose run --rm --no-deps web rails new . --force --database=postgresql

if Linux user 
 sudo chown -R $USER:$USER .

Create files .env.sample && api/database
Create setup.sh && up.sh
Create .gitignore && api/.gitignore && .dockerignore


Run a command to create angular project
ng new <application name>
mv <application name> web

Create iniatilizers/active_job.rb && initializers/ams.rb && initializers/sidekiq.rb
Create lib/health_check.rb


run setup.sh
run up.sh

Configure config/application.rb

docker-compose exec api rails g rspec:install

Create spec/support/database_cleaner.rb && spec/support/factory_bot.rb && spec/support/request_spec_helper.rb && spec/support/should_matchers.rb

Add gems to Gemfile
gem 'delayed_job_active_record'
gem 'whenever', require: false

docker-compose build

docker-compose exec api rails generate delayed_job:active_record
docker-compose exec api wheneverize .
docker-compose exec api rails db:migrate


Validate
docker exec -it <docker cron_job container> bash
