lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "psych-simple"
  spec.version       = "2.0.0"
  spec.authors       = ["Adrian Kuhn"]
  spec.email         = ["adrian.kuhn@airbnb.com"]

  spec.summary       = %q{Parse yaml 5x faster, simplified file format.}
  spec.homepage      = "https://github.com/akuhn/psych-simple"

  spec.files         = `git ls-files -z`.split("\x0").grep(%r{^(lib)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "psych", "~> 2.0"
  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
