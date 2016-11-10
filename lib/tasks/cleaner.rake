desc 'clear matches at end of week'
task clear_matches: :environment do
  Cleaner.clear_matches
end