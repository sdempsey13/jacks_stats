class Player < ApplicationRecord
  belongs_to :team

  has_many :skater_stats
end
