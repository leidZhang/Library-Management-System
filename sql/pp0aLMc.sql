# summerization afterwards
create schema PP0aLM;
use PP0aLM;

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
    status 		tinyint,
    primary key(email)
); 

create table user (
	email		varchar(255)		not null, 
    gender 		varchar(255)		not null, 
    age 		int					not null,
	uid 		varchar(255)		not null, 
    cTime		datetime,
    uTime		datetime,
    aCredit 	int,
    primary key(email),
    foreign key(email) references person(email)
);

create table admin (
	email 		varchar(255)		not null, 
    passwrd 	varchar(30)			not null, 
    primary key(email),
    foreign key(email) references person(email)
); 

create table category (
	id 			int 				not null,
    name		varchar(255),
    remark		varchar(255),
    cDate		datetime,
    uDate		datetime,
    pid			int,
    primary key(id)
);

create table book (
	isbn 		varchar(255)		not null,
    name		varchar(255),
    category	varchar(255),
    description 	varchar(500),
    publish_date 	varchar(255),
    author		varchar(255),
    publisher	varchar(255),
    cDate		datetime,
    uDate		datetime,
    cover		varchar(255),
    credit		int,
    number		int,
    primary key(isbn)
);

create table borrow (
	isbn 		varchar(255)		not null,
    email		varchar(255)		not null,
    id 			int 				not null, 
    cDate 		datetime,
    bstatus 	varchar(255),
    duration 	int,
    rDate 		datetime,
    notification 	varchar(255),
    primary key(isbn, email, id),
    foreign key(isbn) references book(isbn) on delete cascade,
    foreign key(email) references user(email) on delete cascade
);

create table reterns (
	isbn 		varchar(255)		not null,
    email		varchar(255)		not null,
    id 			int 				not null, 
    cDate 		datetime,
    bstatus 	varchar(255),
    duration 	int,
    rDate 		datetime,
    aDate 		datetime,
    primary key(isbn, email, id),
    foreign key(isbn) references book(isbn) on delete cascade,
    foreign key(email) references user(email) on delete cascade
);