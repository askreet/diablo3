require 'diablo3/hero'

class Diablo3
  # A container class for Heroes.
  class Heroes < Container
    contains Hero

    find_by :id
    find_many_by :name, :class
  end
end
