require 'rspec'
require File.dirname(__FILE__)+"/../../lib/web_site_checker"

class Logger
  def log_success(hash)

  end

  def log_failure(hash)
    puts hash
  end
end

describe WebSiteChecker do
  it "logs a non-exiting host as failure" do
    logger = Logger.new
    logger.should_receive(:log_failure).once
    
    checker = WebSiteChecker.new(["http://foo"], logger) 
    checker.check
  end

  it "it logs Google front page as success" do
    logger = Logger.new
    logger.should_receive(:log_success).once
    
    checker = WebSiteChecker.new(["http://google.fi"], logger) 
    checker.check
  end
end
