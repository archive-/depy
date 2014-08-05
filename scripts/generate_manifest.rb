#!/usr/bin/env ruby

require 'json'
require 'yaml'

exit if $0 != __FILE__

deps = []

Dir['./deps/*.yml'].each do |file|
  deps << YAML::load_file(file)
end

manifest = deps.inject({}) do |h,dep|
  h[dep['name']] = dep; h
end

File.open('manifest.json', 'w').write(manifest.to_json)
