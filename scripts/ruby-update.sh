#!/bin/bash

# the original base box comes with ruby 1.8.7-p358 but this version has
# been retired and thus we need to install a newer version
# See https://www.ruby-lang.org/en/news/2013/06/30/we-retire-1-8-7/

ruby_home="/opt/vagrant_ruby"
ruby_version=$(ruby -v | cut -d' ' -f2)
ruby_install_version=2.1.0
ruby_build_version=20141016

if [ -z "$(echo $ruby_version | grep -o $ruby_install_version)" ]
then
    echo "Installing ruby $ruby_install_version instead of $ruby_version"

    # we cannot just replace the version number since the script is run
    # before this provisioning script is executed
    #sed -i -e 's/ruby_ver=.*/ruby_ver=1.9.3/g' postinstall.sh

    old_pwd=$PWD

    wget --quiet https://github.com/sstephenson/ruby-build/archive/v${ruby_build_version}.tar.gz -O /tmp/ruby-build-${ruby_build_version}.tar.gz \
    && cd /tmp \
    && tar xzvf ruby-build-${ruby_build_version}.tar.gz \
    && cd ruby-build-${ruby_build_version} \
    && bin/ruby-build "$ruby_install_version" "$ruby_home" \
    && cd $old_pwd \
    && rm -rf /tmp/ruby-build-${ruby_build_version}*

    # ruby is not on the path if we don't run this
    update-alternatives --install /usr/bin/ruby ruby /opt/vagrant_ruby/bin/ruby 100

    unset $old_pwd
else
    echo "--- Ruby is already up-to-date."
fi

unset ruby_home
unset ruby_version
unset ruby_install_version
unset ruby_build_version
