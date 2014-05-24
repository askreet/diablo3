require_relative 'helpers/integration_helper'

describe Diablo3::Heroes do
  let(:subject) do
    int_d3.heroes
  end

  it 'should be an instance of Heroes' do
    expect(subject).to be_a(Diablo3::Heroes)
  end
end
