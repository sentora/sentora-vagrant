class Sentora
	def Sentora.Conf(config , boxConfig , devConfig)
		config.vm.box = boxConfig['boxName']
		config.vm.box_url = boxConfig['boxUrl']

		if devConfig["privateIp"] != false
			config.vm.network :private_network, ip: devConfig["privateIp"]
		end

		if devConfig["publicIp"] != false
			config.vm.network :public_network, ip: devConfig["publicIp"]
		end

		# pass params and run provision
		config.vm.provision "shell" do |shell|
			shell.inline = "/vagrant/Setup/provisions/"+boxConfig['provision']+" $1 $2 $3"
			shell.args = [devConfig['provisionsParams']['subDomain'] , devConfig['provisionsParams']['zadminPass'] , devConfig['provisionsParams']['rootMySqlPass'] ]
		end


		# mount sentora TODO - folders from users sentora git to mount to correct places
		# TODO - are there race conditions when mounting & provisioning? might need a temp cron job if so
		if devConfig['sentora']['path'] != false
			config.vm.synced_folder devConfig['sentora']['path'], '/etc/sentora/',
						:owner =>"root", :group => "root", :mount_options => ['dmode=777,fmode=777']
		else
			abort('no Sentora-core defined in DevConfig.yaml')			
		end

		# mount : themes
		if devConfig['themes'] != false
			devConfig['themes'].each do |_theme|
				config.vm.synced_folder _theme["path"], '/etc/sentora/panel/etc/styles/'+ _theme["name"],
					:owner =>"root", :group => "root", :mount_options => ['dmode=777,fmode=777']
			end
		end
		# mount : modules
		if devConfig['modules'] != false
			devConfig['modules'].each do |_module|
				config.vm.synced_folder _module["path"], '/etc/sentora/panel/modules/'+ _module["name"],
					:owner =>"root", :group => "root", :mount_options => ['dmode=777,fmode=777']
			end
		end
		# mount : apps
		if devConfig['apps'] != false
			devConfig['apps'].each do |_app|
				config.vm.synced_folder _app["path"], '/etc/sentora/panel/etc/apps/'+ _app["name"],
					:owner =>"root", :group => "root", :mount_options => ['dmode=777,fmode=777']
			end
		end

		config.vm.provider "virtualbox" do |vb|
		  vb.name = boxConfig['vbName']
		  vb.customize ["modifyvm", :id, "--memory", devConfig["memory"] ||= "1024"]
		  vb.customize ["modifyvm", :id, "--cpus", devConfig["cpus"] ||= "1"]
		  vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
		  vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
		end
	end
end
