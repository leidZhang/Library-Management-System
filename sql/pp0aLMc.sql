create schema PP0aLM;

create table person (
	email 		varchar(255)		not null, 
    fname		varchar(255)		not null, 
    minit 		varchar(10), 
    lname		varchar(255) 		not null, 
    username	varchar(25)			not null,
    province	varchar(255)		not null, 
    city		varchar(255)		not null, 
    street		varchar(255),
    phone		varchar(10)			not null, 
    primary key(email)
); 

create table user (
	email		varchar(255)		not null, 
    gender 		varchar(255)		not null, 
    age 		int					not null,
	uid 		varchar(255)		not null, 
    cTime		date,
    uTime		date,
    primary key(email),
    foreign key(email) references person(email)
);

create table admin (
	email 		varchar(255)		not null, 
    passwrd 	varchar(30)			not null, 
    primary key(email),
    foreign key(email) references person(email)
); 

create table borrow (
	isbn 		varchar(255)		not null,
    email		varchar(255)		not null,
    primary key(isbn, email),
    foreign key(isbn) references book(isbn),
    foreign key(email) references user(email)
);