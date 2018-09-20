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
| WSDL Scanning, find as many users as possible | DVWS | http://localhost/dvws/vulnerabilities/wsdlenum/| intruder |
| XML External Entity Injection  | DVWS | http://localhost/dvws/vulnerabilities/xxe/ | intruder |
| XPATH Injection, become Admin  | DVWS | http://localhost/dvws/vulnerabilities/xpath/xpath.php | intruder |
###  Find WSDL File
The common format is htt://localhost.com/someservice?WSDL 
The Damn Vulnerable Web Service is not trying to be an actual application like VTM. It contains a list of vulnerabilities tied that are tied to endpoints. 

The WSDL we are looking for is on this http://localhost/dvws/vulnerabilities/wsdlenum/

![WSDL Enumeration](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/dvws-wsdl-enumeration.png)




| Challenge | Difficulty |
| ----- | ----- |
| DVWS | 
| WSDL Enumeration, find the WSDL file | :star: | 
| WSDL Scanning, find as many users as possible| :star: | 
| XML External Entity Injection | :star: | 
| XPATH Injection, become Admin | :star: | 
| Juice Shop |
| Retrieve the content of C:\Windows\system.ini or /etc/passwd from the server. | :star::star::star: |
| Give the server something to chew on for quite a while | :star::star::star::star::star: |
