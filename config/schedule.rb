#used for debugging and outputting error
set :output, {:error => "log/cron_error_log.log", :standard => "log/cron_log.log"}

every :monday, :at => '1am' do
  rake "clear_matches"
end


=begin
to run on development:
1) whenever --update-crontab --set environment=development
2) crontab -l //verifies whenever ran cron task

TEST CASE:
every 1.minutes do
	rake "clear_matches"
end
=end