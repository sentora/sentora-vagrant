# -*- mode: ruby -*-
# vi: set ft=ruby :

Box = 'ubuntu'

Base = "#{File.dirname(__FILE__)}"
require 'yaml'
require Base + '/script/Sentora.rb'

BoxConf = YAML::load( File.read(Base + '/script/'+Box+'.yaml') )
UserConfig = YAML::load( File.read(Base + '/Config.yaml') )

Vagrant.configure(2) do |config|
 	Sentora.Conf( config , BoxConf , UserConfig )
end
