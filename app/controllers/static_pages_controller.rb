class StaticPagesController < ApplicationController
	before_action :check_signed_in

	def check_signed_in
	  redirect_to index_path if user_signed_in?
	end

	def landing
	end
end
