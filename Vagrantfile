# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  # config.vm.provision :shell, :path => "scripts/replace-apt-repository.sh"

  config.vm.provision :shell, :path => "scripts/ruby-update.sh"
  config.vm.provision :shell, :path => "scripts/chef-update.sh"

end