module HowlingMine
  class Issue
  
    attr_accessor :id, :subject, :description, :raw, :author
    attr_writer :created_on, :updated_on
  
    def custom_fields
      @custom_fields ||= {}
    end
    
    def method_missing(name, *args)
      cf = custom_fields[name]
      if cf
        cf['value']
      else
        super
      end
    end
    
    def save
      client = HowlingMine::Client
      params = {
        :subject => subject || 'no subject',
        :description => description || '',
        :author => author || 'none',
        :custom_fields => custom_fields.to_yaml
      }
    
      HowlingMine::Config.params.merge!(params)
      
      begin
        response = client.new_issue
        @id = response.to_i
        return true
      rescue Exception => e
        return false
      end
    end
  
    def self.find(method = :all, params = {})
      params[:method] = method
      HowlingMine::Config.params.merge!(params)
      build_issues(HowlingMine::Client.find)
    end
    
    def self.all
      build_issues(HowlingMine::Client.issues)
    end
    
    def updated_on
      Time.parse @updated_on
    end
  
    def created_on
      Time.parse @created_on
    end
  
    def self.first
      find :first
    end
  
    def self.last
      find :last
    end
  
    def status
      c = HowlingMine::Client
      HowlingMine::Config.params.merge!(:issue_id => id)
      c.issue_status.downcase
    end
  
    def self.get(ticket_no)
      find ticket_no.to_i
    end
  
    def journal
      client = HowlingMine::Client
      params = {
        :issue_id => id
      }
      HowlingMine::Config.params.merge! params
      JSON.parse(client.journals)
    end
    
    private
    def self.build_issues(json)
      issues = []
      elems = JSON.parse json
      if elems.is_a? Array
        elems.each do |i|
          issue = Issue.new
          issue.subject = i['subject']
          issue.description = i['description']
          issue.id = i['id'].to_i
          issue.raw = i
          issue.created_on = i['created_on']
          issue.updated_on = i['updated_on']
          if i['custom_fields']
            i['custom_fields'].each do |k,v|
              issue.custom_fields[k.to_sym] = v
            end
          end
          issues << issue
        end
        return issues
      else
        i = elems
        issue = Issue.new
        issue.subject = i['subject']
        issue.description = i['description']
        issue.id = i['id'].to_i
        issue.raw = i
        issue.created_on = i['created_on']
        issue.updated_on = i['updated_on']
        if i['custom_fields']
          i['custom_fields'].each do |k,v|
            issue.custom_fields[k.to_sym] = v
          end
        end
        return issue
      end
    end
  end
end