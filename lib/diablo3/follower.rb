
require 'diablo3/follower/items'

class Diablo3
  
  class Follower
    
    attr_reader :level, :items, :stats, :skills
    
    def initialize(hash, configuration)
      @level = hash['level']
      @items = Diablo3::Follower::Items.new(hash['items'], configuration)
      @stats = hash['stats']
      @skills = nil # ODO
    end
    
  end
  
end
