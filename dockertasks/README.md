# DockerfileExercise

## Task 1 
This is a basic Flask application that serves a simple static website that returns the machine's hostname.

It is directly accessible on port 5500.

Set the environment variable YOUR_NAME to your name to have the app display your name in its welcome message. Otherwise, it will refer to you as "friend".

The nginx.conf file can be used to configure an NGINX container to run as a reverse proxy to the Flask app container, effectively making the Flask application accessible on port 80. You will need to know how to configure networks in Docker in order to achieve this.

## Task 2
Two tier application with a mysql database and a flask app that serves a simple static website.

MySQL requires root password to be added to Dockerfile, look through the MySQL Docker image docs for information. 

A bind mount should be used to move the createTabkle.sql into the container

app.py requires the mysql password to be added to line 8 replacing [PASSWORD]

