module HowlingMine
  class Config
    
    attr_accessor :api_key
    
    def self.api_key
      params[:api_key]
    end
    
    def self.api_key=(k)
      params[:api_key] = k
    end
    
    def self.params
      @@params ||= {}
    end
    
    def self.host
      @@host ||= 'localhost'
    end
    
    def self.host=(h)
      @@host = h
    end
    
    def self.port=(p)
      @@port = p
    end
    
    def self.port
      @@port ||= 80
    end
    
    def self.use_ssl
      @@use_ssl ||= false
    end
    
    def self.use_ssl=(yn)
      @@use_ssl ||= yn
    end

    def self.path
      @@path ||= ''
    end

    def self.path=(p)
      @@path = p
    end
    
    def self.project
      params[:project]
    end
    
    def self.project=(p)
      params[:project] = p
    end
    
    def self.protocol
      use_ssl ? 'https' : 'http'
    end
    
    def self.tracker=(t)
      params[:tracker] = t
    end
    
    def self.tracker
      params[:tracker] ||= 'Bug'
    end
  end
end
