require 'colorize'
require 'net/http'

Dir[File.join(File.dirname(__FILE__), 'depy/*')].each do |file|
  require file
end

[STDOUT, STDERR].each { |fd| fd.sync = true }

module Depy
  def self.install(depfile_path='./Depfile')
    begin
      depfile = File.open(depfile_path, 'r')
    rescue => e
      $stderr.puts 'Depfy::DepfileNotFound'
      exit 1
    end

    deps = []

    depfile.readlines.each_with_index do |line, i|
      line.strip!
      match_data = line.strip.match(/^dep\s+('[^']+'|"[^"]+")$/)
      if match_data
        deps << Dep.new(match_data[1][1...-1])
      else
        $stderr.puts "Bad line #{i+1} in Depfile: '#{line}'"
      end
    end

    if deps.empty?
      $stderr.puts 'The Depfile specifies no dependencies'
    else
      deps.each do |dep|
        uri = URI("https://raw.githubusercontent.com/tjeezy/depy/master/deps/#{dep.name}.yml")

        Net::HTTP.start(uri.host, uri.port, :use_ssl => true) do |http|
          request = Net::HTTP::Get.new(uri.request_uri)
          response = http.request(request)
          if response.code.to_i == 200
            dep.metadata(response.body)
          else
            $stderr.puts "Could not find dep '#{dep.name}' in the deps available on Github at tjeezy/depy".red
            exit 1
          end
        end
      end

      # TODO resolve dependencies...
      puts 'Resolving dependencies...'

      deps.each do |dep|
        dep.install!
      end
    end

    puts 'Depy is finished!'.green
  end
end
