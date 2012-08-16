#
# Display the items equipped by a hero, by name.
#

$: << File.expand_path(File.dirname(__FILE__)) + "/../lib/"

require 'diablo3'

battletag_name = 'Segfault'
battletag_code = 1483

hero_name = "Dhreyic"

@d = Diablo3.new('us', battletag_name, battletag_code)

@d.heroes.each do |hero|
  puts hero.one_liner
  puts hero.items.item_list
end