require 'port_trade'

class Sector < ApplicationRecord

  has_one :port
  has_many :planets

  def self.density(id)
    sector = Sector.find(id)
    planet_count = 500 * sector.planets.size
    ship_count = 40 * sector.players_in_sector.count
    nav_haz = 21 * (sector.nav_hazard / 100)
    planet_count + ship_count + nav_haz
  end

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

  def self.create_warps(id, id_list, _max_warps = 5, warp_function)	
    warp_function.call(0).times { |_| Warp.connect(id, id_list[rand * id_list.size]) }	
  end

end
