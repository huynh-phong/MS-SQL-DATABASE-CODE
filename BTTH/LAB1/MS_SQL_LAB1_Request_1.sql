create database TRUNGTAMTHEDUCTHETHAO;

use TRUNGTAMTHEDUCTHETHAO;

create table PHONGTAP
(
MAPH char(5) primary key,
TENPHONG varchar(50),
DIACHI varchar(100),
SUCCHUA int,
TRANGTHAI varchar(20)
);

create table HUANLUYENVIEN
(
MAHLV char(5) primary key,
HOTEN varchar(50),
CHUYENMON varchar(15),
SDT varchar(15),
EMAIL varchar(50)
);

create table HOCVIEN
(
MAHV char(5) primary key,
HOTEN varchar(50),
NGSINH smalldatetime,
SDT varchar(15),
DIACHI varchar(100),
GIOITINH varchar(10),
NGTG smalldatetime
);

create table LOPTAP
(
MALOP char(5) primary key,
MAPH char(5),
MAHLV char(5),
TENLOP varchar(50),
NGAYBD smalldatetime,
NGAYKT smalldatetime,
TRANGTHAI varchar(20)
);

alter table LOPTAP add foreign key(MAPH) references PHONGTAP(MAPH);
alter table LOPTAP add foreign key(MAHLV) references HUANLUYENVIEN(MAHLV);

create table DANGKY
(
MAHV char(5),
MALOP char(5),
NGAYDK smalldatetime,
primary key(MAHV, MALOP)
);

alter table DANGKY add foreign key(MAHV) references HOCVIEN(MAHV);
alter table DANGKY add foreign key(MALOP) references LOPTAP(MALOP);

create table LICHTAP
(
MALOP char(5),
NGAYTAP smalldatetime,
GIOBATDAU time,
GIOKETTHUC time,
primary key(MALOP,NGAYTAP,GIOBATDAU)
);

alter table LICHTAP add foreign key(MALOP) references LOPTAP(MALOP);

set dateformat DMY;

insert into PHONGTAP values 
('PH001','Yoga Linh Dam','Ha Noi','25','Hoat dong'),
('PH002','Gym Nguyen Van Cu','TP.HCM','60','Hoat dong');

insert into HUANLUYENVIEN values 
('HLV01','Pham THi Hong','Toga','0905127656','hong.yoga@gmail.com'),
('HLV02','Le Minh Quan','Gym','0916947354','quan.gym@gmail.com');

insert into HOCVIEN values
('HV001','Tran Van Bao','20-05-2002','0878691539','Ha Noi','Nam','01-11-2024'),
('HV002','Ho Thi Mai','11-09-2000','093121890','Quang Ngai','Nu','02-12-2024');

insert into LOPTAP values
('LT001','PH001','HLV01','Yoga for Beginners','06-04-2025','05-05-2025','Da ket thuc'),
('LT002','PH002','HLV02','Morning Gym','16-05-2025','15-06-2025','Dang hoat dong');

insert into DANGKY values
('HV001','LT001','15-03-2025'),
('HV002','LT002','29-04-2025');

insert into LICHTAP values
('LT001','07-04-2025','18:30','19:30'),
('LT001','13-04-2025','19:00','20:00'),
('LT002','18-05-2025','7:00','8:00'),
('LT002','25-05-2025','7:30','8:30');

select * from PHONGTAP;
select * from HUANLUYENVIEN;
select * from HOCVIEN;
select * from LOPTAP;
select * from DANGKY;
select * from LICHTAP;