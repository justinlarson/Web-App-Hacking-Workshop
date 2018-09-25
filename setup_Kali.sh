#!/bin/bash
echo "[!] \n This won't work if you don't have git, docker, Chromium, and ruby installed. I didn't want to make it smart enough to check \n [!]"
apt-get --qq install python3-pip mysql -y
# git clone https://github.com/justinlarson/Web-App-Hacking-Workshop.git &
# git clone https://github.com/justinlarson/web-app-hacking-workshop-solutions.git &
# git clone https://github.com/sqlmapproject/sqlmap.git &
# git clone https://github.com/danielmiessler/SecLists.git &
# git clone https://github.com/nccgroup/autochrome.git &
# ruby autochrome/autochrome.rb
git clone https://github.com/sethlaw/vtm.git 
mysqld &
mysqladmin -u root create vtmdb
cd vtm
apt-get --qq install default-libmysqlclient-dev -y
pip3 install django django_extensions mysqlclient
python3 manage.py migrate
python3 manage.py loaddata taskManager/fixtures/*
python3 manage.py runserver & 
# docker run --detach --rm -it -p 80:80 cyrivs89/web-dvws &
# docker pull bkimminich/juice-shop
# docker run --detach --rm -p 3000:3000 bkimminich/juice-shop
