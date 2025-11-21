create database  Training_Managemen;
use  Training_Managemen;
create table course(
course_id char(10) primary key,
course_name varchar(100) unique,
category varchar(100),
start_date date,
end_date date ,
fee int
);
create table student(
student_id char(10) primary key ,
student_full_name varchar(150) not null,
student_email varchar(255) unique,
student_phone varchar(15) unique,
student_dob date,
gender enum('male','femal','other')
);
create table Enrollment(
enrollment_id  int PRIMARY KEY auto_increment,
student_id CHAR(10), 
foreign key (student_id) references student(student_id),
course_id char(10),
foreign key (course_id) references course(course_id),
enroll_date date,
enrollment_status enum('Confirmed','Cancelled','Pending'),
slot_count int not null default(1)
);
create table Payment(
payment_id int primary key auto_increment,
enrollment_id int,
foreign key (enrollment_id) references Enrollment(enrollment_id),
payment_method enum("Credit Card", "Bank Transfer", "Cash"),
payment_amount float,
payment_date date,
payment_status enum("Success", "Failed", "Pending")
);
insert into course(course_id,course_name,category,start_date,end_date ,fee)
values ('D0001','TIẾNG ANH','GIAO TIẾP','2025-10-10','2025-12-25','30000'),
('D0002','TOÁN','TƯ DUY','2025-10-11','2025-12-26','200000'),
('D0003','NGỮ VĂN','XÃ HỘI','2025-10-12','2025-12-27','22000'),
('D0004','SINH HỌC','KHOA HỌC-CÔNG NGHỆ','2025-10-13','2025-12-28','350000'),
('D0005','TÂM LÍ HỌC','TÂM LÍ','2025-10-14','2025-12-29','380000');
insert into student(student_id ,student_full_name,student_email ,student_phone,student_dob,gender)
VALUES ('H0001','NGUYỄN VĂN A','ABC@gmail.com','123456789','2007-10-10','male'),
('H0002','NGUYỄN VĂN B','ABCD@gmail.com','1234567890','2007-10-11','female'),
('H0003','NGUYỄN VĂN C','ABCde@gmail.com','12345678901','2007-10-13','male'),
('H0004','NGUYỄN VĂN D','ABCFE@gmail.com','123456789023','2007-10-15','FEmale'),
('H0005','NGUYỄN VĂN E','ABADC@gmail.com','12345678988','2007-10-16','male');
insert into Enrollment(student_id,course_id,enroll_date,enrollment_status,slot_count)
values 
('H0001','D0001','2025-11-11','Pending','1'),
('H0002','D0002','2025-11-12','Confirmed','1'),
('H0003','D0003','2025-11-13','Cancelled','1'),
('H0004','D0004','2025-11-14','Confirmed','1'),
('H0005','D0005','2025-11-15','Pending','1');
insert into Payment(enrollment_id,payment_method,payment_amount,payment_date,payment_status)
values 
('H0001', 'Credit Card','2456.00','2025-11-10','Success'),
('H0002', 'Bank Transfer','2457.00','2025-11-19','Success'),
('H0003', 'Cash','245678.00','2025-11-20','Failed'),
('H0004', 'Credit Card','24566.00','2025-11-26','Success'),
('H0005', 'Bank Transfer','2456578.00','2025-11-27','Pending');
set sql_safe_updates=0;
update Payment
set payment_status ='Success'
where payment_amount>0 and payment_method ="Credit Car";
update Payment
set payment_status ='Pending'
where payment_method='Bank Transfer' and payment_amount<100;
update Payment
set payment_status='succees'
where payment_amount >0 and payment_method='Credit Card' and payment_date =current_date();
delete from Payment
where payment_status='Pending' and payment_method='Cash';
select student_id ,student_full_name,student_email ,student_dob,gender
from student 
order by student_full_name asc
limit 5 ;
select course_id,course_name,category,fee
from course 
order by fee desc;
select s.student_full_name,s.student_id,e.enrollment_id,e.enrollment_status
from student s inner join Enrollment s on s.student_id =e.Enrollment and s.student_full_name= e.Enrollment.status
where e.enrollment_status ='Cancelled';
select e.course_id,e.student_id ,e.enrollment_id ,e.slot_count,e.enrollment_status
from enrollment e
join course c on c.course_id=e.course_id
where e.enrollment_status ='Confirmed'
order by e.slot.count desc;
select e.course_id,s.student_full_name ,e.enrollment_id ,e.slot_count
from Erollment e
join course c on c.course_id=e.course_id
join student s on s.student_id= e.student_id
where e.slot_count between 2 and 3
order by s.student_full_name asc ;
select distinct s.student_full_name
from student s
join enrollment e on s.student_id=e.student_id  
join payment p on p.payment_status=e.enrollment_status 
where p.payment_status='Pending' and s.slot_count >=2;
select s.student_full_name, sum(payment_amount )
from studen s
join student s on s.student_id= e.enrollment
join payment p on p.payment_status =e.enrollment_status
where p.payment_status ='success';
--- 5.10
select distinct s.student_full_name, s.student_dob
from Student s
join Enrollment e on s.student_id = e.student_id
join Payment p on e.enrollment_id = p.enrollment_id
where year(s.student_dob) < 2000 and p.payment_status = 'success';





