# Username Enumeration ( 10 Minutes)
### Description
Ability to enumerate user information through differences in responses when providing valid and invalid information.
* Usually involves disclosure of username, email addresses, phone numbers, etc., AKA 1/2 of the data required for authentication.
* Response variations included error message, query string parameters, spacing, timing, etc.
* Exists _anywhere_ the application responds to user-specic data, including login, account recovery, registrations, etc.

### Tool
#### Burp Suite Pro - Intruder
http://portswigger.net - HTTP Intercepting Proxy for interacting with web apps.

![Burp Suite Pro](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/burpsuite.png)

## Walkthroughs

| Attack Type | Application | Location | Tool |
| ---- | ---- | ---- | ---- |
| Username Enumeration | Vulnerable Task Manager | http://127.0.0.1:8000/taskManager/login/?next=/taskManager/  | intruder |

#### Step 1 - Identify Vulnerable Endpoint

Access the vulnerable task manager application using Burp Suite as the proxy, you should see the following page.

![vtm login](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/vtm-login.png)

If setup correctly, this request by the browser will correspond to a request in Burp Suite Pro's Proxy.

![vtm burp](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/bs-proxy-vtm.png)

Attempt to login with the known good username `chris` and invalid password `password`.
The error message `Login failed. Please try again` is displayed.

![vtm invalid password](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/vtm-invalid-password.png)

Now attempt to login with the invalid username `testtest` and invalid password `password`.
A different error message `Invalid Username. Please try again` is shown.

![vtm invalid password](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/vtm-invalid-username.png)

#### Step 2 - Configure Intruder

Find the request in Proxy that displays the error message `Login failed, Please try again`, right-click on this request, and send it to the Intruder

![bs request to intruder](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/bs-proxy-send-ue.png)

This sends the request to Intruder, so click over to the Intruder tab to configure the attack.
Navigate to the Positions tab and clear out the pre-configured targetted positions.

![bs intruder target](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/bs-intruder-ue-clear.png)

The only location we are concerned about right now is, add two of the control characters to the end of the specified path by highlighting `chris` in the username field and clicking the button to add Burp control characters.

![bs intruder target](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/bs-intruder-ue-position.png)

Next add a list of common usernames to the payloads we want to send to the server.
This is done by clicking the Payloads tab and then selecting `Usernames` from the dropdown under Payload Options. 

![bs intruder payloads](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/bs-intruder-payloads-usernames.png)

#### Step 3 - Attack and Analyze Results

That is all we need to do to configure a simple attack, so let's run it and see what the responses look like.
Click the `Start attack` button.

![bs intruder start attack](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/bs-intruder-start-attack.png)

This action sends over 8000 requests to the server and records the responses for review.

![bs intruder attack](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/bs-intruder-attack-ue.png)

On this page alone, we see some interesting results. The challenge is going to be determining which requests result in valid responses containing the `Login failed` syntax instead of `Invalid Username`.
The key to determining this is found in the first 2 results on the attack screen.
Even though the status code is the same (200), the length of the 2 responses varies by 4 bytes, the difference between the response error strings.

![bs intruder ue analyze](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/bs-intruder-attack-ue-analyze.png)

Sorting by response `Length` shows us 5 valid usernames discovered during the attack.

![bs intruder ue valid](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/bs-intruder-attack-ue-valid.png)


Congratulations! You have successfully enumerated valid usernames using Burp's Intruder functionality. 

## Challenges
| Challenge	| Difficulty |
| ----- | ----- |
| Altoro Mutual | http://demo.testfire.net |
| Login Hint: Use CommonUsernameList.txt | :star:|
| Juice Shop | http://localhost:3000 | 
| User Registration | :star::star::star: |
| Forgot Password | :star: :star: :star::star: |

