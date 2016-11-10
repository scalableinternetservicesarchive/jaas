class AddSeparateTimesToMatches < ActiveRecord::Migration[5.0]
  def change
    add_column :matches, :mondayStartTime, :integer
    add_column :matches, :mondayEndTime, :integer
    add_column :matches, :tuesdayStartTime, :integer
    add_column :matches, :tuesdayEndTime, :integer
    add_column :matches, :wednesdayStartTime, :integer
    add_column :matches, :wednesdayEndTime, :integer
    add_column :matches, :thursdayStartTime, :integer
    add_column :matches, :thursdayEndTime, :integer
    add_column :matches, :fridayStartTime, :integer
    add_column :matches, :fridayEndTime, :integer
    add_column :matches, :saturdayStartTime, :integer
    add_column :matches, :saturdayEndTime, :integer
    add_column :matches, :sundayStartTime, :integer
    add_column :matches, :sundayEndTime, :integer
  end
end
