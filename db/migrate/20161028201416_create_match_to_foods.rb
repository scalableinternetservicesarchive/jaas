class CreateMatchToFoods < ActiveRecord::Migration[5.0]
  def change
    create_table :match_to_foods do |t|
      t.integer :matchId
      t.integer :foodId

      t.timestamps
    end
  end
end
