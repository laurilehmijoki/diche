require 'uuidtools'
require File.dirname(__FILE__)+"/../common/aws_helper"

class Logger
  def log_success(hash)
    log(hash)
  end
  
  def log_failure(hash)
    log(hash)
  end

  private

  def log(hash)
    table_url_logs = AWSHelper.table_url_logs
    
    hash.store("uuid", UUIDTools::UUID.random_create.to_s)
    hash.store("created", Time.new.to_s)
    table_url_logs.items.create(hash)
    hash['uuid']
  end
end
