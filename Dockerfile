FROM ruby:3.4.2

RUN mkdir /app
WORKDIR /app
ADD Gemfile /app
ADD Gemfile.lock /app

RUN gem install bundler && bundle install

ADD . /app/

ENTRYPOINT ["./scripts/start_search.rb"]