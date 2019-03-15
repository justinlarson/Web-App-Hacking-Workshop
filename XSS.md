# Cross-Site Scripting (XSS) ( 15 Minutes)
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
| Stored XSS | Vulnerable Task Manager | http://127.0.0.1:8000/taskManager/7/13/ | title |
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

### Stored XSS
#### Step 1 - Identify stored input

Access the vulnerable task manager application using Burp Suite as the proxy, you should see the following page.

![vtm login](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/vtm-login.png)

Login to the Vulnerable Task Manager as `chris` using the password `test123`.

![vtm dashboard](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/vtm-chris-dashboard.png)

Access a list of project and task details by clicking on the `Marketing Campaign` project.
Click on the `Edit` button to edit the details of the `Advertising` task.

![vtm project details task](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/vtm-project-details-task.png)

Edit the details of the task title to `Updated Advertising` to validate that the application accepts user changes to the task.

![vtm task edit](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/vtm-task-edit.png)

The changes are reflected in the task details page.

![vtm task details](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/vtm-task-details.png)

#### Step 2 - Identify Flawed Input Validation and Output Encoding

Since vtm displays the stored task input, attempt to add special characters to the task title to determine what characters are displayed without validation or encoding.
Enter `Advertising<>"';&` into the task title field and click `Finish`

![vtm task edit chars](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/vtm-task-edit-chars.png)

This does not change the look or feel of the task details page, so look at the source code of the page within the developer tools.

![vtm task source](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/vtm-task-details-source.png)

As shown, the browser knows that this source is malformed and highlights it, but note that the extra dangerous characters included in our task title (`<>"';&`) are returned without validation or encoding.

#### Step 3 - Execute XSS attack

Now we know that dangerous characters are available for use, execute an XSS attack by editing the task again and entering the following into the task title box.

```
Advertising"><script>alert("XSS")</script>
```
![vtm search xss](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/vtm-task-edit-xss.png)

Clicking `Finish` returns the task details page but with an executed JavaScript popup, stopping execution on the page and validating the existence of an XSS vulnerability.

![vtm search popup](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/vtm-task-details-popup.png)

Congratulations! You have successfully exploited a Stored XSS vulnerability in the Vulnerable Task Manager.

### DOM-based XSS
#### Step 1 - Identify possible DOM input/output

Access the vulnerable task manager application using Burp Suite as the proxy, you should see the following page.

![vtm login](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/vtm-login.png)

View the source of the login page, look for JavaScript functions that access user-controllable elements such as `window.location` and `location.hash`.
In addition, search for use of `document.write` and `document.writeln` that directly manipulate the DOM.

![vtm login source](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/vtm-login-source.png)

A closer look at this unnecessary JavaScript left by developers on the login page shows interesting possibilities.

```

           try {
               var hashParam = location.hash.split("#")[1];
               var paramName = hashParam.split('=')[0];
               var paramValue = decodeURIComponent(hashParam.split('=')[1]);
               document.write("<OPTION value=3>" +  paramValue  + "</OPTION>");
           } catch(err) {
           }
          
```

Specifically, the value of the `location.hash` is split between `name` and `value` using the equals sign.
The identified paramValue is written back out to the page using `document.write`.

Validate this functionality by appending `#test=myValue` to the end of the login URL.
Press Enter while in the URL bar and reload the page.

![vtm task edit](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/vtm-login-hash.png)

The changes we appended to the URL have been written to the page by the browser.

#### Step 2 - Identify Flawed Input Validation and Output Encoding

Since vtm instructs the browser to append the value of this hash parameter to the HTML, attempt to add special characters to the task title to determine what characters are displayed without validation or encoding.
Enter `#test=myValue<>"';&` onto the URL and press Enter and reload the page.

![vtm task edit chars](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/vtm-login-hash-chars.png)

This does not change the look or feel of the login page, but the developer tools show that the extra dangerous characters included in our task title (`<>"';&`) are returned without validation or encoding.

#### Step 3 - Execute XSS attack

Now we know that dangerous characters are available for use, execute an XSS attack by editing the task again and entering the following into the task title box.

```
#test=myValue</option><script>alert("XSS")</script>
```
![vtm search xss](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/vtm-login-hash-xss.png)

Hitting Enter and reloading the page returns the login page but with an executed JavaScript popup, stopping execution on the page and validating the existence of an XSS vulnerability.

![vtm search popup](https://github.com/justinlarson/Web-App-Hacking-Workshop/raw/master/img/vtm-login-hash-popup.png)

Congratulations! You have successfully exploited a DOM-based XSS vulnerability in the Vulnerable Task Manager.

## Challenges

| Challenge	| Difficulty| 
| ---- | ---- |
| Altoro Mutual | http://demo.testfire.net|
| Reflective Xss | :star: |


