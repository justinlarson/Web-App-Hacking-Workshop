#!/bin/bash
echo "[!] \n This won't work if you don't have git, docker and ruby installed, I didn't want to make it smart enough to check \n [!]"
git clone git@github.com:sqlmapproject/sqlmap.git &
git clone git@github.com:danielmiessler/SecLists.git &
git clone git@github.com:nccgroup/autochrome.git &
ruby autochrome/autochrome.rb
open ~/Applications/Chromium.app &
docker run --detach --rm -it -p 80:80 cyrivs89/web-dvws &
docker pull bkimminich/juice-shop
docker run --detach --rm -p 3000:3000 bkimminich/juice-shop
