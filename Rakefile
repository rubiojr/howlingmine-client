# -*- ruby -*-

require 'rubygems'
require 'hoe'
require './lib/howlingmine.rb'

Hoe.spec 'howlingmine-client' do |p|
  p.version = HowlingMine::VERSION
  p.developer('Sergio Rubio', 'sergio@rubio.name')
  p.summary = 'Client library for the Howling Mine Server'
  p.description = 'Client library for the Howling Mine Server'
  p.url = 'http://github.com/rubiojr/howlingmine-client'
  p.test_globs = ['test/*_test.rb']
end

# vim: syntax=Ruby

task :restore_redmine_db do
  FileUtils.cp 'redmine_test_files/redmine.db','/opt/redmine-0.8/db/redmine.db'
end
