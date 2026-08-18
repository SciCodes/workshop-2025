# =============================================================================
# Makefile for SciCodes Workshop 2025 — Jekyll / GitHub Pages site
# =============================================================================
# Common targets:
#   make help          show this help
#   make serve         serve locally with live reload (Docker, primary path)
#   make serve-native  serve locally with live reload (native bundler)
#   make build         production build into _site/
#   make check         run htmlproofer against the built site (if installed)
#   make clean         remove _site/ and Jekyll caches
#
# Docker is the primary development path (see Dockerfile + docker-compose.yml).
# Native targets require a working Ruby + Bundler toolchain.
# =============================================================================

# --- Configuration -----------------------------------------------------------
JEKYLL_ENV    ?= development
HOST          ?= 0.0.0.0
PORT          ?= 4000
BASEURL       ?= /workshop-2025
DOCKER_COMPOSE := docker compose
IMAGE         := scicodes-2025-site:latest

# Jekyll / Bundler
BUNDLE_PATH   ?= vendor/bundle
JEKYLL_FLAGS  := --livereload --incremental --drafts
JEKYLL_BUILD  := bundle exec jekyll build
JEKYLL_SERVE  := bundle exec jekyll serve

# Build outputs to clean
CLEAN_TARGETS := _site .jekyll-cache .jekyll-metadata .sass-cache

# --- Default target ----------------------------------------------------------
.DEFAULT_GOAL := help

# --- Phony targets -----------------------------------------------------------
.PHONY: help install serve serve-native stop logs shell \
        build build-native check check-native clean clean-docker \
        docker-build docker-up docker-down docker-logs \
        update vendor

# --- Self-documenting help ---------------------------------------------------
help: ## Show this help message
	@awk 'BEGIN { \
		printf "\n\033[1mSciCodes Workshop 2025 — Jekyll site\033[0m\n"; \
		printf "Usage: make \033[36m<target>\033[0m\n\n"; \
	} \
	/^[a-zA-Z_-]+:.*##/ { \
		split($$0, a, ":"); \
		split(a[2], d, "##"); \
		printf "  \033[36m%-18s\033[0m %s\n", a[1], d[2]; \
	} \
	/^##@/ { \
		split($$0, h, "@"); \
		printf "\n\033[1m%s\033[0m\n", h[2]; \
	}' $(MAKEFILE_LIST)

##@ Setup
install: ## Install Ruby gems via Bundler (native)
	bundle config set --local path $(BUNDLE_PATH)
	bundle install

vendor: install ## Alias for install (populate vendor/bundle)

update: ## Update Bundler-managed gems
	bundle update

##@ Local development (Docker — primary path)
serve: docker-build docker-up ## Serve with live reload via Docker (primary, served at root)
	@echo "→ Site served at http://localhost:$(PORT)/"
	@echo "  (live reload enabled; press Ctrl-C to stop, then 'make stop' to tear down)"

docker-build: ## Build the Docker image
	$(DOCKER_COMPOSE) build

docker-up: ## Start the site container in the foreground
	$(DOCKER_COMPOSE) up

stop: docker-down ## Alias for down

docker-down: ## Stop and remove the site container
	$(DOCKER_COMPOSE) down

logs: docker-logs ## Alias for logs

docker-logs: ## Tail site container logs
	$(DOCKER_COMPOSE) logs -f

shell: ## Open a shell in the running site container
	$(DOCKER_COMPOSE) exec site bash

##@ Local development (native Bundler)
serve-native: ## Serve with live reload at root using local Ruby/Bundler
	JEKYLL_ENV=$(JEKYLL_ENV) $(JEKYLL_SERVE) \
		--host $(HOST) --port $(PORT) --baseurl "" $(JEKYLL_FLAGS)

##@ Production build
build: ## Production build into _site/ via Docker
	JEKYLL_ENV=production $(DOCKER_COMPOSE) run --rm --no-deps \
		-e JEKYLL_ENV=production site \
		$(JEKYLL_BUILD) --baseurl "$(BASEURL)"

build-native: ## Production build into _site/ using local Ruby/Bundler
	JEKYLL_ENV=production $(JEKYLL_BUILD) --baseurl "$(BASEURL)"

##@ Validation
check: ## Run htmlproofer against _site/ (Docker, internal links only)
	@test -d _site || $(MAKE) build
	$(DOCKER_COMPOSE) run --rm --no-deps site \
		bundle exec htmlproofer _site \
		--allow-hash-href --assume-extension=.html \
		--ignore-empty-alt --ignore-missing-alt \
		--disable-external --no-enforce-https \
		--swap-urls '^/workshop-2025/:/'

check-native: ## Run htmlproofer against _site/ (native, internal links only)
	@test -d _site || $(MAKE) build-native
	@command -v htmlproofer >/dev/null 2>&1 || { \
		echo "→ htmlproofer not installed; run: gem install html-proofer"; exit 1; }
	bundle exec htmlproofer _site \
		--allow-hash-href --assume-extension=.html \
		--ignore-empty-alt --ignore-missing-alt \
		--disable-external --no-enforce-https \
		--swap-urls '^/workshop-2025/:/'

##@ Maintenance
clean: ## Remove _site/ and Jekyll caches
	rm -rf $(CLEAN_TARGETS)

clean-docker: ## Remove build artifacts and Docker volumes
	rm -rf $(CLEAN_TARGETS)
	$(DOCKER_COMPOSE) down -v --remove-orphans
