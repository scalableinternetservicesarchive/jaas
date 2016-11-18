class Match < ApplicationRecord
  scope :pending, -> { where(status: 'pending') }
  scope :pending_or_finished, -> { where("matches.status = 'pending' OR matches.status = 'finished'") }
  scope :not_archived, -> { where("matches.status <> 'archived'") }
  scope :with_user1, ->(user_id) { joins("INNER JOIN users ON users.id = matches.user1Id AND users.id = ", user_id).distinct }
  scope :with_user2, ->(user_id) { joins("INNER JOIN users ON users.id = matches.user2Id AND users.id = ", user_id).distinct }
  scope :with_school, ->(school) { joins("INNER JOIN users ON users.id = matches.user1Id AND users.school = '" + school + "'").distinct }
  
  def self.with_foods(foods)
    food_filter = "match_to_foods.foodId = " + foods[0].to_s
    foods[1..-1].each do |food|
      food_filter << " OR match_to_foods.foodId = " + food.to_s
    end
    joins("INNER JOIN match_to_foods ON match_to_foods.matchId = matches.id AND (" + food_filter + ")")
  end
end