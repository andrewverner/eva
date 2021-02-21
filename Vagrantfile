# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/bionic64"

  config.vm.network "private_network", ip: "192.168.100.70"

  config.vm.synced_folder "./", "/var/www/html",
    id: "vagrant-root",
    :group=>'www-data',
    :mount_options=>['dmode=775,fmode=775']

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
    vb.cpus = 2
  end

  config.ssh.insert_key = false

end
