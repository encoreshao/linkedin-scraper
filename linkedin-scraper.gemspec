# -*- encoding: utf-8 -*-
require File.expand_path('../lib/linkedin-scraper/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = 'linkedin-scraper'
  gem.version       = Linkedin::Scraper::VERSION
  gem.authors       = ['Yatish Mehta', 'Encore Shao']
  gem.email         = ['encore.shao@gmail.com']
  gem.homepage      = 'https://github.com/encoreshao/linkedin-scraper'
  gem.description   = %q{ Scrapes the LinkedIn profile/company when a url is given }
  gem.summary       = %q{ Through LinkedIn public link address for the profile/company data }

  gem.files         = `git ls-files`.split($\)
  gem.executables   = ['linkedin-scraper']
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_dependency(%q<mechanize>, ['>= 0'])
  gem.add_development_dependency 'rspec', '>=0'
  gem.add_development_dependency 'rake'
end
