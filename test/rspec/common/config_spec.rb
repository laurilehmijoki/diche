require 'rspec'

require 'yaml'
class Config
  def initialize(home=ENV['HOME'])
    yml_dir = home+"/.diche"
    Dir::mkdir(yml_dir)
    @yml_file = yml_dir + "/config.yml"
  end  
  def prompt_and_save_creds
    login = enter_login
    password = enter_password
    yaml = YAML::dump({"key"=>login, "secret"=>password})
    File.open(@yml_file, 'w').write {|f| f.puts yaml}
  end

  def enter_login
    print "Please enter the AWS DynamoDB key: "
    gets.chomp
  end 
  def enter_password
    print "... and the AWS DynamoDB secret key: "
    gets.chomp
end
describe Config do
  it "prompts for database credentials and writes them to a YAML file" do
    config = Config.new("/tmp")
    config.stub(:enter_login).and_return("mylogin")
    config.stub(:enter_password).and_return("hack me")
    config.prompt_and_save_creds

    yaml = YAML::load("/tmp/.diche/config.yml")
    yaml['key'].should == "mylogin"
    yaml['secret'].should == "hack me"
  end
end
