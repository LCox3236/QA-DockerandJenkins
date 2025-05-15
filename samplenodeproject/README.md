# Simple Express App 

Express is a JavaScript middleware framework using NodeJs as a runtime environment. 
In order to run this app you need to install nodejs and npm on your linux machine using the APT manager.

Once they are installed you need to install the dependencies for the express app to run `npm install`
To run the app you need to use the command `node index.js` and it will create a web server accessible on port 5000 which will return "Hello World"

Typically NodeJS doesn't run as a background service so you will have to access via a browser, unless you were to install a node dependency to allow background services (NPM Forever)
