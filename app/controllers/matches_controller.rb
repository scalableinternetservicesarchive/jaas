class MatchesController < ApplicationController
	before_action :authenticate_user!

	def make_match
	end

	def match_found
	end

	def match_not_found
	end
end
