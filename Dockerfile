FROM ruby:3.0.3-alpine3.15

RUN gem i excon -v 0.89.0

WORKDIR /app

ADD . ./

ENV CIRCLE_API_KEY $CIRCLE_API_KEY

CMD ruby circle_payments.rb
