FROM ruby:3-bookworm

ENV APPDIR=/srv/jekyll
WORKDIR ${APPDIR}
ARG GEMFILE_DIR=.
COPY $GEMFILE_DIR/Gemfile* $GEMFILE_DIR/packages* ./

# Install build dependencies
RUN set -eux; \
    apt update && \
    apt upgrade -y && \
    apt install -y ruby-dev


RUN set -eux; bundle config build.nokogiri --use-system-libraries && \
    bundle install

# Remove build dependencies + cleanup
COPY . ${APPDIR}
RUN set -eux; \
    apt clean; \
    rm -rf \
        /usr/gem/cache \
        /root/.bundle/cache \
    ;

EXPOSE 4000
CMD ["bundle", "exec", "jekyll", "serve", "-H", "0.0.0.0"]
