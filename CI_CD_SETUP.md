# Legacy Upgrade Lab CI/CD Setup

This repository intentionally uses **old/degraded gem versions** to simulate legacy application scenarios.

## 🔒 Locked Versions Strategy

The CI/CD pipeline is configured to run with **exact locked versions** from `Gemfile.lock`:

- **Ruby**: 2.3.8
- **Rails**: 4.2.11
- **Other gems**: See `Gemfile` for specific versions

## 🚀 CI/CD Configuration

### Main CI Workflow (`.github/workflows/ci.yml`)
- Runs on every push and pull request
- Uses Ruby 2.3.8 with Bundler 1.17.3
- Installs dependencies with `BUNDLE_FROZEN=true` (enforces Gemfile.lock)
- Runs tests and linting

### Dependabot Disabled
- Configured in `.github/dependabot.yml`
- `open-pull-requests-limit: 0` prevents automatic upgrade PRs
- Keeps your intentionally old versions intact

## 📝 Generating Gemfile.lock

Since you're using old gem versions, you need to generate `Gemfile.lock` with the correct Ruby version:

### Option 1: Using GitHub Actions (Recommended)
1. Go to Actions tab in your GitHub repository
2. Select "Generate Gemfile.lock" workflow
3. Click "Run workflow"
4. The workflow will generate and commit Gemfile.lock automatically

### Option 2: Using Docker Locally
```bash
# On Linux/Mac:
bash scripts/generate_lockfile.sh

# On Windows PowerShell:
.\scripts\generate_lockfile.ps1
```

### Option 3: Manual with rbenv/rvm
```bash
rbenv install 2.3.8
rbenv local 2.3.8
gem install bundler -v '1.17.3'
bundle lock
```

## ⚙️ Bundle Configuration

The `.bundle/config` enforces:
- `BUNDLE_FROZEN=true`: Must use exact versions from Gemfile.lock
- `BUNDLE_DEPLOYMENT=true`: Ensures production-like behavior

## 🎯 Why This Setup?

This configuration ensures:
1. ✅ CI/CD runs with **exact old gem versions**
2. ✅ No automatic upgrades from Dependabot
3. ✅ Reproducible builds across all environments
4. ✅ Simulates real legacy application scenarios

## 📋 Files Modified

- `.github/workflows/ci.yml` - Main CI pipeline
- `.github/workflows/generate-lockfile.yml` - Lockfile generator
- `.github/dependabot.yml` - Disabled auto-upgrades
- `.bundle/config` - Enforces frozen dependencies
- `scripts/generate_lockfile.*` - Local lockfile generation scripts
