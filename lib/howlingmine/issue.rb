module HowlingMine
  class Issue
  
    attr_accessor :id, :subject, :description, :raw, :created_on
    attr_accessor :updated_on, :author
  
    def save
      client = HowlingMine::Client
      params = {
        :subject => subject || 'no subject',
        :description => description || '',
        :author => author || 'none',
        #:custom_fields => {
        #  :foofield1 => 'field-text'
        #}.to_yaml
      }
    
      HowlingMine::Config.params.merge!(params)
       
      client.new_issue
    end
  
    def self.all
      project = JSON.parse(HowlingMine::Client.projects).find do |p| 
        p['identifier'] == HowlingMine::Config.project
      end
      project_id = ''
      if ! project.nil?
        project_id = project['id']
      else
        raise Exception.new("#{HowlingMine::Config.project} project not found in target Redmine")
      end
      issues = []
      client = HowlingMine::Client
      JSON.parse(client.issues).each do |i|
        next if i['project_id'] != project_id
        issue = Issue.new
        issue.subject = i['subject']
        issue.description = i['description']
        issue.id = i['id']
        issue.raw = i
        issue.created_on = i['created_on']
        issue.updated_on = i['updated_on']
        if i['custom_fields']

        end
        issues << issue
      end
      issues
    end
    
    def updated_on
      Time.parse @updated_on
    end
  
    def created_on
      Time.parse @created_on
    end
  
    def self.first
      all.first
    end
  
    def self.last
      all.last
    end
  
    def status
      c = HowlingMine::Client
      HowlingMine::Config.params.merge!(:issue_id => id)
      c.issue_status.downcase
    end
  
    def self.get(ticket_no)
      all.find do |i| ticket_no.to_i == i.id end
    end
  
    def journal
      client = HowlingMine::Client
      params = {
        :issue_id => id
      }
      HowlingMine::Config.params.merge! params
      JSON.parse(client.journals)
    end
  end
end