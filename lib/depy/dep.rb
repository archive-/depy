require 'yaml'

module Depy
  class Dep
    attr_reader :name

    def initialize(name)
      @name = name
    end

    def metadata(metadata)
      obj = YAML::load(metadata)
      obj.each do |k, v|
        self.instance_variable_set(:"@#{k}", v)
      end
    end

    # TODO error handling!
    def install!
      # Download archive into ./deps
      %x(mkdir -p deps &&
      cd deps &&
      curl -sk 'https://codeload.github.com/#{@github}/zip/master' > #{@name}.zip &&
      unzip -o -qq #{@name}.zip &&
      rm -rf #{@name} #{@name}.zip &&
      mv #{@name}-master #{@name} 2> /dev/null)

      # TODO add ./deps/Makefile target based on @target

      # TODO add ./Makefile -I based on @include
      # look for INCLUDES= line and then check line length and append to
      # first line less than 80 - include_string chars (or add \ and append to
      # next line)

      puts "Installing #{@name} (<version>)" # TODO (1) version (2) Installing / Using
    end
  end
end
