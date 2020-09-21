class AddNhlidToTeams < ActiveRecord::Migration[6.0]
  def change
    add_column :teams, :nhl_id, :integer
  end
end
