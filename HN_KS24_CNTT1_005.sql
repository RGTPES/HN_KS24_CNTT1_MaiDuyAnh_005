drop database if exists HN_KS24_CNTT1_005;
create database HN_KS24_CNTT1_005;
use HN_KS24_CNTT1_005;	
create table Creators (
creator_id varchar(5) primary key ,
creator_name varchar(100),
creator_email varchar(100) unique,
creator_phone varchar(15)  unique,
creator_platform  varchar(50)
);
create table Studios(
studio_id varchar(5) primary key,
studio_name varchar(100),
studio_location varchar(100),
hourly_price decimal(10,2),
studio_status varchar(20)
);
create table LiveSessions(
session_id int auto_increment ,
creator_id varchar (5),
studio_id varchar(5),
session_date date ,
duration_hours int,
primary key( session_id , creator_id ,studio_id ),
foreign key (creator_id) references Creators(creator_id),
foreign key (studio_id) references Studios(studio_id)
);
create table Payments (
payment_id int auto_increment,
session_id int ,
payment_method varchar(50),
payment_amount decimal(10,2),
payment_date date,
primary key ( payment_id , session_id) ,
foreign key (session_id) references LiveSessions(session_id)
);
insert into Creators (creator_id,creator_name,creator_email,creator_phone,creator_platform)
values ("CR01","Nguyen Van A","a@live.com" ,"0901111111","Tiktok"),
("CR02","Tran Thi B","b@live.com" ,"0902222222","Youtube"),
("CR03","Le Minh C","c@live.com" ,"0903333333","Facebook"),
("CR04","Pham Thi D","d@live.com" ,"0904444444","Tiktok"),
("CR05","Vu Hoang E","e@live.com" ,"0905555555","Shopee live");
insert into Studios (studio_id, studio_name ,studio_location,hourly_price,studio_status)
values("ST01" , "Studio A" , "Ha Noi" , 20.00 , "Available"),
("ST02" , "Studio B" , "HCM" , 2500.00 , "Available"),
("ST03" , "Studio C" , "Danang" , 30.00 , "Booked"),
("ST04" , "Studio D" , "Ha Noi" , 22.00 , "Available"),
("ST05" , "Studio E" , "Can Tho" , 18.00 , "Maintenance");
insert into LiveSessions (session_id,creator_id,studio_id,session_date,duration_hours)
values (1 , "CR01" , "ST01" , "2025-05-01" , 3),
(2 , "CR02" , "ST02" , "2025-05-02" , 4),
(3 , "CR03" , "ST03" , "2025-05-03" , 2),
(4 , "CR04" , "ST04" , "2025-05-04" , 5),
(5 , "CR05" , "ST05" , "2025-05-05" , 1),
(6 , "CR03" , "ST03" , "2025-05-03" , 2),
(7 , "CR04" , "ST04" , "2025-05-04" , 5),
(8 , "CR05" , "ST05" , "2025-05-05" , 1);

insert into Payments (payment_id,session_id,payment_method,payment_amount,payment_date)
values(1 , 1 ,"Cash" , 60.00 ,"2025-05-01"),
(2 , 2 ,"Credit Card" , 100.00 ,"2025-05-02"),
(3 , 3 ,"Bank Transfer" , 60.00 ,"2025-05-03"),
(4 , 4 ,"Credit Card" , 110.00 ,"2025-05-04"),
(5 , 5 ,"Cash" , 25.00 ,"2025-05-05"),
(6 , 6 ,"Bank Transfer" , 60.00 ,"2025-05-06"),
(7 , 7 ,"Credit Card" , 110.00 ,"2025-05-07"),
(8 , 8 ,"Cash" , 25.00 ,"2025-05-08");
-- phan 1
-- 1
Update  Creators
set creator_platform = "Youtube" 
where creator_id = "CR03";
-- 2
Update Studios
set  studio_status = "Available" , hourly_price = hourly_price * 0.9
where  studio_id = "ST05";
-- 3
Delete from  Payments
where payment_method = 	"Cash" and payment_date < "2025-05-03";
-- phan2
-- 1
select studio_name from Studios where studio_status = 'Available' and hourly_price > 20;
-- 2
select creator_name, creator_phone from Creators where  creator_platform = "TikTok";
-- 3
select studio_id,studio_name,hourly_price from Studios order by hourly_price desc;
-- 4
select payment_id from Payments where payment_method = 'Credit Card' limit 3;
-- 5
select 	creator_id, creator_name from Creators limit 2 offset 2;
-- phan3
-- 1
select l.session_id , c.creator_name,s.studio_name, l.duration_hours,p.payment_amount
from LiveSessions l 
join Creators c on l.creator_id = c.creator_id
join Studios s on l.studio_id = s.studio_id
join Payments p on l.session_id = p.session_id;
-- 2
select  s.studio_name  , count(*)  as 'total_use'
from Studios s 
join LiveSessions l on s.studio_id = l.studio_id 
group by s.studio_name;
-- 3
select payment_method , sum(payment_amount) as "tongdoanhthu" from Payments group by payment_method;
-- 4
select c.creator_id, c.creator_name, count(l.session_id) as 'total_session'
from Creators c
join LiveSessions l on c.creator_id = l.creator_id
group by c.creator_id, c.creator_name
having count(l.session_id) >= 2;
-- 5
select studio_id, studio_name, hourly_price
from Studios
where hourly_price > (select avg(hourly_price) from Studios);
-- 6
select c.creator_name, c.creator_email
from Creators c
join LiveSessions l on c.creator_id = l.creator_id
join Studios s on l.studio_id = s.studio_id
where s.studio_name = 'Studio B';
-- 7
select l.session_id, c.creator_name, s.studio_name, p.payment_method, p.payment_amount
from Creators c
left join LiveSessions l on c.creator_id = l.creator_id
left join  Studios s on l.studio_id = s.studio_id
left join  Payments p on l.session_id = p.session_id;
-- cai 1 bi null boi vi da delete o ben tren 











