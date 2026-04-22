# Variable Definitions
# RUBYOPT="-W0" suppresses the "already initialized constant" warnings
JEKYLL = RUBYOPT="-W0" bundle exec jekyll
DEST = _site

.PHONY: help install serve build clean deploy

# Default help message
help:
	@echo "Available commands:"
	@echo "  make install  - Install dependencies (Gemfile)"
	@echo "  make serve    - Start local preview server (includes drafts)"
	@echo "  make build    - Build static files to the $(DEST) directory"
	@echo "  make clean    - Remove build cache and generated files"
	@echo "  make deploy   - Build and push to production environment"

# Install dependencies
install:
	npm i && npm run build
	bundle install

# Local real-time preview (with drafts)
serve:
	$(JEKYLL) serve --drafts --livereload

# Build production version
build:
	JEKYLL_ENV=production $(JEKYLL) build

# Clean cache
clean:
	find $(DEST) -mindepth 1 -maxdepth 1 ! -name '.git' ! -name '.gitattributes' ! -name 'CNAME' -exec rm -rf {} +
	rm -rf .jekyll-cache
	rm -rf .jekyll-metadata

# Simple deployment example (e.g., pushing to main branch)
deploy: build
	@git push work build
