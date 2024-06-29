create  table department
	(dept_name		varchar(50), 
	 building		varchar(50), 
	 budget		        numeric(12,2) check (budget > 0),
	 primary key (dept_name)
	);

create table course
	(course_id		varchar(50), 
	 course_name	varchar(50), 
	 dept_name		varchar(50),
	 credits		numeric(2,0),
	 primary key (course_id),
	 foreign key (dept_name) references department (dept_name)
		on delete set null
	);

create  table instructor
	(ID			     varchar(5), 
	 name			varchar(50) not null, 
	 dept_name		varchar(50), 
	 salary			numeric(8,2) check (salary > 29000),
	phone_number     varchar(20)        ,
	 primary key (ID),
	 foreign key (dept_name) references department (dept_name)
		on delete set null
	);


create table time_slot
	(time_slot_id		varchar(10),
	 day			varchar(1),
	 start_hr		numeric(2) check (start_hr >= 0 and start_hr < 24),
	 start_min		numeric(2) check (start_min >= 0 and start_min < 60),
	 end_hr			numeric(2) check (end_hr >= 0 and end_hr < 24),
	 end_min		numeric(2) check (end_min >= 0 and end_min < 60),
	 primary key (time_slot_id, day, start_hr, start_min)
	);



 create  table lectures
 (lect_id   varchar(10),
  course_id varchar(8),
  sec_id     varchar(20),
  lect_date   date, 
  lect_time   time,
  lect_hall    varchar(7),
   lect_title   varchar(80),
  lect_description varchar(80),
  primary key (lect_id) ,
  foreign key (course_id) references course (course_id)
 );



create table sections
	(course_id		varchar(8), 
     sec_id			varchar(8),
	 semester		varchar(6)
		check (semester in ('Fall', 'Winter', 'Spring', 'Summer')), 
	 year			numeric(4,0) check (year > 1701 and year < 2100), 
	 
	 time_slot_id		varchar(10),
	 primary key (course_id, sec_id, semester, year),
	 foreign key (course_id) references course (course_id)
		on delete cascade 
	);

create  table teaches
	(teaches_id		varchar(5), 
	 course_id		varchar(8),
	 sec_id			varchar(8), 
	 semester		varchar(6),
	 year			numeric(4,0),
	instructor_id    varchar(5),
    primary key (teaches_id, course_id, sec_id, semester, year),
    foreign key (course_id, sec_id, semester, year) references sections (course_id, sec_id, semester, year) on delete cascade,
    foreign key (instructor_id) references instructor (ID) on delete cascade
);

create table student
	(student_id			varchar(5), 
	 student_name		varchar(50) not null, 
	 dept_name		varchar(50), 
	 tot_cred		numeric(3,0) check (tot_cred >= 0),
	phone_number varchar(10)                    ,
	 gender              text,
	 primary key (student_id),
	 foreign key (dept_name) references department (dept_name)
		on delete set null
	);

create  table takes
	(takes_id			varchar(5), 
	 course_id		varchar(8),
	 sec_id			varchar(8), 
	 lect_id      varchar(10),
	 semester		varchar(6),
	 year			numeric(4,0),
	 grade		        varchar(2),
	 student_id			varchar(5),
	 primary key (takes_id, course_id, sec_id, semester, year),
	 foreign key (course_id, sec_id, semester, year) references sections (course_id, sec_id, semester, year)
		on delete cascade,
	 foreign key (student_id) references student (student_id)
		on delete cascade ,
			foreign key (lect_id ) references lectures (lect_id )
		on delete cascade
	);






create  table users
( user_id   varchar(20), 
 user_name  varchar(20),
 user_type  text ,
 passward varchar(20),
 primary key (user_id)
 );



 CREATE TABLE attendance (
   record_id   varchar(50),
    takes_id	varchar(5), 
    course_id   varchar(50),
    sec_id      varchar(8),
    lect_id     varchar(10),
    semester    varchar(6),
    year        numeric(4,0),
    grade		        varchar(2),
    student_id  varchar(50),
    primary key (record_id),
    foreign key (course_id) references course (course_id)
);