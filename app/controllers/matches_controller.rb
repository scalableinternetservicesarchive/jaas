class MatchesController < ApplicationController
	before_action :authenticate_user!

	def make_match
		@fake_match = Match.find_by(user1Id: 1, user2Id: 2, time: "time", status: "pending")
		
	end

	def match_found
	end

	def match_not_found
	end
end
