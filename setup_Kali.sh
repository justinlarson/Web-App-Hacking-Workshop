#!/bin/bash
echo "[!] \n This won't work if you don't have git, docker, Chromium, and ruby installed. I didn't want to make it smart enough to check \n [!]"
apt-get --qq install python3-pip mysql -y
git clone git@github.com:justinlarson/Web-App-Hacking-Workshop.git &
git clone git@github.com:justinlarson/web-app-hacking-workshop-solutions.git &
git clone git@github.com:sqlmapproject/sqlmap.git &
git clone git@github.com:danielmiessler/SecLists.git &
git clone git@github.com:nccgroup/autochrome.git &
git clone git@github.com:sethlaw/vtm.git 
mysqld &
mysqladmin -u root create vtmdb
cd vtm
pip3 install -r requirements.txt
python3 manage.py migrate
python3 manage.py loaddata taskManager/fixtures/*
python3 manage.py runserver & 
ruby autochrome/autochrome.rb
~/.local/autochrome/chrome &
docker run --detach --rm -it -p 80:80 cyrivs89/web-dvws &
docker pull bkimminich/juice-shop
docker run --detach --rm -p 3000:3000 bkimminich/juice-shop
