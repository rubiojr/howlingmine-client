require 'test/unit'
require "#{File.join(File.dirname(__FILE__),'../lib/howlingmine.rb')}"

class TestClient < Test::Unit::TestCase

  def setup
    FileUtils.cp 'redmine_test_files/redmine.db','/opt/redmine-0.8/db/redmine.db'
    HowlingMine::Config.host = 'redmine.local'
    HowlingMine::Config.port = 80 # default
    HowlingMine::Config.use_ssl = false # default
    HowlingMine::Config.project = 'howlingmine'
    HowlingMine::Config.tracker = 'Bug' # default
    HowlingMine::Config.api_key = 'FboVJFYVg84avd2dfL3Y'
  end 

  def teardown
  end
  
  def test_api_key
    HowlingMine::Config.api_key = '0'

    assert_nothing_raised do
      HowlingMine::Config.api_key = 'FboVJFYVg84avd2dfL3Y'
      HowlingMine::Client.plugin_version
    end
  end
  
  def test_save_issue
    client = HowlingMine::Client
    params = {
      :subject => 'no subject',
      :description => 'desc',
      :author => 'none',
    }
  
    HowlingMine::Config.params.merge!(params)
    
    assert_nothing_raised do
      response = client.new_issue
      assert response.to_i == 1
    end
  end
  
  def test_count_projects
    assert HowlingMine::Client.count_projects.to_i == 0
  end
  
  def test_count_issues
   assert HowlingMine::Client.count_issues.to_i == 0
   client = HowlingMine::Client
   params = {
     :subject => 'no subject',
     :description => 'desc',
     :author => 'none',
   }
 
   HowlingMine::Config.params.merge!(params)
   client.new_issue
   assert HowlingMine::Client.count_issues.to_i == 1
  end
  
  def test_plugin_version
    assert HowlingMine::Client.plugin_version =~ /(\d.?)+/
  end

end
