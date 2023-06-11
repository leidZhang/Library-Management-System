## Introduction
This is an exercise project that aims to get familiar with vue.js and Spring Boot by building a library management system. The system can manage books, categories, users, administrators, borrowings and returns. It also provides a line chart module to visualize the statistics of the library.

The system uses vue.js as the front-end framework and Spring Boot as the back-end framework. It also uses Element UI for the user interface design and Echarts for the data visualization. The system can help librarians to easily access and manage the library resources. It can also improve the efficiency and security of the library operations.

## Features
- <b>CRUD functions: </b>Administrators can create, read, update, and delete information for books, categories, users, administrators, borrow records, and return records.
- <b>Data visualization function: </b>Administrators can view a line chart that shows the statistics of the library, such as the number of books borrowed and returned.  
- <b>Login function: </b>Administrators need to log in to the system before they can perform any data manipulation. The system verifies the username and password of the administrators and prevents unauthorized access.  
- <b>MD5 encryption algorithm: </b>The system encrypts sensitive information, such as passwords, using the MD5 algorithm. Only the encrypted information is stored in the MySQL database, which enhances the security of the system. 
- <b>Point management functions: </b>Users need to pay points to borrow books. The system refunds the points when users return the books in advance. The system charges additional points when users do not return the books according to the due date. 
- <b>Account freezing function: </b>The system automatically freezes the account of a user who has negative points. Administrators can manually unfreeze the account after the user pays back the points. 

## Installation
To install and run this project, you need to have Maven and npm installed on your machine. If you don’t have them, you can download them from the following links:
- Maven: https://maven.apache.org/download.cgi
- npm: https://www.npmjs.com/get-npm

Then, follow these steps:
1. Clone this repository to your local machine. You can use the following command:  
```
git clone https://github.com/yourname/library-management-system.git
```
2. Navigate to the project folder and run `npm install` to install the dependencies. This may take a few minutes.  
```
cd library-management-system  
npm install
```
3. Run mvn spring-boot:run to start the Spring Boot server. You should see a message like this:   
```
Started LibraryManagementSystemApplication in 12.345 seconds (JVM running for 13.456)
```
4. Run npm start to start the vue server and launch the application on your browser. You should see a message like this:  
```
DONE  Compiled successfully in 1234ms

 App running at:
 - Local:   http://localhost:8080/
 - Network: http://192.168.1.1:8080/
```
5. To verify that the installation is successful, open your browser and go to http://localhost:8080/. You should see the login page of the library management system.

To use the library management system, you need to log in with an email address and password. You can use the following:  
<b>Email:</b> admin02@libman.com  
<b>Password:</b> 000000  

## Project Preview
### Homepage 
<img src="/images/homepage.png" />

### Login 
<img src="/images/login2.png" />

### Users
<img src="/images/userlist.png" />
<img src="/images/adduser.png" />

### Borrow Record
<img src="/images/borrowlist.png" />

### Return Record
<img src="/images/returnlist.png" />

## License
This project is licensed under the Apache-2.0 license - see the LICENSE file for details.
