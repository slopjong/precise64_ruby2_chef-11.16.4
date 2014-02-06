#!/bin/bash

# The VM name will contain something like 1413799374766_81483 but in
# action_set_name the number will be rounded to 1413799375. In the
# following lines we will retrieve the actual VM name.
name=$(cat .vagrant/machines/default/virtualbox/action_set_name)
name=${name%?} # remove last character
name=$(vboxmanage list vms | egrep -o "[^\"]+_default_$name[^\"]+")

vagrant package --base $name --output precise64.box
