class Cleaner
	def self.clear_matches()
		Match.update_all(status:"finished")		
	end
end