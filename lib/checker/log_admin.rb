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
end
