FROM ruby:2.7.1-buster

ENV APP_HOME=/opt/app \
  RAILS_SERVE_STATIC_FILES=true \
    BUNDLE_JOBS=4 \
    BUNDLE_PATH=/opt/bundle \
    PORT=3000 \
    PATH="/opt/app/bin:${PATH}"

  RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends libxml2-utils && \
    apt-get upgrade -y && \
    apt-get install -y -f imagemagick git && \
    apt-get autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    useradd -m app && \
    mkdir -p $APP_HOME && \
    mkdir -p $BUNDLE_PATH && \
    mkdir /home/app/.ssh/ && \
    chown -R app:app /opt $APP_HOME "$BUNDLE_PATH" /usr/local/bundle && \
    gem update --system && gem install bundler

WORKDIR $APP_HOME

# Switch to non-root user
USER app

# Install Ruby dependencies
COPY --chown=app:app Gemfile* ./
RUN bundle install && chown -R app:app $BUNDLE_PATH

# Expose passenger port
EXPOSE 3000

# Copy the app
COPY --chown=app:app . .

RUN mkdir -p tmp/pids log && chown -R app:app tmp log

# Start up
CMD ["rails", "server"]
