# Legacy Upgrade Lab CI/CD Setup

This repository intentionally uses **old/degraded gem versions** to simulate legacy application scenarios.

## 🔒 Locked Versions Strategy

The CI/CD pipeline is configured to run with **exact locked versions** from `Gemfile.lock`:

- **Ruby**: 2.3.8
- **Rails**: 4.2.11
- **globalid**: 0.3.7 (compatible with Rails 4.2.11)
- **mail**: 2.6.6 (compatible with Ruby 2.3.8)
- **warden**: 1.2.3 (compatible with rack 1.6.x)
- **Other gems**: See `Gemfile` for specific versions

## 🚀 CI/CD Configuration

### Main CI Workflow (`.github/workflows/ci.yml`)
- Runs on every push and pull request
- Uses Ruby 2.3.8 with Bundler 1.17.3
- Installs dependencies with `BUNDLE_FROZEN=true` (enforces Gemfile.lock)
- Runs tests and linting

### Dependabot ENABLED
- Configured in `.github/dependabot.yml`
- Runs **daily** to check for gem updates
- Creates up to **5 pull requests** for upgrades
- Allows you to review and test upgrades safely
- Labels PRs with "dependabot", "dependencies", and "security"

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
2. ✅ Dependabot **enabled** to propose upgrades via PRs
3. ✅ Reproducible builds across all environments
4. ✅ Simulates real legacy application scenarios
5. ✅ Safe upgrade path - review each change before merging

## 🔧 Compatibility Fixes Applied

The following gems were fixed to be compatible with Ruby 2.3.8 and Rails 4.2.11:

- **globalid**: Changed from 1.2.2 → 0.3.7 (1.2.2 requires ActiveSupport 6.1+)
- **mail**: Changed from 2.8.1 → 2.6.6 (2.8.x requires Ruby 3+ gems)
- **warden**: Changed from 1.2.9 → 1.2.3 (1.2.9 requires rack 2.0.9+)
- **mime-types**: Fixed dependencies for Ruby 2.3.8

## 📋 Files Modified

- `.github/workflows/ci.yml` - Main CI pipeline
- `.github/workflows/generate-lockfile.yml` - Lockfile generator
- `.github/dependabot.yml` - **Re-enabled** with daily checks
- `.bundle/config` - Enforces frozen dependencies
- `Gemfile` - Added explicit globalid version
- `Gemfile.lock` - Fixed incompatible gem versions
- `scripts/verify_setup.ps1` - Verification script
- `scripts/generate_lockfile.*` - Local lockfile generation scripts

## ✅ Verification

Run the verification script to ensure everything is configured correctly:

```powershell
.\scripts\verify_setup.ps1
```

This checks:
- Gemfile.lock exists and is valid
- All gem versions are compatible
- Ruby version is set correctly
