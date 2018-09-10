# Web-App-Hacking-Workshop
Web App Hacking Workshop for Saintcon/Cactuscon



# Setup
## Tools
### ZAP
		https://github.com/zaproxy/zaproxy/wiki/Downloads
### Burp
		https://portswigger.net/burp/communitydownload
### Firefox
### Auto Chrome
		https://github.com/nccgroup/autochrome
### Developers Tools
### Docker/Environment access
		https://docs.docker.com/docker-for-mac/install/
		https://docs.docker.com/docker-for-windows/install/
		https://docs.docker.com/compose/install/
		
### Payload Lists
		https://github.com/danielmiessler/SecLists
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

