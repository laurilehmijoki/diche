require 'rspec'
require 'yaml'
require File.dirname(__FILE__)+"/../../../lib/common/configuration"
describe Configuration do
  context "prompts for database credentials" do
    before(:each) do
      config = Configuration.new("/tmp")
      config.stub(:enter_login).and_return("mylogin")
      config.stub(:enter_password).and_return("hack me")
      config.prompt_and_save_creds
    end
    it "writes them to a YAML file" do
      yaml = YAML::load(File.open("/tmp/.diche/config.yml"))
      yaml['key'].should == "mylogin"
      yaml['secret'].should == "hack me"
    end

    it "loads database credentials from a YAML file" do
      config = Configuration.new("/tmp")
      config.get_db_username.should == "mylogin"
      config.get_db_password.should == "hack me"
    end
  end
end
