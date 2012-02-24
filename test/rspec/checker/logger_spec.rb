require 'rspec'
require File.dirname(__FILE__)+"/../../../lib/checker/logger"

describe Logger do
  it "writes a log record into AWS DynamoDB" do
    logger = Logger.new
    uuid = logger.log_success({"url"=>"http://google.fi"})

    table_url_logs = AWSHelper.table_url_logs
    table_url_logs.batch_get(:all, uuid).each_with_index{ |result, index| 
      index.should == 0 # There should be exactly result
      result['url'].should == "http://google.fi"
    }
  end
end 
