require 'test_helper'

class MatchTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  	def setup
  		@match = Match.new(user1Id: 1, user2Id: 1, time: "1", status: "pending")
  		@user = User.find_by(id: 1)
	end

	test "can create user and match" do
		assert !@user.nil?
		assert !@match.nil?
	end

	test "clear matches" do
		Match.find_each do |matches|
			puts matches.inspect
		end
		Match.update_all(status:"finished")
		Match.find_each do |matches|
			puts matches.inspect
		end
	end
end
