require 'thor'

module Depy
  class CLI < Thor
    desc 'install', 'install dependencies from Depfile into project'
    def install
      Depy.install
    end

    desc 'list', 'list all supported dependencies with accompanying metadata'
    def list
      Depy.list
    end

    desc 'search <query>', 'find a dependency with tag matching <query>'
    def search(*terms)
      Depy.search(terms)
    end
  end
end
