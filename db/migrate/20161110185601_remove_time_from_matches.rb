class RemoveTimeFromMatches < ActiveRecord::Migration[5.0]
  def change
    remove_column :matches, :time, :string
  end
end
