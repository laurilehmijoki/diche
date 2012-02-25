require File.dirname(__FILE__)+"/../common/aws_helper"
require 'uuidtools'

class LogAdmin
  def add_url(url)
    hash = {"url"=>url}
    AWSHelper.table_urls.items.create(add_common_attributes(hash))
    hash['uuid']
  end

  def list_urls
    urls = Array.new
    AWSHelper.table_urls.items.each{ |item|
      urls.push(item.attributes["url"])
    }
    urls
  end

  def delete_urls
    AWSHelper.table_urls.items.select.each { |item_data|
      item_data.item.delete
    } 
  end

  def list_url_logs
    logs = Array.new
    AWSHelper.table_url_logs.items.each{ |item|
      logs.push(item.attributes["url"])
    }
    logs
  end

  def add_url_log(hash)
    table_url_logs = AWSHelper.table_url_logs
    table_url_logs.items.create(add_common_attributes(hash))
    hash['uuid']
  end

  private

  def add_common_attributes(hash)
    hash.store("uuid", UUIDTools::UUID.random_create.to_s)
    hash.store("created", Time.new.to_s)
    hash
  end
end
