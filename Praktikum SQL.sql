-- TUGAS PRAKTIKUM --
-- membuat database dengan nama Praktikum
create database Praktikum1;

-- membuat tabel mahasiswa
create table mahasiswa(
    nim int,
    nama varchar(200),
    jenis_kelamin varchar(10),
    alamat varchar(100),
    primary key(nim)
);

-- membuat tabel ambil_mk
create table ambil_mk(
    Nim int,
    kode_mk varchar(100)
);

-- membuat tabel matakuliah
create table matakuliah(
    kode_mk varchar(100),
    nama_mk varchar(200),
    sks int,
    semester int,
    primary key(kode_mk)
);

-- mengisi tabel mahasiswa
insert into mahasiswa values
("101","Arif","L","Jl. Kenangan"),
("102","Budi","L","Jl. Jombang"),
("103","Wati","P","Jl. Surabaya"),
("104","Ika","P","Jl. Jombang"),
("105","Tono","L","Jl. Jakarta"),
("106","Iwan","L","Jl. Bandung"),
("107","Sari","P","Jl. Malang");

-- mengisi tabel ambil_mk
insert into ambil_mk values
("101","PTI447"),
("103","TIK333"),
("104","PTI333"),
("104","PTI777"),
("111","PTI123"),
("123","PTI999");

--mengisi tabel matakuliah
insert into matakuliah values
("PTI447","Praktikum Basis Data","1","3"),
("TIK342","Praktikum Basis Data","1","3"),
("PTI333","Basis Data Terdistribusi","3","5"),
("TIK123","Jaringan Komputer","2","5"),
("TIK333","Sistem Operasi","3","5"),
("PTI123","Grafika Multimedia","3","5"),
("PTI777","Sistem Informasi","2","3");

-- Dapatkan data mahasiswa yang mengambil matakuliah
select distinct mahasiswa.nim, mahasiswa.nama
from mahasiswa inner join ambil_mk
on mahasiswa.nim = ambil_mk.nim;

-- Kelompokkan data mahasiswa yang tidak mengambil matakuliah berdasarkan jenis kelaminnya
-- kemudian hitung banyaknya
select mahasiswa.jenis_kelamin, count(mahasiswa.jenis_kelamin) as jumlah
from mahasiswa left outer join ambil_mk
on mahasiswa.nim = ambil_mk.nim
where ambil_mk.nim is NULL
group by mahasiswa.jenis_kelamin;

-- Dapatkan nim dan nama mahasiswa yang mengambil matakuliah beserta kode_mk dan nama_mk yang diambilnya
select mahasiswa.nim, mahasiswa.nama, matakuliah.kode_mk, matakuliah.nama_mk
from mahasiswa inner join ambil_mk
on mahasiswa.nim = ambil_mk.nim
inner join matakuliah
on ambil_mk.kode_mk = matakuliah.kode_mk;

-- Dapatkan nim, nama, dan total sks yang diambil oleh mahasiswa,  total sksnya lebih dari 4 dan kurang dari 10
select mahasiswa.nim, mahasiswa.nama, sum(sks) as total_sks
from mahasiswa inner join ambil_mk
on mahasiswa.nim = ambil_mk.nim
inner join matakuliah
on ambil_mk.kode_mk = matakuliah.kode_mk
group by mahasiswa.nama
having sum(sks) > 4 and
sum(sks) < 10;

-- Dapatkan data matakuliah yang tidak diambil oleh mahasiswa tedaftar
select matakuliah.kode_mk, matakuliah.nama_mk, matakuliah.sks, matakuliah.semester
from mahasiswa left outer join ambil_mk
on mahasiswa.nim = ambil_mk.nim
right outer join matakuliah
on ambil_mk.kode_mk = matakuliah.kode_mk
where nama is null;

-- TUGAS RUMAH --
-- membuat database dengan nama tugasrumah
create database tugasrumah;

-- membuat tabel instruktur
create table instruktur(
    nip int,
    namains varchar(200),
    jurusan varchar(20),
    asalkota varchar(20),
    primary key(nip)
);

-- membuat tabel matakuliah
create table matakuliah(
    nomk varchar(10),
    namamk varchar(100),
    sks int,
    primary key(nomk)
);

-- membuat tabel kuliah
create table kuliah(
    nip varchar(10),
    nomk varchar(20),
    ruangan int,
    jmlmhs int
);

-- mengisi tabel instruktur
insert into instruktur values
("1","Steve Wozniak","Ilmu Komputer","Bantul"),
("2","Steve Jobs","Seni Rupa","Solo"),
("3","James Gosling","Ilmu Komputer","Klaten"),
("4","Bill gates","Ilmu Komputer","Magelang");

-- mengisi tabel matakuliah
insert into matakuliah values
("KOM101","Algoritma dan Pemrograman","3"),
("KOM102","Basis Data","3"),
("KOM201","Pemrograman Berorientasi Objek","3"),
("SR101","Desain Elementer","3");

-- mengisi tabel kuliah
insert into kuliah values
("1","KOM101","101","50"),
("1","KOM102","102","35"),
("2","SR101","101","45"),
("3","KOM201","101","55");

-- Tampilkan nomor dan matakuliah yang mesertanya lebih dari 40 orang
select matakuliah.nomk, matakuliah.namamk
from instruktur inner join kuliah
on instruktur.nip = kuliah.nip
inner join matakuliah
on kuliah.nomk = matakuliah.nomk
where jmlmhs > 40;

-- Tampilkan nip dan nama instruktur yang mengajar matakuliah 'Basis Data'
select instruktur.nip, instruktur.namains
from instruktur inner join kuliah
on instruktur.nip = kuliah.nip
inner join matakuliah
on kuliah.nomk = matakuliah.nomk
where namamk like '%Basis Data%';

-- Tampilkan total jumlah mahasiswa yang diajar oleh 'Steve Wozniak'
select sum(jmlmhs) as total_jumlah
from instruktur inner join kuliah
on instruktur.nip = kuliah.nip
inner join matakuliah
on kuliah.nomk = matakuliah.nomk
where namains like '%Steve Wozniak%';

-- TUGAS RUMAH 2 --
-- membuat database dengan nama tugasrumah2
create database tugasrumah2;

-- membuat tabel costumer
create table costumer(
    customer_id varchar(10),
    customer_name varchar(100),
    customer_addres varchar(100),
    primary key(costumer_id)
);

-- membuat tabel orders
create table orders(
    order_id int,
    order_date date,
    customer_id varchar(100),
    qty int,
    amount int,
    primary key(order_id)
);

-- mengisi tabel costumer
insert into customer values 
("CS001","Adiba","Pandaan"),
("CS002","Erwina","Sidoarjo"),
("CS003","Annas","Blitar"),
("CS004","Galuh","Malang"),
("CS005","Dewi","Tulungangung");

-- mengisi tabel orders
insert into orders values
("0001","2015-04-01","CS001","2","40000"),
("0002","2015-04-08","CS003","3","50000"),
("0003","2015-04-14","CS005","1","60000");

SELECT distinct costumer_id, costumer_name
from costumer inner join orders
on .costucostumer_id
UNION
SELECT order_id, order_date, qty, amount
from orders
where  is NULL;
