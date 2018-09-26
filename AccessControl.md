# Access Control
### Description
Ability to access functionality and resources by manipulating a user request.
One of the most common and easily-exploited flaws.

AKA Improper Authorization, Insecure Direct Object Reference, Missing Function Level Access Control ... 

### Tool
#### Burp Suite Pro - Intruder
http://portswigger.net - HTTP Intercepting Proxy for interacting with web apps.

![Burp Suite Pro](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/burpsuite.png)

## Walkthroughs

| Attack Type | Application | Location | Tool |
| ---- | ---- | ---- | ---- |
| Access Control - Directory Enumeration | Vulnerable Task Manager | http://127.0.0.1:8000/ | intruder |
| Insecure Direct Object Reference | Vulnerable Task Manager | http://127.0.0.1:8000/taskManager/profile/3 | intruder |

### Access Control - Directory Enumeration

#### Step 1 - Identify URL

Access the vulnerable task manager application using Burp Suite as the proxy, you should see the following page.

![vtm login](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/vtm-login.png)

If setup correctly, this request by the browser will correspond to a request in Burp Suite Pro's Proxy.

![vtm burp](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/bs-proxy-vtm.png)

#### Step 2 - Configure Intruder

Burp provides an easy way to send a request to other tabs, right-click on the initial request to vtm and send it to the Intruder

![bs request to intruder](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/bs-proxy-send-to-intruder.png)

This sends the request to intruder, but you will still need to click over to the Intruder tab to configure the attack.

![bs intruder target](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/bs-intruder-target.png)

The initial target is already set to the server hosting vtm, so let's configure the location we want to target.
Since we want to enumerate directories, add two of the control characters to the end of the specified path as shown.

![bs intruder position](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/bs-intruder-position.png)

Next add the short list of directories to the payloads we want to send to the server.
This is done by clicking the Payloads tab and then selecting `Directories - short` from the dropdown under Payload Options. 

![bs intruder payloads](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/bs-intruder-payloads.png)

#### Step 3 - Attack and Analyze Results

That is all we need to do to configure a simple attack, so let's run it and see what the responses look like.
Click the `Start attack` button.

![bs intruder start attack](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/bs-intruder-start-attack.png)

This attack sends 362 requests to the server and records the responses for review.

![bs intruder attack](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/bs-intruder-attack.png)

On this page alone, we see some interesting results, noticably that the initial request results in a HTTP Status 302 redirect.
All of the other 404 status codes indicate that the directories don't exist, but there is one other redirect status code in the list.

![bs intruder admin](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/bs-intruder-attack-admin.png)

The `admin` payload also results in a redirect. Double click on the request to see more details.

![bs intruder admin response](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/bs-intruder-attack-admin-response.png)

The `/admin/` directory exists and looks to be accessible.

#### Step 4 - Confirm Finding

Accessing the URL `http://127.0.0.1/admin/` in a browser shows the login screen for the Django Administrator Portal.

![vtm django admin](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/vtm-admin.png)

Congratulations! You have successfully identified a Broken Access Control issue using Burp's Intruder functionality. 

### Insecure Direct Object Reference (IDOR)

#### Step 1 - Identify URL where IDOR may exist

Using a browser configured to use Burp Suite as a proxy, login to vtm as `chris` using the password `test123`.
Browse to the Profile page as shown.

![vtm profile](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/vtm-profile.png)

Pay attention to the URL used to access this page, note the use of an integer identifier (3) in association with chris' account.

#### Step 2 - Send Request to Intruder

Access Burp Suite Pro's Proxy History and search for the request to `/taskManager/profile/3`, send this GET request to Intruder by right-clicking and selecting `Send to Intruder`.

![burp sent to intruder](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/bs-proxy-intruder-idor-send-to-intruder.png)

Switch to the Intruder tab and verify that the last request in the list is targeting the Vulnerable Task Manager.

![burp intruder target](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/bs-intruder-target-2.png)

#### Step 3 - Configure the Attack

Now setup the position of the attack by first clearing out the auto-identified positions.

![burp intruder clear](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/bs-intruder-clear.png)

Next select the integer identified in the first step and adding Intruder's control characters around it.

![burp intruder idor position](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/bs-intruder-position-idor.png)

Switch to the `Payload` tab and switch from Payload type of `Simple List` to `Numbers`

![burp intruder payload numbers](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/bs-intruder-payloads-numbers.png)

Setup the numbers attack to send attack payloads from 1 to 100. Make sure to fill out the form fields as shown.

![burp intruder payload numbers](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/bs-intruder-payloads-numbers-100.png)

#### Step 4 - Attack & Analyze

Start the attack.

![bs intruder start attack](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/bs-intruder-start-attack.png)

Review the list of results, notice the different in status codes between different numbers.

![bs intruder attack idor](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/bs-intruder-attack-idor.png)

Select the attack with the payload `1`. This identifier corresponds with the `admin` user, as seen by rendering the attack response.

![bs intruder attack idor](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/bs-intruder-attack-idor.png)

Congratulations! You have successfully executed an Insecure Direct Object Reference exploit against the Vulnerable Task Manager.

## Walkthroughs

| Challenge	| Difficulty |
| ----- | ----- |
| Altoro Mutual | http://demo.testfire.net |
| Access the admin page with jsmith user (jsmith:demo1234) | :star::star: |
| View another accounts history | :star::star: |
| Juice Shop  | http://localhost:3000 |
| Access the administration section of the store.(hint:look to the source) |	:star::star: |
| Access someone else's basket. |	:star::star: | 
| Get rid of all 5-star customer feedback. | 	:star::star:
| Post some feedback in another users name. | 	:star::star::star:|


