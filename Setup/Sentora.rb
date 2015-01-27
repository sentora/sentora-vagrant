class Sentora
	def Sentora.Conf(config , box , devConfig)
		config.vm.box = box['boxName']
		config.vm.box_url = box['boxUrl']

		if devConfig["privateIp"] != false
			config.vm.network :private_network, ip: devConfig["privateIp"]
		end

		if devConfig["publicIp"] != false
			config.vm.network :public_network, ip: devConfig["publicIp"]
		end

		config.vm.provision "shell" do |shell|
			shell.inline = "/vagrant/Setup/provision.sh $1 $2"
			shell.args = [devConfig['sentora']['tag'] , devConfig['sentora']['subDomain']]
		end

		config.vm.synced_folder './Core/sentora-core/', '/etc/sentora/',
					:owner =>"root", :group => "root", :mount_options => ['dmode=777,fmode=777']

# mount : themes, modules, apps
		if devConfig['themes'] != false
			devConfig['themes'].each do |_theme|
				config.vm.synced_folder _theme["path"]+_theme["name"], '/var/added/themes/'+ _theme["name"],
					:owner =>"root", :group => "root", :mount_options => ['dmode=777,fmode=777']
			end
		end

		if devConfig['modules'] != false
			devConfig['modules'].each do |_module|
				config.vm.synced_folder _module["path"]+_module["name"], '/var/added/modules/'+ _module["name"],
					:owner =>"root", :group => "root", :mount_options => ['dmode=777,fmode=777']
			end
		end

		if devConfig['apps'] != false
			devConfig['apps'].each do |_app|
				config.vm.synced_folder _app["path"]+_app["name"], '/var/added/apps/'+ _app["name"],
					:owner =>"root", :group => "root", :mount_options => ['dmode=777,fmode=777']
			end
		end

		config.vm.provider "virtualbox" do |vb|
		  vb.name = box['vbName']
		  vb.customize ["modifyvm", :id, "--memory", devConfig["memory"] ||= "1024"]
		  vb.customize ["modifyvm", :id, "--cpus", devConfig["cpus"] ||= "1"]
		  vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
		  vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
		end
	end
end
