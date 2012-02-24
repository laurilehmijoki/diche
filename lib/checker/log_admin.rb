require File.dirname(__FILE__)+"/../common/aws_helper"
require 'uuidtools'

class LogAdmin
  def add_url(url)
    hash = {"url"=>url}
    hash.store("uuid", UUIDTools::UUID.random_create.to_s)
    hash.store("created", Time.new.to_s)
    AWSHelper.table_urls.items.create(hash)
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
end
