require 'rspec'
require File.dirname(__FILE__)+"/../../lib/logger"

describe Logger do
  it "writes a log record into AWS DynamoDB" do
    logger = Logger.new("aws-test.yml")
    uuid = logger.log_success({"url"=>"http://google.fi"})

    dynamo_db_table = AWSHelper.dynamo_db_table("aws-test.yml")
    dynamo_db_table.batch_get(:all, uuid).each_with_index{ |result, index| 
      index.should == 0 # There should be exactly result
      result['url'].should == "http://google.fi"
    }
  end
end 
