#
# Diablo3 API Gem
#
# Released under MIT license, see LICENCE.TXT for more information
#

# TODO: Better way to do this with Bundler?
require 'rubygems'
require 'net/http'
require 'json'
require 'pp'

# Require the rest of the Diablo3 classes, stored in separate files:
require 'diablo3/hero'
require 'diablo3/item'

class Diablo3

  attr_reader :battletag_name, :battletag_code, :region
  
  # Objects/data obtained from the API
  attr_reader :heroes, :artisans, :progression
  attr_reader :hardcore_artisans, :hardcore_progression

  # TODO: Does this work?  Mine is empty but I have fallen hardcore characters.
  attr_reader :fallen_heroes

  # Not sure how I want to represent these in Ruby
  attr_reader :kills
  attr_reader :time_played

  
  def initialize(region, battletag_name, battletag_code)

    # TODO: Load this data based on specified region.
    # TODO: Throw an exception if region is invalid.
    # TODO: Throw an exception if battletag contains invalid region,
    #       possibly by comparing with a region-specific regexp.
    # TODO: Throw an exeception if battletag code is not a number.
    # TODO: Is the protocol always HTTP?
    # Load data into a single hash that can be passed to subobject
    # initializers, since they will need to make additional requests.
    server, port = ['us.battle.net', 80]
    
    @configuration = { 
      :conn        => Net::HTTP.new(server, port),
      :profile_url => "/api/d3/profile/#{battletag_name}-#{battletag_code.to_s}/"
    }
    
    # TODO: Wrapper to Fetch JSON and keep an eye on return codes or
    #       known error messages that you might receive if the character
    #       does not exist, etc.
    @profile_json = JSON.parse(@configuration[:conn].get(@configuration[:profile_url]).body)
    
    # For each Hero, create a new Diablo3::Hero object and store in @heroes
    @heroes = []
    
    @profile_json['heroes'].each do |hash|
      @heroes << Diablo3::Hero.new(hash, @configuration)
    end
  
  end
    
end

  

