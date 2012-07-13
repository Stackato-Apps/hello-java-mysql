Java Mysql Sample
=============

This application is a simple java application that shows how to connect
to a mysql service using the VCAP_SERVICES environment variable.

This application uses a [java buildpack](https://github.com/heroku/heroku-buildpack-java).

The java buildpack allows to download dependencies, build and run the application directly on the server. You do not need to 
build the application before pushing it on Stackato.
It uses [Jetty](http://jetty.codehaus.org/jetty/). Jetty is a lightweight Java application server which includes a Jetty Runner jar. 
Therefore, the Java Application can be run directly from the java command and can be passed a war file to load right 
on the command line. An example of this would be:

	java -jar jetty-runner.jar application.war

As it is a Heroku java buildpack, the execution is declared in the Procfile file:

	web:	 java $JAVA_OPTS -jar target/dependency/jetty-runner.jar --port $PORT target/*.war


Deploying the Application to Stackato
-------------------------

To deploy to stackato:

    stackato push -n

The application will download dependencies. Then it will be built and run.
You can view the application at the 'Application Deployed URL'.

That's all. Have fun!
