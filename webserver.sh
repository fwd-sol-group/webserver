#!/bin/bash

#set hostname
sudo hostnamectl set-hostname austin-web-01

#update packages
sudo apt update

#install nginx & git
sudo apt install nginx git -y

#enable and start nginx
systemctl enable nginx && systemctl start nginx

#make git directory if it doesnt exist
if [ ! -d /home/git ]; then
    mkdir /home/git
fi

#change to the git directory
cd /home/git

#clone git repo to local directory
git clone https://github.com/ozcrn/html-template.git

#copy .html file into root directory
cp /home/git/html-template/template.html /var/www/html/index.html


#For Public web server use IP=dig. For private use hostname -I 

#set hostname in index.html to hostname variable
sed -i s/HOSTNAME/$(hostname)/ /var/www/html/index.html

#set ipaddress in index.html to public ip address
sed -i s/IPADDRESS/$(dig +short myip.opendns.com @resolver1.opendns.com)/ /var/www/html/index.html

#set ipaddress in index.html to private ip address
#sed -i s/IPADDRESS/$(hostname -I | awk '{print $1}')/ /var/www/html/index.html



