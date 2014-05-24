# Require the rest of the Diablo3 classes, stored in separate files:
require 'diablo3/connection'
require 'diablo3/container'
require 'diablo3/heroes'
require 'diablo3/item'
require 'diablo3/follower'
require 'diablo3/util'

class Diablo3
  extend Util

  Kills = Struct.new(:monsters, :elites, :hardcore_monsters)

  # Data mapped into Ruby objects already:
  attr_reader :heroes

  attr_reader :last_hero_played
  attr_reader :last_updated
  attr_reader :kills

  # Not sure how useful this data is, as it's not in real time, but a relative
  # time to the most played class, which is represented by 1.0.
  attr_reader :time_played
  attr_reader :fallen_heroes

  def initialize(region, battletag_name, battletag_code)
    @conn = Diablo3::Connection.new(
      "#{region}.battle.net",
      "/api/d3/profile/#{battletag_name}-#{battletag_code}"
    )

    @profile = @conn.get('/')

    load_heroes
    load_fallen_heroes

    # TODO: Can this be nil if the last hero played was fallen?
    @last_hero_played = @heroes.by_id(@profile['lastHeroPlayed'])
    @last_updated = Time.at(@profile['lastUpdated'])

    @kills = Kills.new(@profile['kills']['monsters'],
                       @profile['kills']['elites'],
                       @profile['kills']['hardcoreMonsters'])
  end

  def load_heroes
    # For each Hero, create a new Diablo3::Hero object and store in @heroes
    @heroes = Heroes.new
    @profile['heroes'].each do |hash|
      @heroes.add(Hero.new(hash, @conn))
    end
  end

  def load_fallen_heroes
    # TODO: For whatever reason, fallenHeroes include all item data, etc, and
    #       cannot be looked up by heroId.
    @fallen_heroes = Heroes.new
    @profile['fallenHeroes'].each do |hash|
      @fallen_heroes.add(Hero.new(hash, @conn))
    end
  end

  # Define methods for data which maps directly to a snake-case'd version
  # of the key in @profile, generate simple reader methods.
  map_fields = %w(battleTag paragonLevel paragonLevelHardcore progression
                  timePlayed)

  map_fields.each do |field|
    define_method(snakeify(field).to_sym) do
      @profile[field]
    end
  end
end
