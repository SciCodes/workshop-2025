# =============================================================================
# Modern Jekyll Dockerfile for SciCodes Workshop 2025 Site
# =============================================================================
# Uses Ruby 3.3 on Debian Bookworm for github-pages compatibility.
# Implements layer caching so gems are only rebuilt when Gemfile changes.
# =============================================================================

FROM ruby:3.3-bookworm

# OCI image labels for container metadata
LABEL org.opencontainers.image.title="SciCodes Workshop 2025 Site"
LABEL org.opencontainers.image.description="Jekyll site for SciCodes Workshop 2025"
LABEL org.opencontainers.image.source="https://github.com/scicodes/workshop-2025"
LABEL org.opencontainers.image.licenses="MIT"
LABEL maintainer="SciCodes Team"

# Application directory and bundler path
ENV APPDIR=/srv/jekyll
ENV BUNDLE_PATH=/usr/local/bundle

WORKDIR ${APPDIR}

# ---------------------------------------------------------------------------
# Layer 1: install system build deps (as root)
# ---------------------------------------------------------------------------
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        ruby-dev \
        zlib1g-dev \
        curl \
    && rm -rf /var/lib/apt/lists/*

# ---------------------------------------------------------------------------
# Layer 2: copy Gemfile/Gemfile.lock first for caching, then install gems
# ---------------------------------------------------------------------------
COPY Gemfile Gemfile.lock ./

RUN bundle config set --local build.nokogiri --use-system-libraries && \
    bundle install && \
    rm -rf /usr/local/bundle/cache

# ---------------------------------------------------------------------------
# Layer 3: copy the rest of the application
# ---------------------------------------------------------------------------
COPY . ./

# Expose Jekyll's default dev server port
EXPOSE 4000

# Health check: verify Jekyll is serving (default baseurl is /workshop-2025)
HEALTHCHECK --interval=30s --timeout=10s --start-period=10s --retries=3 \
    CMD curl -f http://localhost:4000/workshop-2025/ || exit 1

# Serve with live reload for development
CMD ["bundle", "exec", "jekyll", "serve", "-H", "0.0.0.0", "--livereload"]
