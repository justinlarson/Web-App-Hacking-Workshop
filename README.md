# Web-App-Hacking-Workshop
Web App Hacking Workshop for Saintcon/Cactuscon



# Setup
## Tools
## Cli tools needed
	git , brew 
### ZAP
		https://github.com/zaproxy/zaproxy/wiki/Downloads
### Burp
		https://portswigger.net/burp/communitydownload

### Auto Chrome
		https://github.com/nccgroup/autochrome
		
		macOS 10.9 (Mavericks) and higher
		Ubuntu 16.04 (and other XDG-supporting Linuxes)
		You will need ruby version 2.0 or higher and unzip. These are included in supported macOS versions. You may need to apt install ruby on Linux.
		
		ruby --version
		git clone git@github.com:nccgroup/autochrome.git
		
		1. ruby autochrome.rb
		2. Launch Chromium.
		3. MacOS: open ~/Applications/Chromium.app
### Firefox
	https://www.wikihow.com/Enter-Proxy-Settings-in-Firefox
	
	127.0.0.1:8080
	
### Installing Burp Suite Certificate
	https://support.portswigger.net/customer/portal/articles/1783087-installing-burp-s-ca-certificate-in-firefox
### SQLMap
	git clone git@github.com:sqlmapproject/sqlmap.git
### Developers Tools
### Docker/Environment access
		https://docs.docker.com/docker-for-mac/install/
		https://docs.docker.com/docker-for-windows/install/
		https://docs.docker.com/compose/install/
		
### Payload Lists
		https://github.com/danielmiessler/SecLists
		
		git clone git@github.com:danielmiessler/SecLists.git
## Applications 		
### Jucie Shop
	https://github.com/bkimminich/juice-shop
	
	1. Install Docker
	2. Run docker pull bkimminich/juice-shop
	3. Run docker run --rm -p 3000:3000 bkimminich/juice-shop
	4. Browse to http://localhost:3000 (on macOS and Windows browse to http://192.168.99.100:3000 if you are using docker-machine instead of the native docker installation)

	
### WebGoat 
	https://github.com/WebGoat/WebGoat
	Using docker-compose
	The easiest way to start WebGoat as a Docker container is to use the docker-compose.yml file from our Github 	repository. This will start both containers and it also takes care of setting up the connection between WebGoat and WebWolf.

	curl https://raw.githubusercontent.com/WebGoat/WebGoat/develop/docker-compose.yml | docker-compose -f - up


### My Shitty graphql, need to get that done FML

