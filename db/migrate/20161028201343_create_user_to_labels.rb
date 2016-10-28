class CreateUserToLabels < ActiveRecord::Migration[5.0]
  def change
    create_table :user_to_labels do |t|
      t.integer :userId
      t.integer :labelId

      t.timestamps
    end
  end
end
