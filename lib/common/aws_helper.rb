require 'yaml'
require 'rubygems'
require 'aws-sdk'
require File.dirname(__FILE__)+"/configuration"

class AWSHelper
  @@dynamo_db = nil
  @@table_name_urls = 'urls'
  @@table_name_url_logs = 'url_logs'
  def self.dynamo_db
    if @@dynamo_db != nil
      return @@dynamo_db # For performance reasons, load only once
    end
    config = Configuration.new
    username = config.get_db_username
    password = config.get_db_password
    @@dynamo_db = AWS::DynamoDB.new({"access_key_id"=>username, "secret_access_key"=>password}) 
  end

  def self.create_tables_if_needed
    unless dynamo_db.tables[@@table_name_url_logs].exists?
      puts "Table for URL logs is missing – creating it..."
      dynamo_db.tables.create(@@table_name_url_logs, 25, 25, :hash_key => {:region=> :string}, :range_key=>{:date=>:number})
    end
    unless dynamo_db.tables[@@table_name_urls].exists?
      puts "Table for URLs is missing – creating it..."
      dynamo_db.tables.create(@@table_name_urls, 25, 12, :hash_key => {:url=> :string})
    end
  end

  def self.table_url_logs
    table = dynamo_db.tables[@@table_name_url_logs]
    table.load_schema unless table.schema_loaded?
  end

  def self.table_urls
    table = dynamo_db.tables[@@table_name_urls]
    table.load_schema unless table.schema_loaded?
  end
end
