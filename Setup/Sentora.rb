class Sentora
	def Sentora.Conf(config , box , user)
		config.vm.box = box['boxName']
		config.vm.box_url = box['boxUrl']

		if user["privateIp"] != false
			config.vm.network :private_network, ip: user["privateIp"]
		end

		if user["publicIp"] != false
			config.vm.network :public_network, ip: user["publicIp"]
		end



# mount : themes, modules, apps
		if user['themes'] != false
			user['themes'].each do |_theme|
				config.vm.synced_folder _theme["path"]+_theme["name"], '/var/added/themes/'+ _theme["name"], type: _theme["type"] ||= nil
			end
		end

		if user['modules'] != false
			user['modules'].each do |_module|
				config.vm.synced_folder _module["path"]+_module["name"], '/var/added/modules/'+ _module["name"], type: _module["type"] ||= nil
			end
		end

		if user['apps'] != false
			user['apps'].each do |_app|
				config.vm.synced_folder _app["path"]+_app["name"], '/var/added/apps/'+ _app["name"], type: _app["type"] ||= nil
			end
		end

		config.vm.provider "virtualbox" do |vb|
		  vb.name = box['vbName']
		  vb.customize ["modifyvm", :id, "--memory", user["memory"] ||= "1024"]
		  vb.customize ["modifyvm", :id, "--cpus", user["cpus"] ||= "1"]
		  vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
		  vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
		end
	end
end
