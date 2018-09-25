#!/bin/bash
echo "[!] \n This won't work if you don't have git, brew, docker, Chromium, and ruby installed. I didn't want to make it smart enough to check \n [!]"
git clone git@github.com:justinlarson/Web-App-Hacking-Workshop.git &
git clone git@github.com:justinlarson/web-app-hacking-workshop-solutions.git &
brew install hydra &
git clone git@github.com:sqlmapproject/sqlmap.git &
git clone git@github.com:danielmiessler/SecLists.git &
git clone git@github.com:nccgroup/autochrome.git &
ruby autochrome/autochrome.rb
open ~/Applications/Chromium.app &
docker run --detach --rm -it -p 80:80 cyrivs89/web-dvws &
docker pull bkimminich/juice-shop
docker run --detach --rm -p 3000:3000 bkimminich/juice-shop
