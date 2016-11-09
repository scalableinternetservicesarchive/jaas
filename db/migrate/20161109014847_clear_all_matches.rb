class ClearAllMatches < ActiveRecord::Migration[5.0]
  def self.up
    Match.update_all(status="finished")
  end

  def self.down
  end
end
