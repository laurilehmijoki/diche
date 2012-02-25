require 'rspec'
require File.dirname(__FILE__)+"/../../../lib/checker/log_admin"

describe LogAdmin do

  it "adds new URLs into the database" do
    uuid = LogAdmin.new.add_url("http://google.fi")

    AWSHelper.table_urls.batch_get(:all, uuid).each_with_index{ |result, index| 
      index.should == 0 # There should be exactly result
      result['url'].should == "http://google.fi"
    }
  end

  it "reads URLs from the database" do
    url = "http://google#{rand(100000)}.fi"
    LogAdmin.new.add_url(url)
    
    urls = LogAdmin.new.list_urls
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
end 
