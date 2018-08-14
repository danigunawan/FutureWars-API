class SectorSerializer < ActiveModel::Serializer
  attributes :id, :players, :port, :warps, :planets

#  private

    def port
      return nil unless object.port && object.port['name']
      {
        name: object.port['name'],
        port_class: object.port['port_class'],
        trades: object.port.trades
      }
    end

    def warps
      Warp.warps_for(object.id).map { |warp|
       {warp: warp, explored: false}
      }
    end

    def planets
      object.planets.map { |planet|
        {
          name: planet.name,
          class_name: planet.planet_type.classification,
          planet_type: planet.planet_type.name
        }
      }
    end

    def players
      object.players_in_sector.all.map { |player|
      {
        name: player.username,
        rank: player.rank.to_s,
        fighters: player.primary_ship.fighters,
        ship: player.ship_name,
        ship_type: player.primary_ship.ship_type.name
      }
     }
    end
end
