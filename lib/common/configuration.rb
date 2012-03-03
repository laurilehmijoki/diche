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
  def error_if_config_missing
    unless File.exists?@yml_file
      raise "Configuration file missing - please run setup first." 
    end
  end
  def get_db_password
    error_if_config_missing
    yaml = YAML::load(File.open(@yml_file))
    yaml['secret']
  end
  def get_db_username
    error_if_config_missing
    yaml = YAML::load(File.open(@yml_file))
    yaml['key']
  end
  def enter_login
    puts "Please enter the database username: "
    $stdin.gets.chomp
  end 
  def enter_password
    puts "... and the database password: "
    $stdin.gets.chomp
  end
end
