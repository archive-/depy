lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'depy/version'

Gem::Specification.new do |s|
  s.name          = 'depy'
  s.version       = Depy::VERSION
  s.authors       = ['TJ Koblentz']
  s.email         = ['tj.koblentz@gmail.com']
  s.summary       = 'A simple (silly) dependency manager for C!'
  s.description   = s.summary
  s.homepage      = 'https://github.com/tjeezy/depy'
  s.files         = `git ls-files`.split($/)
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_dependency 'thor'
end
