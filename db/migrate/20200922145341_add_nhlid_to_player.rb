class AddNhlidToPlayer < ActiveRecord::Migration[6.0]
  def change
    add_column :players, :nhl_id, :integer
  end
end
