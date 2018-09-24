# Web-App-Hacking-Workshop
Web App Hacking Workshop for Saintcon/Cactuscon
# Setup
Download links are below this section
#### Steps
1. Download/Install Git
2. Download/Install Docker
3. Download Browser
	* If you are on Windows just use Firefox
	* Autochrome is a tool that configures Chromium to work with Burp out of the box(if more familiar with Chrome then download Chromium) 
	* Don't use Safari, Opera, Internet Explorer, or Chrome
4. Download Burp Suite and Zap Proxies
	* Seriously, try and get a Burp Suite Pro Trial. You have to give them a work email and they will probably follow up or something but in our opinion it is the best tool for the job and will make the workshop better. 
5. Install Burp Extensions 
6. If using Mac/Linux and use setup.sh in the `Easy Mac Setup` section
	* This clones all needed git repos, pulls docker images, installs autochrome and starts docker containers
7. Clone Repos if not using `setup.sh` script from step 6.
	* Autochrome (if using Chromium)
	* SqlMap
	* Payload Lists
	* This Repo
	* Solution Repo
8. Configure Firefox
9. Install Burp Certificate
10. Run docker containers
11. Take a nap
12. You still here, great!
13. Now We Hack!!	
# Tools
### GIT
https://git-scm.com/downloads
### Docker/Environment access
https://docs.docker.com/docker-for-mac/install/  
https://docs.docker.com/docker-for-windows/install/  
https://docs.docker.com/compose/install/  

## Browsers	
### Chromium (only download if using autochrome)
https://download-chromium.appspot.com

### AutoChrome (Mac/Linux only)
https://github.com/nccgroup/autochrome
		
macOS 10.9 (Mavericks) and higher 
Ubuntu 16.04 (and other XDG-supporting Linuxes) 
You will need ruby version 2.0 or higher and unzip. These are included in supported macOS versions. You may need to apt install ruby on Linux.
		
		git clone git@github.com:nccgroup/autochrome.git
	        ruby autochrome/autochrome.rb
		Launch Chromium.
			* MacOS: open ~/Applications/Chromium.app
			* Linux: ~/.local/autochrome/chrome
### Firefox 
https://www.wikihow.com/Enter-Proxy-Settings-in-Firefox
	
127.0.0.1:8080
## Proxies
### ZAP
https://github.com/zaproxy/zaproxy/wiki/Downloads
### Burp
https://portswigger.net/burp/communitydownload
		
*Highly Recommended* Get the Pro Trial License 
https://portswigger.net/requestfreetrial/pro
		
### Burp Extensions
Open Burp go to Extender Tab > BApp Store  
* Wsdler
* Json Beautifier
* Logger++	

### Installing Burp Suite Certificate
https://support.portswigger.net/customer/portal/articles/1783087-installing-burp-s-ca-certificate-in-firefox

### SQLMap
```
git clone git@github.com:sqlmapproject/sqlmap.git
```
### Payload Lists
```
git clone git@github.com:danielmiessler/SecLists.git
```
### Hydra
```
MacOs: brew install hydra
```
```
git clone git@github.com:vanhauser-thc/thc-hydra.git
cd thc-hydra
./configure
make 
make install
```

# Applications 		
### Jucie Shop
https://github.com/bkimminich/juice-shop
	docker pull bkimminich/juice-shop
	docker run --rm -p 3000:3000 bkimminich/juice-shop
	Browse to http://localhost:3000 

### AltoroMutual
http://demo.testfire.net

### Vulnerable Task Mananger

https://github.com/sethlaw/vtm

### Damn Vulnerable Web Services 

https://github.com/snoopysecurity/dvws

https://github.com/Cyrivs89/docker-dvws . 
```
docker run --rm -it -p 80:80 cyrivs89/web-dvws
```
	
## Easy Mac Setup
Make sure Git, Docker, Chromium and Ruby are already installed
``` 
mkdir web-app-hacking-workshop
cd web-app-hacking-workshop
```
Download setup.sh to the web-app-hacking-workshop directory
```
chmod 755 setup.sh
./setup.sh
```
* Chromium should open configured for Burp
* Juice shop will be running at `http://localhost:3000/#/search`
* DVWS will be running at `http://localhost/dvws/`
* AltoroMutual is not running local but is at `http://demo.testfire.net`
