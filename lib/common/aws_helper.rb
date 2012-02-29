require 'yaml'
require 'aws-sdk'
require File.dirname(__FILE__)+"/configuration"

class AWSHelper
  @@dynamo_db = nil
  def self.dynamo_db
    if @@dynamo_db != nil
      return @@dynamo_db # For performance reasons, load only once
    end
    config = Configuration.new
    username = config.get_db_username
    password = config.get_db_password
    @@dynamo_db = AWS::DynamoDB.new({"access_key_id"=>username, "secret_access_key"=>password}) 
  end

  def self.table_url_logs
    table = dynamo_db.tables['url_logs']
    table.load_schema unless table.schema_loaded?
  end

  def self.table_urls
    table = dynamo_db.tables['urls']
    table.load_schema unless table.schema_loaded?
  end
end
