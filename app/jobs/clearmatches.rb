class Cleaner
	def self.remove()
		Match.update_all(status:"finished")		
	end
end