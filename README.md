## Purpose
This is an exercise project, the goal is to get familiar with vue and spring boot by building a library management system.
## Brief Introduction
This library management system can divide into the following modules: login module, book module, category module, user module, administrator module, borrowing module, returning module, and line chart module. 
## Functions of the System
Most of these modules have CRUD functions. Apart from the base functions, the administrators who log in to the system can change their password and the status of users, or in other words, administrators can lock and unlock a specific user account. An administrator can also recharge scores for users. 

The login module, borrowing module, returning module, and line chart module do not have all base functions since it is not needed. Administrators can create and delete new borrow or return records but cannot edit them. Users have to consume some score when borrowing a book. If a user does not give back the book in time, there will have a penalty charge, and if a user has a negative score when returning the book, the account will be locked. 
## Parts to be Improved
This system still has unfinished functions, such as encryption in the backend. They will be completed once I finish more relevant courses. 