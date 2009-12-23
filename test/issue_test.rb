require 'test/unit'
require "#{File.join(File.dirname(__FILE__),'../lib/howlingmine.rb')}"

class TestIssue < Test::Unit::TestCase

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
    assert_raises RestClient::RequestFailed do
      HowlingMine::Issue.all
    end
    
    assert_nothing_raised do
      HowlingMine::Config.api_key = 'FboVJFYVg84avd2dfL3Y'
      HowlingMine::Issue.all
    end
  end
  
  def test_empty_issues
    assert HowlingMine::Issue.all.empty?
  end
  
  def test_subject
    issue = HowlingMine::Issue.new
    issue.subject = 'issue number one'
    issue.save
    issue = HowlingMine::Issue.get 1
    issue.subject == 'issue number one'
  end
  
  def test_get
    issue = HowlingMine::Issue.new
    issue.subject = 'issue number one'
    assert issue.save    
    issue = HowlingMine::Issue.get 1
    assert ! issue.nil?
    assert issue.subject == 'issue number one'
  end
  
  def test_new_issue
    issue = HowlingMine::Issue.new
    issue.subject = 'issue number one'
    assert_nothing_raised do 
      assert issue.save
    end
    
    assert HowlingMine::Issue.all.size == 1
    
    issue = HowlingMine::Issue.new
    issue.subject = 'issue number 2'
    issue.description = 'stuff'
    assert issue.save
    assert issue.id == 2
    assert HowlingMine::Issue.all.size == 2
  end
  
  def test_last_issue
    issue = HowlingMine::Issue.new
    issue.subject = 'issue number one'
    assert issue.save
    assert issue.id == HowlingMine::Issue.last.id
    assert HowlingMine::Issue.last.id == 1
  end
  
  def test_first_issue
    issue = HowlingMine::Issue.new
    issue.subject = 'issue number one'
    assert issue.save
    assert issue.id == HowlingMine::Issue.first.id
    assert HowlingMine::Issue.first.id == 1
  end
  
  def test_journal
    issue = HowlingMine::Issue.new
    issue.subject = 'issue number 1'
    issue.save
    assert issue.journal.size == 0
    issue.description = 'comment one'
    issue.save
    assert issue.journal.size == 1    
  end
  
  def test_save
    issue = HowlingMine::Issue.new
    issue.subject = 'issue number 1'
    issue.description = 'description'
    assert issue.save
    issue = HowlingMine::Issue.get 1
    assert issue.subject == 'issue number 1'
    assert issue.description == 'description'
    
    assert_nothing_raised do
      issue = HowlingMine::Issue.new
      assert issue.save
      assert HowlingMine::Issue.all.size == 2
    end
  end
  
  def test_custom_fields
     issue = HowlingMine::Issue.new
     issue.subject = 'issue number 1'
     issue.description = 'description'
     issue.custom_fields[:foofield1] = 'value1'
     assert issue.save
     
     issue = HowlingMine::Issue.get 1
     assert issue.custom_fields.size == 1
     assert issue.foofield1 == 'value1'
     assert_raises NoMethodError do
       assert issue.unexistant_method98847
     end
  end
  
  def test_find
    assert HowlingMine::Issue.find(:all).size == 0
    issue = HowlingMine::Issue.new
    issue.subject = 'issue number 1'
    issue.description = 'description'
    issue.custom_fields[:foofield1] = 'value1'
    assert issue.save
    issue = HowlingMine::Issue.find :first
    assert issue != nil
    assert issue.subject == 'issue number 1'
    issue = HowlingMine::Issue.find :last
    assert issue != nil
    assert issue.subject == 'issue number 1'
    issue = HowlingMine::Issue.find 1
    assert issue != nil
    assert issue.subject == 'issue number 1'
    assert_raises RestClient::ResourceNotFound do 
      HowlingMine::Issue.find 0
    end
    assert_raises RestClient::ResourceNotFound do 
      HowlingMine::Issue.find 2
    end
    
    # test find offset and limit
    1.upto 50 do |i|
      issue = HowlingMine::Issue.new
      issue.subject = "issue number #{i}"
      issue.save
    end
    issues = HowlingMine::Issue.find :all,:limit => 10
    assert issues.size == 10
    assert issues.last.subject == 'issue number 10'
    
    #FIXME: test fails
    #issues = HowlingMine::Issue.find :all, :limit => 10, :offset => 5
    #assert issues.first.subject == 'issue number 5'    
    
    #FIXME: test fails
    #assert_raises RestClient::RequestFailed do
    #  HowlingMine::Issue.find :all, :limit => 10, :offset => 11
    #end
  end
  
  def test_count
    assert HowlingMine::Issue.count == 0
    issue = HowlingMine::Issue.new
    issue.subject = 'issue number 1'
    issue.description = 'description'
    assert issue.save
    issue = HowlingMine::Issue.count == 1
  end

end
