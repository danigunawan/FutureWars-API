class Ship < ApplicationRecord
  belongs_to :player
  has_many :holds
  belongs_to :ship_type

  include Mixins::Ship::Holds
  include Mixins::Ship::Capabilities

  def info
    "#{ship_type.name} - Ported=40 Kills=0 Distance=#{player.distance}"
  end


  def fighter_capacity
    ship_type.max_fighters - fighters
  end

  def shield_capacity
    ship_type.max_shields - shields
  end

end
