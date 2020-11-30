#!/bin/bash

apt-get update -y
apt-get upgrade -y


# install puppet server
apt-get install puppet -y

/bin/bash /vagrant/puppet_apply.sh 