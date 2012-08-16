#
# The Diablo3::Item class describes an item, which can be on a Hero on a 
# Follower, or anywhere else they might expose in the future (AH?)
#

class Diablo3
  
  class Item
    
    attr_reader :id, :name, :icon, :display_color, :required_level, 
                :type_name, :type_id, :two_handed
    
    def initialize(hash, configuration)
      @id             = hash['id']
      @name           = hash['name']
      @icon           = hash['icon']
      @display_color  = hash['displayColor']
      @required_level = hash['requiredLevel']
      @type_name      = hash['typeName']
      @type_id        = hash['type']['id']
      @two_handed     = hash['type']['twoHanded']
    
      # Store the tooltipParams for fetching advanced item_data, as 
      # required.
      @item_data_url = '/api/d3/data/' + hash['tooltipParams']
      @configuration = configuration
      
    end
    
    # On-demand fetch advanced item data
    def item_data
      if @item_data.nil
        @item_data = JSON.parse(@configuration[:conn].get(@item_data_url).body)
      end
      
      @item_data
    end
    
    ########################################
    # On-demand advanced item data methods #
    ########################################
    
    def item_level
      # TODO
    end
    
    def bonus_affixes
      # TODO
    end
    
    def armor
      # TODO
    end
    
    # TODO: Should we just use attributesRaw and generate our own
    #       display format, or should we provide attributes and 
    #       attributesRaw methods?
    def attributes
      # TODO
    end
    
    def socket_effects
      # TODO
    end
    
    def salvage
      # TODO
    end
    
  end

end
  