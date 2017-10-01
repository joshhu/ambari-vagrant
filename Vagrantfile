# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # Every Vagrant virtual environment requires a box to build off of.
  #config.vm.box = "ubuntu14.4"
  config.vm.box = "ubuntu/trusty64"

  config.vm.synced_folder ".", "/vagrant",
      owner: "root", group: "root"
  #
  # Fixes changes from https://github.com/mitchellh/vagrant/pull/4707
    
  # 建立虛擬機之後，在虛擬機中執行的程式
  config.vm.provision "shell", path: "bootstrap.sh"
  #

  config.ssh.insert_key = false

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.

  # Ubuntu 14.04 x64 VM with VirtualBox 4.3.10 Guest Additions
  #config.vm.box_url = "http://naruh.sakura.ne.jp/vagrant/ubuntu-14-04-x64-virtualbox.box"


  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", 4096] # RAM allocated to each VM
  end


  config.vm.define :u1401 do |u1401|
    # uncomment the line below to set up the ambari dev environment
    # u1401.vm.provision :shell, :path => "dev-bootstrap.sh"
    u1401.vm.hostname = "u1401.ambari.apache.org"
    u1401.vm.network :private_network, ip: "192.168.14.101"
    u1401.vm.provision "shell", inline: "echo never > /sys/kernel/mm/transparent_hugepage/enabled"
    u1401.vm.provision "shell", inline: "locale-gen zh_TW.UTF-8"
    #u1401.vm.network :forwarded_port, guest: 8080, host: 8080
  end

  config.vm.define :u1402 do |u1402|
    u1402.vm.hostname = "u1402.ambari.apache.org"
    u1402.vm.network :private_network, ip: "192.168.14.102"
    u1402.vm.provision "shell", inline: "echo never > /sys/kernel/mm/transparent_hugepage/enabled"
    u1402.vm.provision "shell", inline: "locale-gen zh_TW.UTF-8"
  end

  config.vm.define :u1403 do |u1403|
    u1403.vm.hostname = "u1403.ambari.apache.org"
    u1403.vm.network :private_network, ip: "192.168.14.103"
    u1403.vm.provision "shell", inline: "echo never > /sys/kernel/mm/transparent_hugepage/enabled"
    u1403.vm.provision "shell", inline: "locale-gen zh_TW.UTF-8"
  end
end
