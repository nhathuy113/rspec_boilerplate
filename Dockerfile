FROM ruby:3.2.2-slim

ENV BUNDLE_PATH=/usr/local/bundle \
    BUNDLE_JOBS=4 \
    BUNDLE_RETRY=3 \
    APP_HOME=/app

WORKDIR ${APP_HOME}

RUN apt-get update -qq \
    && apt-get install -y --no-install-recommends \
       build-essential \
       libsqlite3-dev \
       libpq-dev \
       default-libmysqlclient-dev \
       curl \
       git \
       bash \
    && rm -rf /var/lib/apt/lists/*

COPY Gemfile Gemfile.lock ./

RUN gem install bundler -v 2.4.10 \
    && bundle install

COPY . .

EXPOSE 3000

CMD ["bash", "-lc", "rm -f tmp/pids/server.pid && bundle exec rails server -p 3000 -b 0.0.0.0"]


