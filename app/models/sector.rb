require 'port_trade'

class Sector < ApplicationRecord

  has_one :port
  has_many :planets

  def self.path(origin, destination)
     ActiveRecord::Base.connection.execute("select p.id from warp_graph fg join sectors p on (fg.linkid=p.id)where fg.latch = '1' and origid = #{origin} and destid = #{destination}").to_a.flatten
  end

  def has_port?
    !port.nil?
  end

  def players_in_sector
    Player.where(current_sector: id).all
  end

  def warps
    Warp.warps_for(id)
  end

end
