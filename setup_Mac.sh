#!/bin/bash
echo "[!] \n This won't work if you don't have brew I didn't want to make it smart enough to check \n [!]"
#brew cask install burp-suite &
brew install git
git clone https://github.com/justinlarson/web-app-hacking-workshop-solutions.git &
brew install hydra 
git clone https://github.com/sqlmapproject/sqlmap.git &
git clone https://github.com/danielmiessler/SecLists.git &
#git clone https://github.com/sethlaw/vtm.git 
#brew services start mysql
#mysqladmin -u root create vtmdb
#pip3.7 install -r vtm/requirements.txt
#python3 vtm/manage.py migrate
#python3 vtm/manage.py loaddata taskManager/fixtures/*
#python3 vtm/manage.py runserver & 
#docker run --detach --rm -it -p 80:80 cyrivs89/web-dvws &
docker pull bkimminich/juice-shop
docker run --detach --rm -p 3000:3000 bkimminich/juice-shop
