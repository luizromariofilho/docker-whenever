FROM ruby:2.7.2
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client cron locales

RUN echo "pt_BR.UTF-8 UTF-8" > /etc/locale.gen
RUN locale-gen
RUN export LC_ALL="pt_BR.utf8"

WORKDIR /api
COPY /api/Gemfile /api/Gemfile
COPY /api/Gemfile.lock /api/Gemfile.lock
RUN bundle install

# Add a script to be executed every time the container starts.
COPY ./docker/api/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Create empty crontab file
RUN crontab -l | { cat; echo ""; } | crontab -

COPY /api/config/schedule.rb /api/config/schedule.rb
# Update crontab file using whenever command
RUN bundle exec whenever --update-crontab

# Start the main process.
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
