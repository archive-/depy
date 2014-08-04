Dir[File.join(File.dirname(__FILE__), 'depy/*')].each do |file|
  require file
end

require 'net/http'

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
        deps << match_data[1][1...-1]
      else
        $stderr.puts "Bad line #{i+1} in Depfile: '#{line}'"
      end
    end

    if deps.empty?
      $stderr.puts 'The Depfile specifies no dependencies'
    else
      deps.each do |dep|
        uri = URI("https://raw.githubusercontent.com/tjeezy/depy/master/deps/#{dep}.json")
        p uri

        Net::HTTP.start(uri.host, uri.port, :use_ssl => true) do |http|
          request = Net::HTTP::Get.new(uri)
          response = http.request(request)
          p response
        end
      end
    end

    puts 'Depy is finished!'
  end
end
