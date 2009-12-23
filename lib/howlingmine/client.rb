module HowlingMine
  module Client

    class << self
      def new_issue
        post_ticket
      end

      def post_ticket
        RestClient.post("#{HowlingMine::Config.protocol}://#{HowlingMine::Config.host}:#{HowlingMine::Config.port}/howling_mine/new_issue", HowlingMine::Config.params.merge(:api_key => HowlingMine::Config.api_key))
      end

      def issue_status
        RestClient.post("#{HowlingMine::Config.protocol}://#{HowlingMine::Config.host}:#{HowlingMine::Config.port}/howling_mine/issue_status", :api_key => HowlingMine::Config.api_key, :issue_id => HowlingMine::Config.params[:issue_id])
      end
      def issues
        RestClient.post("#{HowlingMine::Config.protocol}://#{HowlingMine::Config.host}:#{HowlingMine::Config.port}/howling_mine/issues", :api_key => HowlingMine::Config.api_key, :issue_id => HowlingMine::Config.params[:issue_id])
      end
      def projects 
        RestClient.post("#{HowlingMine::Config.protocol}://#{HowlingMine::Config.host}:#{HowlingMine::Config.port}/howling_mine/projects", :api_key => HowlingMine::Config.api_key, :issue_id => HowlingMine::Config.params[:issue_id])
      end
      def journals 
        RestClient.post("#{HowlingMine::Config.protocol}://#{HowlingMine::Config.host}:#{HowlingMine::Config.port}/howling_mine/journals", :api_key => HowlingMine::Config.api_key, :issue_id => HowlingMine::Config.params[:issue_id])
      end
      
      def find
        RestClient.post("#{HowlingMine::Config.protocol}://#{HowlingMine::Config.host}:#{HowlingMine::Config.port}/howling_mine/find", HowlingMine::Config.params.merge(:api_key => HowlingMine::Config.api_key))
      end
      
      def count_issues
        RestClient.post("#{HowlingMine::Config.protocol}://#{HowlingMine::Config.host}:#{HowlingMine::Config.port}/howling_mine/count_issues", HowlingMine::Config.params.merge(:api_key => HowlingMine::Config.api_key))
      end
      
      def plugin_version
        RestClient.post("#{HowlingMine::Config.protocol}://#{HowlingMine::Config.host}:#{HowlingMine::Config.port}/howling_mine/plugin_version", 
          HowlingMine::Config.params.merge(:api_key => HowlingMine::Config.api_key))
      end
      
      def count_projects
        RestClient.post("#{HowlingMine::Config.protocol}://#{HowlingMine::Config.host}:#{HowlingMine::Config.port}/howling_mine/count_issues", HowlingMine::Config.params.merge(:api_key => HowlingMine::Config.api_key))
      end
    end
  end

end
