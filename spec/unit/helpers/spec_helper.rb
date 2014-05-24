require 'diablo3'

FIXTURE_PATH = File.join(File.dirname(__FILE__), '..', 'fixtures')

def json_fixture(name)
  filename = File.join(FIXTURE_PATH, name)

  if File.exist? filename
    JSON.parse(File.read(filename))
  else
    fail "Could not load fixture: #{name}"
  end
end
