## 52North's Timeseries Protector
The project’s aim is to define rules to restrict access to SOS contents on the operation and parameter level.This goal is achieved with a nice graphical user interface to enable the admin user to manage permissions for a particular enforcement point, which is the connection point for the client instead of the original SOS endpoint.

### Installation Instructions
Deploy the .war file of the project either by using the Tomcat's Manager App or use an IDE like Eclipse to unwrap the web archive for you. Once the app is deployed on the tomcat, homepage of the app can be reached by <code>http://localhost:8080/project_name/</code> 

#### Configuring the users.xml
Any further usage of the application from the homepage is protected by HTTP Basic Authentication, so the default combination is
username : admin <br/>
password : admin
To change the combination browse the project directory and edit the users.xml in WEB-INF folder, after the changes restart the Tomcat and login with the new credentials

#### Configuring the user roles
The application comes with some default user roles which are initialized in <code> editor-config.xml </code>. This file can be found in WEB-INF/spring/ directory. The property which can be configured for user roles is <code>configuredUsers</code>

#### Configuring Enforcement Points
Currently the application does not comes with the facility to incorporate enforcement points <i> on the fly </i> (atleast in this version) provided by the user. Enforcement point mapping has to be done manually by the user with the sos instances which are stated in the <code> sos-data-instances.xml </code>. This mapping is done in the <code>editor-config.xml</code>

#### Browser Dependencies
For the application to work successfully on the client side it is highly suggested that modern day browsers which support HTML5 <code> localStorage, sessionStorage, data-attributes, input types and attributes </code> should be used otherwise the user won't be able to use the application

### Contacts

For questions and comments please contact [Henning Bredel](mailto:h.bredel@52north.org) | [@ridoo](https://github.com/ridoo)
and [Dushyant Sabharwal](mailto:d.sabharwal@52north.org) | [@dushyant89](https://github.com/dushyant89)
