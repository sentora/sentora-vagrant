class Sentora
	def Sentora.Conf(config , box , user)
		config.vm.box = box['boxName']
		config.vm.box_url = box['boxUrl']

		config.vm.network :private_network, ip: user["privateIp"] ||= "192.168.33.18"
		config.vm.network :public_network, ip: user["localIp"] ||= "192.168.1.18"
		config.vm.provider "virtualbox" do |vb|
		  vb.name = box['vbName']
		  vb.customize ["modifyvm", :id, "--memory", user["memory"] ||= "1024"]
		  vb.customize ["modifyvm", :id, "--cpus", user["cpus"] ||= "1"]
		  vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
		  vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
		end
	end
end
