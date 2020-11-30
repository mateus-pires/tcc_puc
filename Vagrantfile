# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "puphpet/debian75-x64"

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "4096"]
    vb.customize ["modifyvm", :id, "--cpus", "1"]
  end

  config.vm.define "vert000" do |node|
    node.vm.network :forwarded_port, guest: 5433, host: 5433
    node.vm.network "private_network", ip: "192.168.56.105", virtualbox__intnet: "vboxnet0"
    node.vm.provision "shell", inline: "echo 'vert000' > /etc/hostname; hostname -F /etc/hostname"
    node.vm.provision "shell", inline: "echo 127.0.0.1 `hostname` >> /etc/hosts"
    node.vm.provision "shell", path: "puppet_provision_script.sh"
    node.vm.synced_folder ".", "/vagrant", disabled: false

	node.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "3000"]
    end

#    config.vm.provider :virtualbox do |vb|
#      file_to_disk = './data/vertica_second_disk.vdi'
#      size_to_disk = 10 * 1024 # size in MB
#      unless File.exist?(file_to_disk)   # only creates disk if not have created yet
#        vb.customize ['createhd', '--filename', file_to_disk, '--size', size_to_disk]
#      end
#      vb.customize ['storageattach', :id, '--storagectl', 'IDE Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', file_to_disk]
#      vb.customize ["modifyvm", :id, "--cpus", "1"]
#    end
  end 

  config.vm.define "mysq000" do |node|
    node.vm.network :forwarded_port, guest: 3306, host: 3306
    node.vm.network "private_network", ip: "192.168.56.106", virtualbox__intnet: "vboxnet0"
    node.vm.provision "shell", inline: "echo 'mysq000' > /etc/hostname; hostname -F /etc/hostname"
    node.vm.provision "shell", inline: "echo 127.0.0.1 `hostname` >> /etc/hosts"
    node.vm.provision "shell", path: "mysql_install.sh"
    node.vm.synced_folder ".", "/vagrant", disabled: false
  end 
  
  config.vm.define "dpdin" do |node|
    #config.vm.network "public_network"
#    config.vm.network "public_network", ip: "192.168.1.17", bridge: "en1: Wi-Fi (AirPort)"
    node.vm.network :forwarded_port, guest: 8080, host: 3030
	node.vm.network :forwarded_port, guest: 22, host: 1010
    node.vm.network "private_network", ip: "192.168.56.107", virtualbox__intnet: "vboxnet0"
    node.vm.provision "shell", inline: "echo 'dpdin' > /etc/hostname; hostname -F /etc/hostname"
    node.vm.provision "shell", inline: "echo 127.0.0.1 `hostname` >> /etc/hosts"
    node.vm.synced_folder ".", "/vagrant", disabled: false
  end 

end
