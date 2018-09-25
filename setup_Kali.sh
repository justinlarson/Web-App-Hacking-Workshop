#!/bin/bash
echo "[!] \n This won't work if you don't have git, docker, and ruby installed. I didn't want to make it smart enough to check \n [!]"
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
echo 'deb https://download.docker.com/linux/debian stretch stable' > /etc/apt/sources.list.d/docker.list
apt-get update
apt-get install docker-ce
apt-get install python3-pip mysql -y
git clone https://github.com/justinlarson/Web-App-Hacking-Workshop.git &
git clone https://github.com/justinlarson/web-app-hacking-workshop-solutions.git &
git clone https://github.com/sqlmapproject/sqlmap.git &
git clone https://github.com/danielmiessler/SecLists.git &
git clone https://github.com/nccgroup/autochrome.git 
ruby autochrome/autochrome.rb
git clone https://github.com/sethlaw/vtm.git 
/etc/init.d/mysql start
mysqladmin -u root create vtmdb
cd vtm
apt-get install default-libmysqlclient-dev -y
pip3 install django 
pip3 install django_extensions 
pip3 install mysqlclient
python3 manage.py migrate
python3 manage.py loaddata taskManager/fixtures/*
python3 manage.py runserver & 
docker run --detach --rm -it -p 80:80 cyrivs89/web-dvws &
docker pull bkimminich/juice-shop
docker run --detach --rm -p 3000:3000 bkimminich/juice-shop
