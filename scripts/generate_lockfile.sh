#!/bin/bash
# Script to generate Gemfile.lock using Docker with Ruby 2.3.8

set -e

echo "Generating Gemfile.lock with Ruby 2.3.8 and old gem versions..."

# Use Docker to run bundle lock with the correct Ruby version
docker run --rm -v "$(pwd):/app" -w /app ruby:2.3.8 bash -c "
  gem install bundler -v '1.17.3' && \
  bundle lock
"

echo "✓ Gemfile.lock generated successfully!"
echo "This lockfile ensures your CI/CD will use exactly these gem versions."
