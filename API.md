# Insecure Webservices
### Description
Webservices are typically vulnerable to the same issues such as IDOR, SQLi or Enumerations. They do however require different approaches in order to exploit. 
### Tool
#### Burp Suite Pro - Intruder
http://portswigger.net - HTTP Intercepting Proxy for interacting with web apps.

![Burp Suite Pro](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/burpsuite.png)

#### WSDLER
Burp Extension
https://portswigger.net/bappstore/594a49bb233748f2bc80a9eb18a2e08f

## Walkthroughs

| Attack Type | Application | Location | Tool |
| ---- | ---- | ---- | ---- |
| WSDL Enumeraton, find WSDL file | DVWS | http://localhost/dvws/vulnerabilities/wsdlenum/ |  intruder/WSDLER |
| XML External Entity Injection  | DVWS | http://localhost/dvws/vulnerabilities/xxe/ | intruder |
| XPATH Injection, become Admin  | DVWS | http://localhost/dvws/vulnerabilities/xpath/xpath.php | intruder |
###  Find WSDL File
The common format is htt://localhost.com/someservice?wsdl
The Damn Vulnerable Web Service is not trying to be an actual application like VTM. It contains a list of vulnerabilities tied that are tied to endpoints. 

The WSDL is located at this endpoint.  
http://localhost/dvws/vulnerabilities/wsdlenum/

![WSDL Enumeration](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/dvws-wsdl-enumeration.png)
!! Make sure WSDLER Extension is installed !!
1. Intercept first GET request to the endpoint above and send it intruder. 
2. Clear all targeted attack positions.
3. Add the target position to the end of the url and also add _?wsdl_ to the end.
![New Intruder Position](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/dvws-new-intruder-position.png)
4. Add payloads from Seclists repo.   
`/web-app-hacking/SecLists/Discovery/raft-small-files.txt`
![Add payloads](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/dvws-load-list.png)
5. Add Grep option to make discovery easier. 
* Grep for `<?xml version=`
* Go to `Options` > `Grep - Match`
* Select Flag results in responses
* Clear box
* Add `<?xml version=`
![Grep Option](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/dvws-grep-xml.png)
6. Start Attack
7. Sort Results by the Grep Column for `<?xml version=`
![WSDL Found](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/dvws-wsdl-found.png)
8. Parse WSDL with WSDLER
![Parse WSDL](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/dvws-parse-wsdl.png)
WSDLER reveals private services of the wsdl. 
![Parsed WSDL](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/dvws-parsed-wsdl.png)
OR in the case of DVWS simply searching the source with developer tools will reveal the wsdl endpoint. 
![Inspect Source](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/dvws-inspect-source.png)


| Challenge | Difficulty |
| ----- | ----- |
| DVWS | 
| WSDL Scanning, find as many users as possible| :star: | 
| XML External Entity Injection | :star: | 
| XPATH Injection, become Admin | :star: | 
| XXE 2 how about some /etc/passwd | :star::star: |
