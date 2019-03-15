# Brute Force ( 10 minutes)
### Description
Ability to send hundreds or thousands of requests to an application without limit, with the intent to eventually gaining access to unauthorized resources

Monitor response variations to determine whether access is successful, including timing, error messages, status codes, HTTP headers.

Trying to determine full access details (username & password)

Similar to username enumeration attacks, can exist _anywhere_ the application responds to user-specific data.

### Tool
#### Burp Suite Pro - Intruder
http://portswigger.net - HTTP Intercepting Proxy for interacting with web apps.

![Burp Suite Pro](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/burpsuite.png)

## Walkthroughs

| Attack Type | Application | Location | Tool |
| ---- | ---- | ---- | ---- |
| Credential Brute Force | Vulnerable Task Manager | http://127.0.0.1:8000/taskManager/login/?next=/taskManager/  | intruder |
| Credential Brute Force | Vulnerable Task Manager | http://127.0.0.1:8000/taskManager/login/?next=/taskManager/  | hydra |


### Credential Brute Force

#### Step 1 - Identify Vulnerable Endpoint

Access the vulnerable task manager application using Burp Suite as the proxy, you should see the following page.

![vtm login](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/vtm-login.png)

If setup correctly, this request by the browser will correspond to a request in Burp Suite Pro's Proxy.

![vtm burp](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/bs-proxy-vtm.png)

Attempt to login with the known good username `chris` and invalid password `password`.
The error message `Login failed. Please try again` is displayed.

![vtm invalid password](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/vtm-invalid-password.png)

Now attempt to login as `chris` 10 more times to force account lockouts if they are applicable.
Then login using `chris` and `test123` to validate that the account has not been locked out.
The following Burp screenshot shows multiple failed login attempts followed by a successful authentication for `chris`.

![burp multi failed login](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/bs-proxy-multi-failed.png)

The login page accepts at least 10 password attempts and does not warn or logout a user. It is vulnerable to credential brute force attacks.

#### Step 2 - Configure Attack Parameters

Once again, find any request in Proxy that displays the error message `Login failed, Please try again`, right-click on this request, and send it to the Intruder

![bs request to intruder](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/bs-proxy-send-ue.png)

This sends the request to Intruder, so click over to the Intruder tab to configure the attack.
Navigate to the Positions tab and clear out the pre-configured targeted positions.

![bs intruder target](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/bs-intruder-ue-clear.png)

This Intruder attack will focus on two locations, username and password. Add two of the control characters to both the username and password field values by selecting these values and clicking the `Add` button.

![bs intruder positions](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/bs-intruder-position-brute.png)

Change the attack type to `Cluster Bomb` on the Positions tab, which gives us the flexibility to assign specific payloads to the different parameters.

![bs intruder cluster bomb](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/bs-intruder-position-clusterbomb.png)

Now switch to the Payloads tab and add the list of 4 known usernames (admin, chris, seth, ken) found during the user enumeration exercise to the 1st payload location we want to send to the server.

![bs intruder payloads](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/bs-intruder-payloads-users-brute.png)

Now switch the drop down to position 2 and add 'Passwords' from the `Add from list` drop down.

![bs intruder payloads](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/bs-intruder-payloads-passwords.png)

The attack is ready to run.

#### Step 3 - Attack and Analysis

Run the attack and see what happens.
Click the `Start attack` button.

![bs intruder start attack](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/bs-intruder-start-attack.png)

This attack sends over 13000 requests to the server and records all the responses for review.

![bs intruder attack](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/bs-intruder-attack-brute.png)

The initial page shows us the burp behavior. Once again, the challenge is going to be determining which requests result in valid responses containing the `Login failed` syntax instead of `Invalid Username`.
The key to determining this is found in the remembering the results of a successful authentication for `chris`.

![burp multi failed login](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/bs-proxy-multi-failed.png)

Normal behavior of a successful authentication returns a 302 redirect to the user when credentials are valid.
Once the attack is complete, resort the attack responses by status code to determine whether any valid credentials were identified.

![bs intruder ue valid](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/bs-intruder-attack-brute-results.png)

Congratulations! You have successfully brute forced chris' password.
Maybe you should try this again with a different password list that might be more successful.

### Credential Brute Force

#### Step 1 - Confirm Tool Access

So let's try to brute force the same endpoint, but using hydra, a different brute force tool.
Validate access by using the following hydra commands for a positive and negative check:

```
hydra -l chris -p test123 -s 8000 127.0.0.1 http-post-form "/taskManager/login/:username=^USER^&password=^PASS^:S=Location\: /task"

hydra -l chris -p invalid -s 8000 127.0.0.1 http-post-form "/taskManager/login/:username=^USER^&password=^PASS^:S=Location\: /task"
```

Since we are providing the user credentials for `chris`, this command is successful. 
Note that we are using `-l` and `-p` flags to specify a single username and password to try.
In addition, by specifying the `S` parameter, we are telling hydra that any response that includes the `Location: /task` is a successful attempt.
We will continue to use a set of valid credentials to insure our brute force is working.

![vtm login](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/hydra-access-test.png)

#### Step 2 - Configure Attack Parameters

Create a file with valid usernames in it from the user enumeration walkthroughs.
This same list is available in this github repository as _VTMUsernameList.txt_

```
admin
chris
seth
ken
dade
pm
```

Pick a password list that isn't too long but has a few more lists in it, like rockyou or the adobe 1000.
This repository includes a list of 1000 common passwords for testing _CommonPasswords.txt_.

#### Step 3 - Attack and Analysis

Run the following command, it does take a few minutes to complete:

```
hydra -L VTMUsernameList.txt -P CommonPasswords.txt -u -s 8000 127.0.0.1 http-post-form "/taskManager/login/:username=^USER^&password=^PASS^:S=Location\: /task"
```

If we were interested in only one user, we could speed up the attack by limiting the above list.

![bs intruder start attack](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/hydra-attack.png)

Congratulations! You have successfully brute forced chris' & seth's password using hydra.

## Challenges

| Challenges | Difficulty |
| ---- | ---- |
| Altoro Mutual | http://demo.testfire.net |
| Bruteforce Logins | :star::star: |
| Bonus: Security Misconfiguration | :star::star: |
| Bonus: Notice how it responds to a certain special characters | :star::star::star: |
