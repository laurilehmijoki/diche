require 'uuidtools'
require File.dirname(__FILE__)+"/../common/database"

class Logger
  def log_success(hash)
    log(hash)
  end
  
  def log_failure(hash)
    log(hash)
  end

  private

  def log(hash)
    Database.new.add_url_log(hash)
  end
end
