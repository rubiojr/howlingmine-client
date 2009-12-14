module HowlingMine
  module Client

    class << self
      def new_issue
        post_ticket
      end

      def post_ticket
        RestClient.post("#{HowlingMine::Config.protocol}://#{HowlingMine::Config.host}:#{HowlingMine::Config.port}/ticket_server/new_issue", HowlingMine::Config.params.merge(:api_key => HowlingMine::Config.api_key))
      end

      def issue_status
        RestClient.post("#{HowlingMine::Config.protocol}://#{HowlingMine::Config.host}:#{HowlingMine::Config.port}/ticket_server/issue_status", :api_key => HowlingMine::Config.api_key, :issue_id => HowlingMine::Config.params[:issue_id])
      end
      def issues
        RestClient.post("#{HowlingMine::Config.protocol}://#{HowlingMine::Config.host}:#{HowlingMine::Config.port}/ticket_server/issues", :api_key => HowlingMine::Config.api_key, :issue_id => HowlingMine::Config.params[:issue_id])
      end
      def projects 
        RestClient.post("#{HowlingMine::Config.protocol}://#{HowlingMine::Config.host}:#{HowlingMine::Config.port}/ticket_server/projects", :api_key => HowlingMine::Config.api_key, :issue_id => HowlingMine::Config.params[:issue_id])
      end
      def journals 
        RestClient.post("#{HowlingMine::Config.protocol}://#{HowlingMine::Config.host}:#{HowlingMine::Config.port}/ticket_server/journals", :api_key => HowlingMine::Config.api_key, :issue_id => HowlingMine::Config.params[:issue_id])
      end
    end
  end

end
