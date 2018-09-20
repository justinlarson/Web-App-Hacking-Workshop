# Cross-Site Scripting (XSS)
### Description
Ability to inject and execute arbitrary HTML within a user’s browser.

```<div class=”h1”>Search results for {{ query }} </div>```

* Violates the trust a user has with the application
* Allows complete control of the browser by an attacker
* Three flavors: Stored, Reflected, DOM-based

### Tool
#### Browser - Chrome or Firefox
Enable developer tools to view HTML injection manipulation.

![Firefox Developer Tools](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/ff-dev-tools.png)

## Walkthroughs

| Attack Type | Application | Location | Parameter |
| ---- | ---- | ---- | ---- |
| Reflected XSS | Vulnerable Task Manager | http://127.0.0.1:8000/taskManager/search/?q=test  | q |
| Stored XSS | Vulnerable Task Manager | http://127.0.0.1:8000/taskManager/7/24/ | title |
| DOM-based XSS | Vulnerable Task Manager | http://127.0.0.1:8000/taskManager/login/?next=/ | # |


## Walkthroughs

### Reflected XSS
#### Step 1 - Identify reflected input

Access the vulnerable task manager application using Burp Suite as the proxy, you should see the following page.

![vtm login](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/vtm-login.png)

Login to the Vulnerable Task Manager as `chris` using the password `test123`.

![vtm dashboard](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/vtm-chris-dashboard.png)

Search for current projects for `punk` using the search box to see if user input is returned.

![vtm dashboard search](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/vtm-dashboard-search.png)

This displays the search page and successfully shows relevant projects, but also reflects our search term in the embedded text field.

![vtm search](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/vtm-search.png)

#### Step 2 - Identify Flawed Input Validation and Output Encoding

Since vtm displays our input, attempt to add special characters to the search phrase to determine what characters are displayed without validation or encoding.
Enter `punk<>"';&` into the search field and click `Go!`

![vtm search chars](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/vtm-search-chars.png)

This does not change the look or feel of the current page, so look at the source code of the page within the developer tools.

![vtm search source](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/vtm-search-source.png)

As shown, the browser knows that this source is malformed and highlights it, but note that the extra dangerous characters included in our search phrase (`<>"';&`) are returned without validation or encoding.

#### Step 3 - Execute XSS attack

Now we know that dangerous characters are available for use, execute an XSS attack by entering the following into the search box.

```
punk"><script>alert("XSS")</script>
```
![vtm search xss](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/vtm-search-xss.png)

Clicking `Go!` returns the search page but with an executed JavaScript popup, stopping execution on the page and validating the existence of an XSS vulnerability.

![vtm search popup](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/vtm-search-popup.png)

Congratulations! You have successfully exploited a Reflected XSS vulnerability in the Vulnerable Task Manager. 


## Challenges

| Challenge	| Difficulty| 
| ---- | ---- |
| Juice Shop | |
| Perform a reflected XSS attack with <script>alert("XSS")</script>.|	:star:|
| Perform a DOM XSS attack with <script>alert("XSS")</script>.	|:star:|
| Perform a persisted XSS attack with <script>alert("XSS")</script> bypassing a client-side security mechanism.	|:star::star::star:|
| Perform a persisted XSS attack with <script>alert("XSS")</script> without using the frontend application at all.	|:star::star::star:|
| Perform a persisted XSS attack with <script>alert("XSS")</script> bypassing a server-side security mechanism.	 | :star::star::star::star:|
| Altoro Mutual | |
| Reflective Xss | :star: |
