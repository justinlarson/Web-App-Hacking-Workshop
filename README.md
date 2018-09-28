# Web-App-Hacking-Workshop
Web App Hacking Workshop for Saintcon/Cactuscon
# Setup
Download links are below this section
#### Steps
First look at the Easy Setups at the bottom if you are running MacOs or Kali Linux.
1. Download/Install Git
2. Download/Install Docker
3. Download/Install Firefox
	* Don't use Safari, Opera, Internet Explorer,Edge, or Chrome
4. Download Burp Suite 
	* Seriously, try and get a Burp Suite Pro Trial. You have to give them a work email and they will probably follow up or something but in our opinion it is the best tool for the job and will make the workshop better. 
5. Install Burp Extensions 
6. If using MacOS or Kali Linux and use the setup script in the `Easy Mac Setup or Easy Kali Setup` section at the bottom.df 
	* This clones all needed git repos, pulls docker images, installs autochrome and starts docker containers
	* requires Git, Brew, and Docker to be installed
7. Clone Repos if not using `setup.sh` script from step 6.
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
```
brew install docker
```
https://docs.docker.com/docker-for-windows/install/  
https://docs.docker.com/compose/install/  
Docker on Kali
	https://medium.com/@airman604/installing-docker-in-kali-linux-2017-1-fbaa4d1447fe
### Brew Install
```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```
## Browser

### Firefox 
https://www.wikihow.com/Enter-Proxy-Settings-in-Firefox
	
127.0.0.1:8080
## Proxy
### Burp
https://portswigger.net/burp/communitydownload
		
*Highly Recommended* to get the Pro Trial License 
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
	
## Easy MacOS Setup
Make sure Git, Docker, and Brew are already installed
``` 
git clone https://github.com/justinlarson/Web-App-Hacking-Workshop.git
cd Web-App-Hacking-Workshop
chmod 755 setup_Mac.sh
./setup_Mac.sh
```
* Juice shop will be running at `http://localhost:3000/#/search`
* DVWS will be running at `http://localhost/dvws/`
* VTM will be running at `http://localhost:8000`
* AltoroMutual is not running local but is at `http://demo.testfire.net`


## Easy Kali Setup
This will install docker, clone all the repos, and start all the apps. :fingers_crossed:
This didn't work in the Live CD version of Kali, for some reason it needed to be installed.
It worked with 40G of disk space and 6G of Memory
```
git clone https://github.com/justinlarson/Web-App-Hacking-Workshop.git
cd Web-App-Hacking-Workshop
chmod 755 setup_Kali.sh
*RUN as ROOT*
./setup_Kali.sh
```
