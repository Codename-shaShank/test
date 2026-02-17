# Script to generate Gemfile.lock using Docker with Ruby 2.3.8

Write-Host "Generating Gemfile.lock with Ruby 2.3.8 and old gem versions..." -ForegroundColor Cyan

# Use Docker to run bundle lock with the correct Ruby version
docker run --rm -v "${PWD}:/app" -w /app ruby:2.3.8 bash -c @"
  gem install bundler -v '1.17.3' && \
  bundle lock
"@

if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ Gemfile.lock generated successfully!" -ForegroundColor Green
    Write-Host "This lockfile ensures your CI/CD will use exactly these gem versions." -ForegroundColor Green
} else {
    Write-Host "✗ Failed to generate Gemfile.lock" -ForegroundColor Red
    exit 1
}
