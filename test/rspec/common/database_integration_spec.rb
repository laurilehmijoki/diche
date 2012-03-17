require 'rspec'
require File.dirname(__FILE__)+"/../../../lib/common/database"

describe Database do

  it "adds new URLs into the database" do
    uuid = Database.new.add_url("http://google.fi")

    AWSHelper.table_urls.batch_get(:all, uuid).each_with_index{ |result, index| 
      index.should == 0 # There should be exactly result
      result['url'].should == "http://google.fi"
    }
  end

  it "reads URLs from the database" do
    url = "http://google#{rand(100000)}.fi"
    Database.new.add_url(url)
    
    urls = Database.new.load_urls
    url_read = urls.include?url
    url_read.should == true
  end

  it "deletes URLs from the database" do
    pending
  end

  it "reads log entries from the database" do
    pending
  end

  it "deletes log entries from the database" do
    pending
  end

  it "loads all log entries from the database" do
    pending
  end

  it "reads [newer-than-date] log entries from the database" do
    now = Time.new
    Database.new.add_url_log({"message"=>now.to_s})
    logs = Database.new.load_url_logs(now-1)

    logs.one?{|log| log['message'] == now.to_s}.should == true
  end
end 
