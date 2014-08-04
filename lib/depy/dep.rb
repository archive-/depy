require 'yaml'

module Depy
  class Dep
    attr_reader :name

    def initialize(name)
      @name = name
    end

    def metadata(metadata)
      obj = YAML::load(metadata)
      [:name, :url, :github, :tags, :author, :author_url, :target, :include].each do |attr|
        self.instance_variable_set(:"@#{attr}", obj[attr.to_s])
      end
    end

    # TODO error handling!
    def install!
      # Download archive into ./deps
      %x(mkdir -p deps &&
      cd deps &&
      curl -sk 'https://codeload.github.com/#{@github}/zip/master' > #{@name}.zip &&
      unzip -qq #{@name}.zip &&
      rm #{@name}.zip &&
      mv #{@name}-master #{@name})

      # TODO add ./deps/Makefile target based on @target

      # TODO add ./Makefile -I based on @include
      # look for INCLUDES= line and then check line length and append to
      # first line less than 80 - include_string chars (or add \ and append to
      # next line)

      puts "Using #{@name} (<version>)" # TODO version
    end
  end
end
