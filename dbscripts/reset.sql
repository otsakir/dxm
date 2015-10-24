drop table members;
create table members (
	sid varchar(36) PRIMARY KEY,
	name varchar(128),
	username varchar(32),
	is_producer int NOT NULL ,
	is_consumer int NOT NULL
);

drop table locations;
create table locations (
	sid varchar(36) PRIMARY KEY ,
	member_sid varchar(36) NOT NULL,
	address varchar(128),
	name varchar(128),
	lng float,
	lat float
);

drop table goods;
create table goods (
	sid varchar(36) PRIMARY KEY,
	name varchar(128) NOT NULL,
	description text,
	photoUrl varchar(256),
	moreUrl varchar(256)
);

drop table location_goods;
create table location_goods (
	location_sid varchar(36),
	good_sid varchar(36),
	primary key(location_sid, good_sid)
);

insert into members values (1,'Tester','tester@gmail.com',0,1);
insert into locations values (1,1,'Αθηνάς 34', 'Χωράφι',23.7032341,37.9908996);
insert into goods values (1,'Σταφύλι σουλτανίτα', 'Παραδοσιακή σουλτανίνα Ζεμενού', null,'http://www.google.com');
insert into location_goods values (1, 1);
