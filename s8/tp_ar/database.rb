require 'active_record'
require_relative 'lib/person'

config_file = File.join(File.dirname(__FILE__),"config","database.yml")

puts YAML.load(File.open(config_file)).inspect

ActiveRecord::Base.establish_connection(YAML.load(File.open(config_file))["development"])
