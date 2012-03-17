require File.dirname(__FILE__)+"/../common/aws_helper"
require File.dirname(__FILE__)+"/../common/region"
require 'uuidtools'
require 'socket'

class Database
  def add_url(url)
    hash = {"url"=>url}
    AWSHelper.table_urls.items.create(add_common_attributes(hash))
    hash['uuid']
  end

  def add_url_log(hash)
    table_url_logs = AWSHelper.table_url_logs
    table_url_logs.items.create(add_common_attributes(hash))
    hash['uuid']
  end

  def delete_urls
    AWSHelper.table_urls.items.select.each { |item_data|
      item_data.item.delete
    } 
  end

  def delete_url_logs
    AWSHelper.table_url_logs.items.select.each { |item_data|
      item_data.item.delete
    } 
  end

  def load_urls
    urls = Array.new
    AWSHelper.table_urls.items.each{ |item|
      urls.push(item.attributes["url"])
    }
    urls
  end

  # Loads URL logs from the database
  # If 'since' (a Time instance) is defined, loads entries that have been added after that date.
  def load_url_logs(since=nil, region=Region.region)
    logs = Array.new
    lowbound = since == nil ? Time.at(0) : since
    AWSHelper.table_url_logs.items.query({:hash_value=>region, :range_gte=>lowbound.to_i}){ |item|
      logs.push(item.attributes.to_h)
    }
    logs
  end

  private

  def add_common_attributes(hash)
    hash.store("uuid", UUIDTools::UUID.random_create.to_s)
    hash.store("region", Region.region)
    hash.store("hostname", Socket.gethostname)
    hash.store("date", Time.new.to_i)
    hash
  end
end
