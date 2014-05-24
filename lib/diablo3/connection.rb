require 'json'
require 'net/http'

class Diablo3
  class Connection
    def initialize(hostname, base_path)
      @base_path = base_path

      # TODO: Switch to Excon, or Faraday, or something that isn't Net::HTTP.
      @conn = Net::HTTP.new(hostname, 80)
    end

    def get(relative_path)
      path = @base_path + relative_path
      decode(@conn.get(path).body)
    end

    def decode(data)
      JSON.parse(data)
    end
  end
end
