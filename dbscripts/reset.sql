drop table users;
create table users (
	sid varchar(32) PRIMARY KEY,
	name varchar(128),
	username varchar(32),
	is_producer int NOT NULL ,
	is_consumer int NOT NULL
);

drop table locations;
create table locations (
	sid varchar(32) PRIMARY KEY ,
	address varchar(128),
	name varchar(128),
	lng float NOT NULL,
	lat float NOT NULL
);
drop table goods;
create table goods (
	sid varchar(32) PRIMARY KEY,
	name varchar(128) NOT NULL,
	description text,
	photoUrl varchar(256),
	moreUrl varchar(256)
);

insert into users values (1,'nando@gmail.com','Orestis Tsakiridis',0,1);
insert into locations values (1,'Γρηγορίου Λαμπράκη 32', 'Το σπίτι μας στη Φιλαδέλφεια',0.12,0.34);
insert into goods values (1,'Σταφύλι σουλτανίτα', 'Παραδοσιακή σουλτανίνα Ζεμενού', null,'http://www.google.com');
