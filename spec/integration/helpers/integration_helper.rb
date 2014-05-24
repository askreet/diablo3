require 'diablo3'

# Set a known account, character, etc. for integration tests.
INTEGRATION_REGION = 'us'
INTEGRATION_BATTLE_TAG = 'Segfault'
INTEGRATION_BATTLE_TAG_CODE = 1483
INTEGRATION_CHARACTER_NAME = 'Dhreyic'

# Fill out expected information about the character, to be asserted in
# integration tests.
INTEGRATION_CHARACTER_IS_HC = false
INTEGRATION_CHARACTER_LEVEL = 70

def int_d3
  Diablo3.new(INTEGRATION_REGION,
              INTEGRATION_BATTLE_TAG,
              INTEGRATION_BATTLE_TAG_CODE)
end
