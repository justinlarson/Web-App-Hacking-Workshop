# Security Misconfiguration
### Description
### Tool
#### Burp Suite Pro - Intruder
http://portswigger.net - HTTP Intercepting Proxy for interacting with web apps.

![Burp Suite Pro](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/burpsuite.png)

## Walkthroughs

| Attack Type | Application | Location | Tool |
| ---- | ---- | ---- | ---- |
| WSDL Enumeraton, find WSDL file | DVWS | http://localhost/dvws/vulnerabilities/wsdlenum/ |  intruder/WSDLER |
| XML External Entity Injection  | DVWS | http://localhost/dvws/vulnerabilities/xxe/ | intruder |
###  WSDL Enumeraton
The common format is http://localhost.com/someservice?wsdl

The Damn Vulnerable Web Service is not trying to be an actual application like VTM. It contains a list of vulnerable endpoints. 


| Challenge	 | Difficulty| 
| ---- | ---- |
|Provoke an error that is not very gracefully handled.|	:star:|
|What tech is each application using? | :star: |



