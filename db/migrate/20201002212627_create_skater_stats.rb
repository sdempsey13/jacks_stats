class CreateSkaterStats < ActiveRecord::Migration[6.0]
  def change
    create_table :skater_stats do |t|
      t.text :season_year
      t.text :season_type
      t.integer :time_on_ice
      t.integer :assists
      t.integer :goals
      t.integer :pim
      t.integer :shots
      t.integer :games
      t.integer :hits
      t.integer :power_play_goals
      t.integer :power_play_points
      t.integer :power_play_time_on_ice
      t.integer :even_time_on_ice
      t.float :faceoff_pct
      t.float :shot_pct
      t.integer :overtime_goals
      t.integer :game_winning_goals
      t.integer :short_handed_goal
      t.integer :short_handed_points
      t.integer :short_handed_time_on_ice
      t.integer :blocked_shots
      t.integer :plus_minus
      t.integer :points
      t.integer :shifts
      t.integer :time_on_ice_per_game
      t.integer :even_time_on_ice_per_game
      t.integer :short_handed_time_on_ice_per_game
      t.integer :power_play_time_on_ice_per_game
      t.references :player, null: false, foreign_key: true

      t.timestamps
    end
  end
end
