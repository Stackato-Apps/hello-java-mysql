# How to use mysql without Spring.

Building the Application
------------------------

To build the application, make sure you have [Maven](http://maven.apache.org/ "Maven") installed.
Then, *cd* into the root directory and execute:

	mvn clean package

That will create the *java-mysql-1.0.war* file within the 'target' directory.

Pushing to Stackato
------------------------

    stackato push -n