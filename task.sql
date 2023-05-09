create database KeepNote

use KeepNote

create table Users
(
userId int primary key,
userName varchar(20),
user_Added_Date Date,
user_password varchar(20),
user_mobile bigint
)

insert into Users values(112233,'Maya','2019-01-01','Maya1214',8012345679),(112244,'Nair','2019-01-11','Welcome',9023778467)

select * from users

create table note
(
note_id int primary key,
note_title varchar(20),
note_content varchar(50),
note_status varchar(20),
note_creation_date Date,
userId int references Users(userId)
)

insert into note values(1,'Today Tasks','1.Check emails and reply to them 2.Start the pro.','InProgress','2019-01-21',112233),
                       (2,'Training to plan','1.Application related 2.Technical realted','Yet To Start','2019-01-31',112244),
                       (3,'Things to have today','1.Fruits 2.More water','InProgress','2019-01-25',112244)

select * from note

create table Category
(
category_id int primary key,
category_name varchar(20),
category_descr varchar(50),
category_creation_date Date,
category_creator int
)


insert into category values(1,'Official','Office realted notes','2019-01-21',112233),
                           (2,'Diet','Health realted notes','2019-01-24',112244)

select * from Category

create table Reminder
(
reminder_id int primary key,
reminder_name varchar(20),
reminder_descr varchar(50),
reminder_type varchar(20),
reminder_creation_date Date,
reminder_creator int
)

insert into reminder values(1,'KT reminder','Session on technical queries','Office Reminders','2019-02-12',112233),
                            (2,'Personal reminder','Pick children','Personal reminders','2019-02-14',112244)
select * from reminder

create table NoteCategory
(
notecategory_id int primary key,
note_id int references note(note_id),
category_id int references Category(category_id)
)
insert into notecategory values(1,1,1),(2,2,1),(3,3,2)
select * from notecategory



create table NoteReminder
(
note_reminder_id int primary key,
note_id int references note(note_id),
reminder_id int references Reminder(reminder_id)
)
insert into notereminder values(1,3,2),(2,2,1)
select * from notereminder

alter table category add constraint fk1 foreign key(category_creator) references users(userid)
alter table reminder add constraint fk2 foreign key(reminder_creator) references users(userid)



select * from users
select * from note
select * from category
select * from reminder
select * from notecategory
select * from NoteReminder

--1.Fetch the row from User table with Id=112233 and Password=’Maya1214’.
use KeepNote

select * from users where userid=112233 and user_password='Maya1214'

--2.Fetch all the rows from Note table with note_creation_date=’01/31/2019’.
select * from  note where note_creation_date='2019-01-31'

--3.Fetch all the Categories created after ‘01/22/2019’.
select * from category where category_creation_date>'2019-01-22'

--4.Fetch all category details which belongs to note with note id=1.
--select * from NoteCategory where note_id=1
select * from category inner join note on  category.category_id = note.note_id where note.note_id=1

--5.Fetch all the Notes from the Note table with userId=112244
select * from note where userid = 112244

--6.Fetch all the Notes from the Note table for category_id=1.
select * from note inner join category on note.note_id=category.category_id where category_id =1

--7.Fetch all the reminder details for note id=2.
--select * from notereminder where note_id=2
select * from Reminder inner join note on reminder.reminder_id=note.note_id where note_id =2

--8.Write a query to change the note_status to ‘Completed’ with note Id=3.
update note set note_status='Completed' where note_id = 3
select * from note

--9.Write a query to set a reminder of type ‘Personal Reminders’ for Note with note id=1. 
--[Find reminder id based upon reminder_type]
update Reminder set reminder_type='personal reminders' where reminder_creator=(select userid from note where note_id = 1)
select * from Reminder



--10.Write a query to remove all reminders from Note with note_id=2.
delete  from NoteReminder where note_id=2
select * from NoteReminder
