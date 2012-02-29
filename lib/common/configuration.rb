require 'yaml'

class Configuration
  def initialize(home=ENV['HOME'])
    yml_dir = home+"/.diche"
    Dir::mkdir(yml_dir) unless File.exists?(yml_dir)
    @yml_file = yml_dir + "/config.yml"
  end  
  def prompt_and_save_creds
    login = enter_login
    password = enter_password
    yaml = YAML::dump({"key"=>login, "secret"=>password})
    File.open(@yml_file, 'w'){|f| f.write(yaml) }
    puts "Saved credentials to #{@yml_file}"
  end
  def get_db_password
    yaml = YAML::load(File.open(@yml_file))
    yaml['secret']
  end
  def get_db_username
    yaml = YAML::load(File.open(@yml_file))
    yaml['key']
  end
  def enter_login
    print "Please enter the AWS DynamoDB key: "
    gets.chomp
  end 
  def enter_password
    print "... and the AWS DynamoDB secret key: "
    gets.chomp
  end
end
