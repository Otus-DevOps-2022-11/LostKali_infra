#!/bin/bash

which git
if [ $? == 1 ]; then
    sudo apt-get -y install git
fi

git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install
puma -d
ps aux | grep puma
