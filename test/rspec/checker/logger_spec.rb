require 'rspec'
require File.dirname(__FILE__)+"/../../../lib/checker/logger"

describe Logger do
  it "writes a log record into AWS DynamoDB" do
    logger = Logger.new
    url = "http://google#{rand(1000000)}.fi"
    uuid = logger.log_success({"url"=>url})

    table_url_logs = AWSHelper.table_url_logs
    item_found = false
    table_url_logs.items.each{ |item|
      item_found = true if item.attributes['url'] == url 
    }
    item_found.should == true
  end
end 
