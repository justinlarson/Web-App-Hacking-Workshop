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
		
		~Recommended~ Pro Trial License
		https://portswigger.net/requestfreetrial/pro
		
### Burp Extensions
Open Burp go to Extender Tab > BApp Store 
Wsdler
Json Beautifier
Logger++
		
### Chromium (only download if using autochrome)
download https://download-chromium.appspot.com

### AutoChrome (Mac/Linux only)
https://github.com/nccgroup/autochrome
		
macOS 10.9 (Mavericks) and higher 
Ubuntu 16.04 (and other XDG-supporting Linuxes) 
You will need ruby version 2.0 or higher and unzip. These are included in supported macOS versions. You may need to apt install ruby on Linux.
		
git clone git@github.com:nccgroup/autochrome.git
		
		1. ruby autochrome.rb
		2. Launch Chromium.
			* MacOS: open ~/Applications/Chromium.app
			* Linux: ~/.local/autochrome/chrome
		3. Open the "Getting Started" bookmark.
### Firefox 
https://www.wikihow.com/Enter-Proxy-Settings-in-Firefox
	
127.0.0.1:8080
	
### Installing Burp Suite Certificate
https://support.portswigger.net/customer/portal/articles/1783087-installing-burp-s-ca-certificate-in-firefox
### SQLMap
git clone git@github.com:sqlmapproject/sqlmap.git
### Developers Tools
 right click *Inspect*
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

### AltoroMutual
http://demo.testfire.net

### Vulnerable Task Mananger

https://github.com/sethlaw/vtm

### Damn Vulnerable Web Services 

https://github.com/snoopysecurity/dvws

https://github.com/Cyrivs89/docker-dvws
docker run --rm -it -p 80:80 cyrivs89/web-dvws
	
### Easy Mac Setup
Make sure Git, Docker, Chromium and Ruby are already installed
``` 
mkdir web-app-hacking-workshop
cd web-app-hacking-workhop
```
Download setup.sh to newly created directory
```
chmod 755 setup.sh
./setup.sh
```
* Chromium should open configured for Burp
* Juice shop will be running at `http://localhost:3000/#/search`
* DVWS will be running at `http://localhost/dvws/`

