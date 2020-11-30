#!/bin/bash
puppet apply /vagrant/puppet_manifests/site.pp --modulepath=/vagrant/puppet_manifests/modules/ --verbose