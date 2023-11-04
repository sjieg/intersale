# syntax = docker/dockerfile:1

# Make sure RUBY_VERSION matches the Ruby version in .ruby-version and Gemfile
ARG RUBY_VERSION=3.2.2
FROM ruby:$RUBY_VERSION-slim as base

# Rails app lives here
WORKDIR /rails

# Set production environment
ENV RAILS_ENV="development" \
    BUNDLE_WITHOUT="development:test" \
    BUNDLE_DEPLOYMENT="1"

# Install packages needed to build gems and node modules
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl build-essential libpq-dev node-gyp pkg-config python-is-python3 postgresql-client && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Update gems and bundler
RUN gem update --system --no-document && \
    gem install -N bundler

# Install JavaScript dependencies
ARG NODE_VERSION=19.6.0
ARG YARN_VERSION=1.22.19
ENV PATH=/usr/local/node/bin:$PATH
RUN curl -sL https://github.com/nodenv/node-build/archive/master.tar.gz | tar xz -C /tmp/ && \
    /tmp/node-build-master/bin/node-build "${NODE_VERSION}" /usr/local/node && \
    npm install -g yarn@$YARN_VERSION && \
    rm -rf /tmp/node-build-master

COPY --link Gemfile Gemfile.lock ./
COPY --link .yarnrc package.json yarn.lock ./
COPY --link .yarn/releases/* .yarn/releases/


FROM base as build

# Install application gems
RUN bundle install && \
    bundle exec bootsnap precompile --gemfile && \
    rm -rf ~/.bundle/ $BUNDLE_PATH/ruby/*/cache $BUNDLE_PATH/ruby/*/bundler/gems/*/.git

# Install node modules
RUN yarn install --frozen-lockfile

# Copy application code
COPY --link . .

# Precompile bootsnap code for faster boot times
RUN bundle exec bootsnap precompile app/ lib/

FROM base

# Copy built artifacts: gems, application
COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /rails /rails

# Copy node for development environment
COPY --from=build /usr/local/node /usr/local/node
COPY --from=build /usr/local/node/bin/* /usr/local/node/bin
# Copy npm for development environment
#COPY --from=build /usr/local/node/bin/npm /usr/local/bin/npm
## Copy yarn for development environment
#COPY --from=build /usr/local/node/bin/yarn /usr/local/bin/yarn
#COPY --from=build /usr/local/node/bin/yarnpkg /usr/local/bin/yarnpkg

# Copy yarn for development environment
COPY --link .yarnrc package.json yarn.lock ./
COPY --link .yarn/releases/* .yarn/releases/

RUN bin/vite build --clear --mode=development

# Run and own only the runtime files as a non-root user for security
RUN useradd rails --create-home --shell /bin/bash && \
    chown -R rails:rails db log storage tmp public

USER rails:rails


# Deployment options
ENV RAILS_LOG_TO_STDOUT="1" \
    RAILS_SERVE_STATIC_FILES="true"

EXPOSE 3000

# Entrypoint prepares the database.
#ENTRYPOINT ["/rails/bin/docker-entrypoint"]
ENTRYPOINT ["tail", "-f", "/dev/null"]

# Start the server by default, this can be overwritten at runtime

#CMD ["./bin/rails", "server -b 0.0.0.0"]
