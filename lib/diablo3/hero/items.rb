#
# The Diablo3::Hero::Items class associates Diablo3::Item objects to positions
# in the character paperdoll, and can be accessed by Diablo3::Hero.items.
#
class Diablo3
  
  class Hero
    
    class Items

      ValidItemSlots = %w(head torso feet hands shoulders
                          legs bracers main_hand off_hand
                          waist right_finger left_finger neck)
      
      def initialize(items_json, configuration)
        
        @slots = {}
        
        items_json.each do |slot, item_data|
        
          if ValidItemSlots.member? slot.underscore
            @slots[slot.underscore] = Diablo3::Item.new(item_data, configuration)
          else
            raise Exception, "Invalid slot in result set: '#{slot}'?"
          end
        
        end
        
      end
      
      def each(&block)
        
        ValidItemSlots.each do |slot|
          if @slots.has_key? slot
            yield slot, @slots[slot]
          else
            yield slot, nil
          end
        end
        
      end
      
      def method_missing(method_name)
        # If the method is a slot name, attempt to return an Item, unless that slot is empty
        # then return nil.
        if ValidItemSlots.member? method_name
          if @slots[method_name]
            @slots[method_name]
          else
            nil
          end
        end        
        
      end
      
      def item_list
      
        s = ""
        
        self.each do |slot, item|
          if item
            s += "#{slot.capitalize}: #{item.name}\n"
          else
            s += "#{slot.capitalize}: <Empty>\n"
          end
        end
        
        return s
        
      end
            
    end
    
  end
  
end
