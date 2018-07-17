# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.authors = ["Aki"]
  gem.email = ["makitosansan@gmail.com"]
  gem.summary = "POC of DI"
  gem.description = ""
  gem.homepage = ""
  gem.license = "MIT"

  gem.executables = ['factorydi']

  gem.files = %w[Gemfile koktiiworker.gemspec]
  gem.files += Dir.glob("bin/**/*")
  gem.files += Dir.glob("config/*")
  gem.files += Dir.glob("fonts/**/*")
  gem.files += Dir.glob("lib/**/*.rb")
  gem.files += Dir.glob("migrations/**/*")
  gem.files += Dir.glob("test/**/*")

  gem.test_files = []
  gem.name = "factorydi"
  gem.require_paths = ["lib"]
  gem.version = "1.0.0"
  gem.required_ruby_version = ">= 2.2.2"

end
