# -*- mode: ruby -*-
# vi: set ft=ruby :

Box = 'ubuntu'

Base = "#{File.dirname(__FILE__)}"
require 'yaml'
require Base + '/Setup/Sentora.rb'

BoxConf = YAML::load( File.read(Base + '/Setup/'+Box+'.yaml') )
UserConfig = YAML::load( File.read(Base + '/Config.yaml') )

Vagrant.configure(2) do |config|
 	Sentora.Conf( config , BoxConf , UserConfig )
end
