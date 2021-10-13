-- membuat database dengan nama amanda_RPL_29
create database amanda_RPL_29;

-- membuat tabel siswa
create table siswa(
    nis varchar(100),
    nama varchar(200),
    id_kelas varchar(10),
    primary key(nis)
);

-- menambahkan primary key pada table yg sudah ada
alter table siswa add primary key(nis);

-- membuat tabel kelas
create table kelas(
     kode_kelas varchar(20),
     nama_kelas varchar(50),
     primary key(kode_kelas)
);

-- membuat tabel mapel
 create table mapel(
    -> kode_mapel varchar(20),
    -> nama_mapel varchar(200),
    -> primary key(kode_mapel)
    -> );

-- membuat table guru
create table guru(
    -> id_guru varchar(20),
    -> nama_guru varchar(300),
    -> primary key(id_guru)
    -> );

-- membuat table kbm
create table kbm(
    -> kode_mapel varchar(20),
    -> kode_kelas varchar(20),
    -> id_guru varchar(20)
    -> );

-- membuat table nilai
create table nilai(
    -> nis varchar(20),
    -> kode_mapel varchar(20),
    -> id_guru varchar(20),
    -> nilai double
    -> );

-- menambah kolom
alter table mapel
    -> add kkm double;

-- mengganti nama kolom id_kelas -> kode_kelas pada tabel siswa
alter table siswa
    -> change id_kelas kode_kelas varchar(20);

-- menghapus kolom
alter table nilai
    -> drop id_guru;

-- mengisi tabel siswa
insert into siswa values -- Karna ada 's' nya maka bisa mengisi data lebih dari satu
    -> ("111","Ana Putri","XR2"),
    -> ("112","Annisa Rachmawati","XR2"),
    -> ("113","Alipah Nurhidayati","XR1"),
    -> ("114","Aguwin Ardi Pranata","XR1"),
    -> ("115","Abdul Widodo","XR3"),
    -> ("116","Darmo Joyo","XR3"),
    -> ("117","Rosidatul Maghfiroh","XR4"),
    -> ("118","Salwatul","XR4"),
    -> ("119","Widya Yunitha","XR5"),
    -> ("120","Yudhawan Anis","XR5");

-- mengisi tabel kelas
 insert into kelas values
    -> ("XR1","X RPL 1")
    -> ("XR2","X RPL 2")
    -> ("XR3","X RPL 3")
    -> ("XR4","X RPL 4")
    -> ("XR5","X RPL 5");

-- mengisi tabel mapel
 insert into mapel values
    -> ("BIG","Bahasa Inggris","80"),
    -> ("BIN","Bahasa Indonesia","80"),
    -> ("KIM","Kimia","70"),
    -> ("MTK","Matematika","75"),
    -> ("PKN","Pendidikan Kewarganegaraan","75"),
    -> ("SI","Sejarah Indonesia","78");

-- mengisi tabel guru
insert into guru values
    -> ("001","Shelvy Fitria"),
    -> ("002","Siti Kurniawati"),
    -> ("003","Ukhty Aulia");

-- mengisi tabel kbm
insert into kbm values
    -> ("KIM","XR4","002"),
    -> ("MTK","XR4","001"),
    -> ("MTK","XR3","001"),
    -> ("MTK","XR2","001"),
    -> ("MTK","XR1","001"),
    -> ("MTK","XR5","001"),
    -> ("BIN","XR5","003"),
    -> ("BIN","XR4","003"),
    -> ("BIG","XR5","003"),
    -> ("SI","XR4","001"),
    -> ("SI","XR5","001"),
    -> ("KIM","XR1","002"),
    -> ("KIM","XR2","002");

-- mengisi tabel nilai
insert into nilai values
    -> ("111","KIM","90"),
    -> ("112","KIM","60"),
    -> ("113","KIM","60"),
    -> ("114","KIM","75"),
    -> ("113","MTK","85"),
    -> ("114","MTK","70"),
    -> ("115","MTK","76"),
    -> ("118","MTK","80"),
    -> ("120","MTK","98"),
    -> ("111","MTK","76"),
    -> ("111","SI","90"),
    -> ("112","SI","75"),
    -> ("112","BIN","60"),
    -> ("111","BIN","70"),
    -> ("117","BIN","70");

-- case: menampilkan data kelas yang mengikuti mapel 'Kimia'
select kelas.kode_kelas, kelas.nama_kelas, mapel.nama_mapel
from kelas inner join kbm
on kelas.kode_kelas = kbm.kode_kelas
inner join mapel
on kbm.kode_mapel = mapel.kode_mapel
where mapel.nama_mapel="Kimia";

-- case: menampilkan data siswa yang dibawah kkm pada mapel 'matematika'
select siswa.nis, siswa.nama, mapel.nama_mapel, mapel.kkm, nilai.nilai
from siswa inner join nilai
on siswa.nis = nilai.nis
inner join mapel
on nilai.kode_mapel = mapel.kode_mapel
where nilai.nilai < mapel.kkm and mapel.nama_mapel = 'Matematika';


-- Fungsi Agregate:
-- sum -> menjumlahkan nilai pada suatu kolom
-- avg / average -> menghitung rata-rata nilai pada suatu kolom
-- count -> menghitung jumlah data / jumlah baris
-- max -> mengakses nilai maksimum dari suatu kolom
-- min -> mengakses nilai minimum dari suatu kolom

-- Fungsi Agregate itu akan melakukan perhitungan pada semua nilai / data
-- group by -> digunakan untuk mengelompokkan proses perhitungan dari Fungsi Agregate

-- case: menampilkan mapel beserta jumlah siswa yang nilainya dibawah kkm
-- dan nilai terendah dari masing-masing mapel
select mapel.kode_mapel, mapel.nama_mapel, count(nilai.nis) as jumlah
min(nilai.nilai) as terendah
from mapel inner join nilai
on mapel.kode_mapel = nilai.kode_mapel
where nilai.nilai < mapel.kkm
group by mapel.kode_mapel;

-- case: menampilkan data nilai dari 'Ana Putri'
select siswa.nama, mapel.nama_mapel, nilai.nilai
from siswa inner join nilai
on siswa.nis = nilai.nis
inner join mapel
on nilai.kode_mapel = mapel.kode_mapel
where siswa.nama = "Ana Putri";

-- case: menampilkan data siswa yang diajar oleh "Siti Kurniawati"
-- siswa - kelas - kbm - guru
select siswa.nis, siswa.nama, kelas.nama_kelas
from siswa inner join kelas
on siswa.kode_kelas = kelas.kode_kelas
inner join kbm
on kbm.kode_kelas = kelas.kode_kelas
inner join guru
on guru.id_guru = kbm.id_guru
where guru.nama_guru = "Siti Kurniawati";

-- case: menampilkan nilai rata-rata dari setiap mata pelajaran
select mapel.nama_mapel, avg(nilai.nilai) as nilai_rata_rata
from mapel inner join nilai
on mapel.kode_mapel = nilai.kode_mapel
group by mapel.kode_mapel;

select avg(harga) as rata_rata_penghasilan from penjualan
where stok > 50;

select harga as harga_barang from penjualan
where not like '%Buku%' and
harga > 2000 and
stok > 50;

