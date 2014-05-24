require_relative 'helpers/integration_helper'

describe Diablo3 do
  it 'should retreive some characters' do
    expect(int_d3.heroes.size).to be > 1
  end

  describe 'the test character' do
    it 'should be int heros list' do
      char = int_d3.heroes.first_by_name(INTEGRATION_CHARACTER_NAME)
      expect(char).not_to be_nil
      expect(char).to be_a(Diablo3::Hero)
    end
  end
end
