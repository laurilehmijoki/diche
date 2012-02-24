require 'yaml'
require 'aws-sdk'

class AWSHelper

  @@dynamo_db = nil
  
  def self.dynamo_db
    if @@dynamo_db != nil
      return @@dynamo_db # For performance reasons, load only once
    end
    config_file = "aws.yml"
    aws_config_file = File.dirname(__FILE__)+"/../../config/#{config_file}"
    raise("Oops! You seem to have forgotten to create the config file #{aws_config_file}") unless File.exists?(aws_config_file)
    config = YAML::load(File.open(aws_config_file))
    @@dynamo_db = AWS::DynamoDB.new({"access_key_id"=>config['key'], "secret_access_key"=>config['secret']}) 
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
