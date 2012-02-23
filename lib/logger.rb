require 'yaml'
require 'aws-sdk'
require 'uuidtools'

module AWSHelper
  def self.dynamo_db_table(config_file)
    aws_config_file = File.dirname(__FILE__)+"/../config/#{config_file}"
    raise("Oops! You seem to have forgotten to create the config file #{aws_config_file}") unless File.exists?(aws_config_file)
    config = YAML::load(File.open(aws_config_file))
    dynamo_db = AWS::DynamoDB.new({"access_key_id"=>config['key'], "secret_access_key"=>config['secret']}) 
    table = dynamo_db.tables[config['table']]
    table.load_schema
  end
end

class Logger

  def initialize(config_file="aws.yml")
    @dynamo_db_table = AWSHelper::dynamo_db_table(config_file)
  end 
  def log_success(hash)
    log(hash)
  end
  
  def log_failure(hash)
    log(hash)
  end

  private

  def log(hash)
    hash.store("uuid", UUIDTools::UUID.random_create.to_s)
    hash.store("created", Time.new.to_s)
    @dynamo_db_table.items.create(hash)
    hash['uuid']
  end
end
