#
# Display the items equipped on each follower.
#

$: << File.expand_path(File.dirname(__FILE__)) + "/../lib/"

require 'diablo3'

battletag_name = 'Segfault'
battletag_code = 1483

hero_name = "Dhreyic"

@d = Diablo3.new('us', battletag_name, battletag_code)

@d.heroes.select {|s| s.name == hero_name}.first.followers.each do |follower, follower_data|
  puts 
  puts follower
  puts follower_data.items.item_list
  puts
end