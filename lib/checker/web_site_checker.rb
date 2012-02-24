require 'rubygems'
require 'eventmachine'
require 'em-http'

class WebSiteChecker

  def initialize(urls, logger)
    @urls = urls
    @logger = logger
  end 

  def check
    @handled_urls = 0
    EM.run {
      @urls.each{ |url|
        start = Time.now
        request = EM::HttpRequest.new(url).get
        
        request.callback {
          @logger.log_success({"url"=>url, "code"=>request.response_header.status, "latency"=>(Time.now - start)})
          on_done
        }

        request.errback {
          @logger.log_failure({"url"=>url, "message"=>request.error})
          on_done
        }
      }
    }    
  end

  def on_done
    @handled_urls += 1
    EM::stop_event_loop if @handled_urls == @urls.length # Stop the loop after we've handled all the URLs
  end
end
