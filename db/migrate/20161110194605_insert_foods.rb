class InsertFoods < ActiveRecord::Migration[5.0]
  def change
    Food.create :name => "American"
    Food.create :name => "Chinese"
    Food.create :name => "Mexican"
    Food.create :name => "Italian"
    Food.create :name => "Japanese"
    Food.create :name => "Greek"
    Food.create :name => "French"
    Food.create :name => "Thai"
    Food.create :name => "Spanish"
    Food.create :name => "Indian"
    Food.create :name => "Mediterranean"
    Food.create :name => "Korean"
    Food.create :name => "Vietnamese"
  end
end
