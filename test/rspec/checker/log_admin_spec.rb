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
end 
