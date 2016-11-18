class Cleaner
	def self.clear_matches()
		puts "before cleaning:"
		Match.where.not(status: 'archived').each { |match|
			puts match.inspect
		}
		Match.where.not(status: 'archived').where.not(status: 'next_week').update_all(status: 'archived')
		Match.where(status: 'next_week').update_all(status: 'pending')		
		puts "\nERROR, matches not deleted:"
		Match.where.not(status: 'archived').each { |match|
			puts match.inspect
		}		
	end
end