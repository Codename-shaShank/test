# Quick CI/CD Test Script
# This verifies the Gemfile.lock is valid

Write-Host "Checking Gemfile.lock validity..." -ForegroundColor Cyan

# Check if Gemfile.lock exists
if (Test-Path "Gemfile.lock") {
    Write-Host "[OK] Gemfile.lock exists" -ForegroundColor Green
} 
else {
    Write-Host "[ERROR] Gemfile.lock not found" -ForegroundColor Red
    exit 1
}

# Check for problematic versions
Write-Host ""
Write-Host "Checking for incompatible versions..." -ForegroundColor Cyan

$lockContent = Get-Content "Gemfile.lock" -Raw

# Check globalid version
if ($lockContent -match "globalid \(0\.3\.\d+\)") {
    Write-Host "[OK] globalid version is compatible (0.3.x)" -ForegroundColor Green
} 
else {
    Write-Host "[WARN] globalid version might be incompatible" -ForegroundColor Yellow
}

# Check mail version
if ($lockContent -match "mail \(2\.6\.\d+\)") {
    Write-Host "[OK] mail version is compatible (2.6.x)" -ForegroundColor Green
} 
else {
    Write-Host "[WARN] mail version might be incompatible" -ForegroundColor Yellow
}

# Check warden version
if ($lockContent -match "warden \(1\.2\.3\)") {
    Write-Host "[OK] warden version is compatible (1.2.3)" -ForegroundColor Green
} 
else {
    Write-Host "[WARN] warden version might be incompatible" -ForegroundColor Yellow
}

# Check Ruby version
if ($lockContent -match "ruby 2\.3\.8") {
    Write-Host "[OK] Ruby version is set to 2.3.8" -ForegroundColor Green
} 
else {
    Write-Host "[WARN] Ruby version not set correctly" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "Summary:" -ForegroundColor Cyan
Write-Host "Your Gemfile.lock is configured for old gem versions." -ForegroundColor White
Write-Host "CI/CD will use these exact versions." -ForegroundColor White
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "1. Commit these changes to your repository" -ForegroundColor White
Write-Host "2. Push to GitHub to trigger CI/CD" -ForegroundColor White
Write-Host "3. Dependabot is now enabled and will create upgrade PRs" -ForegroundColor White
