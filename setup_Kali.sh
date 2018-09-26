#!/bin/bash
echo "[!] \n This won't work if you don't have git, docker, and ruby installed. I didn't want to make it smart enough to check \n [!]"
#install pip3, makes assumption that python3 installed

apt-get install python3-pip -y
apt-get install default-libmysqlclient-dev -y 
pip3 install django 
pip3 install django_extensions 
pip3 install mysqlclient

#adds docker repo to sources and installs docker
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
echo 'deb https://download.docker.com/linux/debian stretch stable' > /etc/apt/sources.list.d/docker.list
apt-get update -y
apt-get install docker-ce -y

# Clone all the repos for 
git clone https://github.com/justinlarson/web-app-hacking-workshop-solutions.git &
#git clone https://github.com/sqlmapproject/sqlmap.git &
git clone https://github.com/danielmiessler/SecLists.git &
#git clone https://github.com/nccgroup/autochrome.git 

# Installing autochrome
#ruby autochrome/autochrome.rb

# VTM application 
## clone repo
git clone https://github.com/sethlaw/vtm.git 

## start mysql
/etc/init.d/mysql start
##create database
mysqladmin -u root create vtmdb
python3 vtm/manage.py migrate
python3 vtm/manage.py loaddata taskManager/fixtures/*
python3 vtm/manage.py runserver & 
###pull and run docker images
docker run --detach --rm -it -p 80:80 cyrivs89/web-dvws &
docker pull bkimminich/juice-shop
docker run --detach --rm -p 3000:3000 bkimminich/juice-shop
