FROM ruby:3-bookworm

ENV SETUPDIR=/setup
WORKDIR ${SETUPDIR}
ARG GEMFILE_DIR=.
COPY $GEMFILE_DIR/Gemfile* $GEMFILE_DIR/packages* ./

# Install build dependencies
RUN set -eux; \
    apt update && \
    apt upgrade -y

# Install Bundler
RUN set -eux; gem install bundler

# Install gems from `Gemfile` via Bundler
RUN set -eux; bundler install

# Remove build dependencies
RUN set -eux; apt clean

# Clean up
WORKDIR /srv/jekyll
RUN set -eux; \
    rm -rf \
        ${SETUPDIR} \
        /usr/gem/cache \
        /root/.bundle/cache \
    ;

EXPOSE 4000
ENTRYPOINT ["bundle", "exec", "jekyll"]
CMD ["--version"]
