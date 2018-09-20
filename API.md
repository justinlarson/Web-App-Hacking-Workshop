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
| WSDL Enumeraton | DVWS | http://localhost/dvws/vulnerabilities/wsdlenum/ |  intruder/WSDLER |
| WSDL Scanning, find as many users as possible | DVWS | http://localhost/dvws/vulnerabilities/wsdlenum/| intruder |
| XML External Entity Injection  | DVWS | http://localhost/dvws/vulnerabilities/xxe/ | intruder |
| XPATH Injection, become Admin  | DVWS | http://localhost/dvws/vulnerabilities/xpath/xpath.php | intruder |
### Access Control - Directory Enumeration





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
