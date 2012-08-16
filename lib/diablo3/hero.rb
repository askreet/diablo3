#
# Class definition for Heroes
#

require 'diablo3/hero/items'

class Diablo3
  
  class Hero
    
    attr_reader :name, :id, :level, :hardcore, :class, :gender, :last_updated, :dead
    attr_reader :items, :followers, :stats, :kills, :progress
    
    # Pass the hash from the parsed JSON directly into the .new() and store.
    def initialize(hash, configuration)

      @name         = hash['name']
      @id           = hash['id']
      @level        = hash['level']
      @hardcore     = hash['hardcore']
      @class        = hash['class']
      @gender       = hash['gender']
      @last_updated = hash['last_updated']
      @dead         = hash['dead']
      
      # Save configuration for on-demand item/skill lookups
      @configuration = configuration

    end
    
    # Fetch advanced hero data by using /hero/<hero-id> URL.
    # Do this only once, so if we call .items, .followers, etc. they don't 
    # each make the same request.
    def hero_data
      if @hero_data.nil?
        hero_url = @configuration[:profile_url] + 'hero/' + self.id.to_s
        @hero_data = JSON.parse(@configuration[:conn].get(hero_url).body)
      end
      
      @hero_data
    end
    
    ########################################
    # On-demand advanced hero data methods #
    ########################################
    
    # Return the item data that can be obtained from /hero/<hero-id> URL.
    def items
      if @items.nil?
        @items = Diablo3::Hero::Items.new(self.hero_data['items'], @configuration)
      end
      
      @items
    end
    
    def followers
      # TODO
    end
    
    def stats
      # TODO
    end
    
    def kills
      # TODO
    end
    
    def progress
      # TODO
    end
        
    ##################################################
    # Various cleanup functions for display purposes #
    ##################################################
    
    # A one-line description of the character
    def one_liner
      "#{@name} is a level #{@level} #{pretty_class}."
    end
    
    def pretty_class
      @class.split('-').collect { |s| s.capitalize }.join(' ')
    end
    
    # TODO: Define a pretty .to_s and .inspect
    
    
  end

end