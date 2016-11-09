desc 'clear matches at end of week'
task clear_matches :environment do
  Cleaner.perform()
end