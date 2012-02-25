require 'uuidtools'
require File.dirname(__FILE__)+"/log_admin"

class Logger
  def log_success(hash)
    log(hash)
  end
  
  def log_failure(hash)
    log(hash)
  end

  private

  def log(hash)
    LogAdmin.new.add_url_log(hash)
  end
end
