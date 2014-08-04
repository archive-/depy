module Depy
  class Dep
    def initialize(obj)
      [:name, :url, :github, :tags, :author, :author_url, :target, :include].each do |attr|
        self.instance_variable_set(:"@#{attr}", obj[attr])
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

      # Add ./deps/Makefile target based on @target
      # TODO

      # Add ./Makefile -I based on @include
      # TODO look for INCLUDES= line and then check line length and append to
      # first line less than 80 - include_string chars (or add \ and append to
      # next line)
    end
  end
end
