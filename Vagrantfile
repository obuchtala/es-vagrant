# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

$script = <<SCRIPT
echo Provisioning...

cp /vagrant/files/.profile /home/vagrant/

# FIXME: need to install locales - don't know why, ubuntu box comes without working default
if [ ! -f /home/vagrant/fix_locales.stamp ]; then
  sudo locale-gen en_US en_US.UTF-8
  sudo dpkg-reconfigure locales
  touch /home/vagrant/fix_locales.stamp
fi

sh /home/vagrant/scripts/provision.sh

SCRIPT

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.network "private_network", ip: "192.168.50.50"
  config.vm.network :forwarded_port, guest: 9200, host: 9200

  config.vm.provider "virtualbox" do |vb|
    vb.gui = true
    # Use VBoxManage to customize the VM. For example to change memory:
    vb.customize ["modifyvm", :id, "--memory", "4096"]
  end

  config.vm.box = "pussinboots/ubuntu-truly"
  config.vm.provision "shell", inline: $script, privileged: false
end
