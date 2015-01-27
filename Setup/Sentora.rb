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
				puts "Loading theme " + _theme['name']
			end
		end

		if user['modules'] != false
			user['modules'].each do |_module|
				puts "Loading module " + _module['name']
			end
		end

		if user['apps'] != false
			user['apps'].each do |_app|
				puts "Loading app " + _app['name']
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
