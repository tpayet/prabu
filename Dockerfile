FROM ruby:2.6.1

MAINTAINER thomas@meilisearch.com

COPY Gemfile .

RUN bundle install

COPY . .

CMD ["ruby", "prabu.rb"]
