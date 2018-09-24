# Insecure Webservices
### Description
Webservices are typically vulnerable to the same issues such as IDOR, SQLi or Enumerations. 
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
###  WSDL Enumeraton
The common format is http://localhost.com/someservice?wsdl

The Damn Vulnerable Web Service is not trying to be an actual application like VTM. It contains a list of vulnerable endpoints. 

The WSDL is located at this endpoint.  
http://localhost/dvws/vulnerabilities/wsdlenum/

![WSDL Enumeration](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/dvws-wsdl-enumeration.png)
!! Make sure WSDLER Extension is installed !!
1. Intercept first GET request to the endpoint above and send it intruder. 
2. Clear all targeted attack positions.
3. Add the target position to the url and also add _?wsdl_ after the position.
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
8. Select request and `Parse WSDL` with WSDLER
![Parse WSDL](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/dvws-parse-wsdl.png)
WSDLER reveals the private services of the wsdl. 
![Parsed WSDL](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/dvws-parsed-wsdl.png)
OR in the case of DVWS simply searching the source with developer tools will reveal the wsdl endpoint. 
![Inspect Source](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/dvws-inspect-source.png)
 
### XML External Entity Injection
1. Go to the XML External Entity Processing link in DVWS
![XXE](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/dvws-xml-injection.png)
2. Add payload to input box and submit
```
<!DOCTYPE foo [<!ENTITY xee1 "Baby shark, doo doo doo, doo doo doo doo doo. "><!ENTITY xee2 "&xee1;&xee1;"><!ENTITY xee3 "&xee2;&xee2;"><!ENTITY xee4 "&xee3;&xee3;">]><name>&xee4;</name>
```
![XXE Baby Shark](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/dvws-xml-baby-shark-doo-doo.png)

| Challenge | Difficulty |
| ----- | ----- |
| DVWS | http://localhost/dvws/ |
| WSDL Scanning, find as many users as possible| :star: | 
| XPATH Injection, become Admin | :star: | 
| XXE 2 how about some /etc/passwd | :star::star: |
