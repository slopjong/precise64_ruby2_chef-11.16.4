#!/bin/bash

# the original base box comes with chef 10.14.2 but the apt recipe requires a newer chef

chef_version=$(gem list chef | grep chef | awk -F '[()]' {'print ($2)'} |tr -d "[\r\n]")
chef_install_version=11.16.4

echo -n "Gem Version:" $chef_version

if [ "$chef_version" != "$chef_install_version" ] ; then

    echo "Uninstalling version prior $chef_install_version"
    gem uninstall --version '< 11.16.4' chef
    echo "--- Updating Chef"
    apt-get install make --yes
    echo "   --- installing chef"
    gem install -no-rdoc --no-ri --version $chef_install_version chef

    echo "   --- set chef path"
    echo "export PATH=$PATH:$(dirname $(ruby -r rubygems -e "p Gem.bin_path('chef','chef-client')") | cut -d "\"" -f 2)" > /etc/profile.d/chef.sh

else
    echo "--- Skipping Chef update."
fi
