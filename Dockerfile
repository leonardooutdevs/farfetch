FROM ruby:3.2.0-alpine

RUN apk add --update --virtual \
  runtime-deps \
  postgresql-client \
  build-base \
  libxml2-dev \
  libxslt-dev \
  nodejs \
  yarn \
  libffi-dev \
  readline \
  build-base \
  postgresql-dev \
  sqlite-dev \
  libc-dev \
  linux-headers \
  readline-dev \
  file \
  git \
  tzdata \
  gcc \
  g++ make python3 \
  make \
  python3 \
  gcompat \
  && rm -rf /var/cache/apk/*

# DEFINE PATH
ENV INSTALL_PATH /farfetch

# CREATE DIR
RUN mkdir -p $INSTALL_PATH
WORKDIR $INSTALL_PATH

# BUILD GEMFILE
COPY Gemfile Gemfile.lock ./
RUN gem install bundler --pre
RUN bundle install

# COPY PROJECT FOR CONTAINER
COPY . $INSTALL_PATH

RUN bundle install

EXPOSE 80

RUN ["chmod", "+x", "bin/docker-entrypoint-web.sh"]

# ENTRYPOINT ["sh", "bin/docker-entrypoint-web.sh"]

# exec bundle exec rails server -p 80 -b 0.0.0.0

CMD ["bundle", "exec", "rails", "server", "-p", "3000", "-b", "0.0.0.0"]