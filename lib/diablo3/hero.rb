#
# Class definition for Heroes
#

require 'diablo3/hero/items'

class Diablo3
  class Hero
    attr_reader :name, :id, :level, :hardcore, :hero_class, :gender, :last_updated, 
                :dead

    attr_reader :items, :followers, :stats, :kills, :progress

    # Heroes are originally built from the profile URL hash, but additional
    # data can be requested by calling helper methods.
    def initialize(hash, configuration)
      @name         = hash['name']
      @id           = hash['id']
      @level        = hash['level']
      @hardcore     = hash['hardcore']
      @hero_class   = hash['class']
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
      @hero_data ||= @conn.get("/hero/#{@id}")
    end

    def items
      
    end

    def followers
      if @followers.nil?
        @followers = {}
        hero_data['followers'].each do |name, follower_hash|
          @followers[name.to_sym] = Diablo3::Follower.new(follower_hash, @configuration)
        end
      end

      @followers
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

    # A one-line description of the character
    def one_liner
      "#{@name} is a level #{@level} #{pretty_class}."
    end

    def pretty_class
      @class.split('-').collect { |s| s.capitalize }.join(' ')
    end
  end
end
