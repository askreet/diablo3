#
# The Diablo3::Hero::Items class associates Diablo3::Item objects to positions
# in the character paperdoll, and can be accessed by Diablo3::Hero.items.
#
class Diablo3
  
  class Hero
    
    class Items

      attr_reader :head, :torso, :feet, :hands, :shoulders,
                  :legs, :bracers, :main_hand, :off_hand,
                  :waist, :right_finger, :left_finger, :neck
      
      def initialize(items_json, configuration)
        
        # TODO: What if an item slot is empty?  We should handle that here.
        @head         = Diablo3::Item.new(items_json['head'], configuration)
        @torso        = Diablo3::Item.new(items_json['torso'], configuration)
        @feet         = Diablo3::Item.new(items_json['feet'], configuration)
        @hands        = Diablo3::Item.new(items_json['hands'], configuration)
        @shoulders    = Diablo3::Item.new(items_json['shoulders'], configuration)
        @legs         = Diablo3::Item.new(items_json['legs'], configuration)
        @bracers      = Diablo3::Item.new(items_json['bracers'], configuration)
        @main_hand    = Diablo3::Item.new(items_json['mainHand'], configuration)
        @off_hand     = Diablo3::Item.new(items_json['offHand'], configuration)
        @waist        = Diablo3::Item.new(items_json['waist'], configuration)
        @right_finger = Diablo3::Item.new(items_json['rightFinger'], configuration)
        @left_finger  = Diablo3::Item.new(items_json['leftFinger'], configuration)
        @neck         = Diablo3::Item.new(items_json['neck'], configuration)
      end
      
      def each(&block)
        
        # Must be a better way to do this...
        yield 'head', @head
        yield 'torso', @torso
        yield 'feet', @torso
        yield 'hands', @hands
        yield 'shoulders', @shoulders
        yield 'legs', @legs
        yield 'bracers', @bracers
        yield 'mainHand', @main_hand
        yield 'offHand', @off_hand
        yield 'waist', @waist
        yield 'rightFinger', @right_finger
        yield 'leftFinger', @left_finger
        yield 'neck', @neck

      end
      
      def item_list
      
        self.each do |slot, item|
          puts "#{slot.capitalize}: #{item.name}"
        end
        
      end
            
    end
    
  end
  
end
