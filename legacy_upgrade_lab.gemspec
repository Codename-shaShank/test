Gem::Specification.new do |spec|
  spec.name          = "legacy_upgrade_lab"
  spec.version       = "0.1.0"
  spec.authors       = ["Legacy Dev"]
  spec.email         = ["legacy@example.com"]

  spec.summary       = "A legacy Rails app with outdated dependencies"
  spec.description   = "This gem is intentionally outdated to simulate upgrade issues."
  spec.license       = "MIT"

  spec.files         = Dir["lib/**/*.rb"]

  spec.add_dependency "rails", "~> 4.2.0"
  spec.add_dependency "paperclip", "~> 4.3"
end
