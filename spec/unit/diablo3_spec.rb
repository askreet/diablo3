require_relative 'helpers/spec_helper'

describe Diablo3 do
  let(:subject) { described_class.new('us', 'mock', 1234) }
  before(:each) do
    @conn = double('Diablo3::Connection')
    expect(Diablo3::Connection).to receive(:new).and_return(@conn)
  end

  it 'should parse profile data' do
    expect(@conn).to receive(:get)
      .with('/')
      .and_return(json_fixture('profile.json'))

    result = subject.heroes
    expect(result).to be_a(Diablo3::Heroes)
    expect(result.size).to eq(12)

    expect(result.first_by_name('Dhreyic')).to be_a(Diablo3::Hero)

    expect(subject.battle_tag).to eq('Segfault#1483')
    expect(subject.last_hero_played).to be_a(Diablo3::Hero)
    expect(subject.last_hero_played.name).to eq('Francium')
    expect(subject.last_updated).to be_a(Time)
    expect(subject.last_updated).to eq(Time.at(1400948570))
    expect(subject.kills).to be_a(Diablo3::Kills)
    expect(subject.kills.monsters).to eq(297731)
    expect(subject.kills.elites).to eq(18595)
    expect(subject.kills.hardcore_monsters).to eq(76857)
    expect(subject.paragon_level).to eq(88)
    expect(subject.paragon_level_hardcore).to eq(54)

    # TODO: Consider changing this format.
    expect(subject.time_played).to eq(
      'barbarian' => 1.0,
      'crusader' => 0.176,
      'demon-hunter' => 0.058,
      'monk' => 0.128,
      'witch-doctor' => 0.412,
      'wizard' => 0.359
    )
  end
end
