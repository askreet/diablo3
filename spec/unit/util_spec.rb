require_relative 'helpers/spec_helper'

describe Diablo3::Util do
  include Diablo3::Util
  describe '#snakeify' do
    it 'should snakeify things' do
      expect(snakeify('UpperCamelCase')).to eq('upper_camel_case')
      expect(snakeify('lowerCamelCase')).to eq('lower_camel_case')
    end
  end
end
