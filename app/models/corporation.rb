class Corporation < ApplicationRecord
  has_one :ceo, foreign_key: "ceo_id", class_name: "Player"
  has_many :members, foreign_key: "corporation_id", class_name: "Player"

  scope :with_ceo, -> (id) { where(ceo_id: id) }  

end
