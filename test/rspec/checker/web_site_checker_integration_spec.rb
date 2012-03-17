require 'rspec'
require File.dirname(__FILE__)+"/../../../lib/checker/web_site_checker"

describe WebSiteChecker do
  it "logs a non-exiting host as failure" do
    logger = mock(:logger)
    logger.should_receive(:log_failure).once
    
    checker = WebSiteChecker.new(["http://foo"], logger) 
    checker.check
  end

  it "it logs Google front page as success" do
    logger = mock(:logger)
    logger.should_receive(:log_success).once
    
    checker = WebSiteChecker.new(["http://google.fi"], logger) 
    checker.check
  end
end
