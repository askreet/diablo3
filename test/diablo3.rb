#
# Test basic funcationlity of Diablo3 Gem
#

$: << File.expand_path(File.dirname(__FILE__)) + "/../lib/"

require 'diablo3'

battletag_name = 'Segfault'
battletag_code = 1483

@d = Diablo3.new('us', battletag_name, battletag_code)

@d.heroes.each do |hero|
  puts hero.one_liner
end
