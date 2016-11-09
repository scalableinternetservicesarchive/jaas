class Cleaner
	def self.clear_matches()
		puts "before cleaning:"
		Match.all.each { |match|
			puts match.inspect
		}
		Match.update_all(status:"finished")
		puts "\nfinished deleting matches:"
		Match.all.each { |match|
			puts match.inspect
		}		
	end
end