require "#{File.join(File.dirname(__FILE__),'../lib/howlingmine.rb')}"

HowlingMine::Config.host = 'redmine.local'
HowlingMine::Config.port = 80 # default
HowlingMine::Config.use_ssl = false # default
HowlingMine::Config.project = 'howlingmine'
HowlingMine::Config.tracker = 'Bug' # default
HowlingMine::Config.api_key = 'OPlv8xfQmmEy0x5yHMrX'

HowlingMine::Issue.all.each do |i|
  puts "-" * 40
  puts "Issue ID:       #{i.id}"
  puts "Subject:        #{i.subject}"
  puts "Created On:     #{i.created_on}"
  puts "Last update:    #{i.updated_on}"
  puts "Issue status:   #{i.status}"
end

issue = HowlingMine::Issue.new
issue.subject = 'issue number one'
issue.description = 'oh my, first issue'
# if an issue with the same subject exist, the default behaviour
# is to update the journal creating another comment
issue.save 

# Get redmine issue #1 and update the journal
issue = HowlingMine::Issue.get 1
if issue
  issue.description = 'another journal entry' # adds a comment to the issue
  issue.save
end

# Get the last issue and print the last update date
issue = HowlingMine::Issue.last
if issue
  puts '-' * 40
  puts "Issue ##{issue.id} updated on: #{issue.updated_on.strftime '%F %H:%M'}"
end