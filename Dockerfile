# syntax = docker/dockerfile:1

# Make sure RUBY_VERSION matches the Ruby version in .ruby-version and Gemfile
ARG RUBY_VERSION=3.2.2
FROM quay.io/evl.ms/fullstaq-ruby:$RUBY_VERSION-jemalloc-slim as base

# Enable YJIT
ENV RUBY_YJIT_ENABLE=1

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


FROM base as dev

ENV BINDING 0.0.0.0

# Run shell
CMD ["bash"]

FROM base as build

COPY --link Gemfile Gemfile.lock ./

# Install application gems
RUN bundle install && \
    bundle exec bootsnap precompile --gemfile && \
    rm -rf ~/.bundle/ $BUNDLE_PATH/ruby/*/cache $BUNDLE_PATH/ruby/*/bundler/gems/*/.git

COPY --link package.json yarn.lock ./
#COPY --link .yarn/releases/* .yarn/releases/

# Install node modules
RUN yarn install --frozen-lockfile

# Copy application code
COPY --link . .

# Precompile bootsnap code for faster boot times
RUN bundle exec bootsnap precompile app/ lib/

FROM base as release

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
#COPY --link package.json yarn.lock ./
#COPY --link .yarn/releases/* .yarn/releases/

# Run and own only the runtime files as a non-root user for security
# Run and own only the runtime files as a non-root user for security
ARG UID=1000
ARG GID=1000
RUN groupadd -f -g $GID rails && \
    useradd -u $UID -g $GID rails --create-home --shell /bin/bash && \
    mkdir /data && \
    chown -R rails:rails db log storage tmp node_modules /data /usr/

USER rails:rails


# Deployment options
ENV RAILS_LOG_TO_STDOUT="1" \
    RAILS_SERVE_STATIC_FILES="true"

EXPOSE 3000

# Entrypoint prepares the database.
#ENTRYPOINT ["/rails/bin/docker-entrypoint"]
#ENTRYPOINT ["tail", "-f", "/dev/null"]

# Start the server by default, this can be overwritten at runtime
CMD ["./bin/rails", "server -b 0.0.0.0"]
