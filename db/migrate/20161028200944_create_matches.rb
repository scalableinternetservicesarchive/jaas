class CreateMatches < ActiveRecord::Migration[5.0]
  def change
    create_table :matches do |t|
      t.integer :user1Id
      t.integer :user2Id
      t.string :time
      t.string :status

      t.timestamps
    end
  end
end
