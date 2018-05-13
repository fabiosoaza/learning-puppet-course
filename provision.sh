#!/bin/bash

#disable fastestmirror plugin
sudo sed -i 's/enabled=1/enabled=0/' /etc/yum/pluginconf.d/fastestmirror.conf 

echo "export LC_ALL=en_US.UTF-8" >> ~/.bash_profile
echo "export LC_ALL=en_US.UTF-8" >> ~/.bash_profile
echo "export LANG=en_US.UTF-8" >> ~/.bash_profile
echo "export LANGUAGE=en_US.UTF-8" >> ~/.bash_profile
echo "export LC_COLLATE=C" >> ~/.bash_profile
echo "export LC_CTYPE=en_US.UTF-8" >> ~/.bash_profile

sudo yum update -y

sudo rpm -Uvh https://yum.puppet.com/puppet5/puppet5-release-el-7.noarch.rpm

yum install -y wget vim git ruby rubygems puppetserver 

sudo sed -i 's/Xms2g/Xms512m/' /etc/sysconfig/puppetserver 
sudo sed -i 's/Xmx2g/Xmx512m/' /etc/sysconfig/puppetserver

sudo systemctl restart puppetserver

sudo systemctl enable puppetserver

    
echo "[agent]" >> /etc/puppetlabs/puppet/puppet.conf
echo "server = master.puppet.vm" >> /etc/puppetlabs/puppet/puppet.conf


echo 'PATH="$PATH:/opt/puppetlabs/puppet/bin"' >> ~/.bash_profile
echo -e "export PATH\n"  >> ~/.bash_profile

source ~/.bash_profile

sudo gem install r10k

mkdir -p /etc/puppetlabs/r10k

puppet agent -t


echo -e "---\n" >> /etc/puppetlabs/r10k/r10k.yaml 
echo -e "cachedir: '/var/cache/r10k' " >> /etc/puppetlabs/r10k/r10k.yaml 
echo -e "sources:" >> /etc/puppetlabs/r10k/r10k.yaml 
echo -e "\tmy-org:" >> /etc/puppetlabs/r10k/r10k.yaml 
echo -e "\t\tremote: 'https://github.com/fabiosoaza/learning-puppet-course.git'" >> /etc/puppetlabs/r10k/r10k.yaml 
echo -e "\t\tbasedir: '/etc/puppetlabs/code/environments'" >> /etc/puppetlabs/r10k/r10k.yaml



r10k deploy environment -p

