# -*- mode: ruby -*-
# vi: set ft=ruby :

Base = "#{File.dirname(__FILE__)}"
require 'yaml'
require Base + '/Setup/Sentora.rb'

UserConfig = YAML::load( File.read(Base + '/DevConfig.yaml') )

BoxConf = YAML::load( File.read(Base + '/Setup/'+UserConfig['box']['name']+'.yaml') )

Vagrant.configure(2) do |config|
 	Sentora.Conf( config , BoxConf[UserConfig['box']['version']] , UserConfig )
end
