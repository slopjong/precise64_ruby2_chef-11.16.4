#!/bin/bash

if [ -z "$(grep lu.archive /etc/apt/sources.list)" ]
then
    sudo sed -ie 's/us.archive/lu.archive/g' /etc/apt/sources.list
    sudo aptitude update
    echo "Repository updated."
else
    echo "Apt repository already up-to-date."
fi