-- Latihan

CREATE database dbpos;

USE dbpos;

CREATE TABLE kartu (
    id integer auto_increment primary key,
    kode varchar(4) unique,
    nama varchar(30) not null,
    diskon double default 0,
    iuran double default 0
);

CREATE TABLE pelanggan(
    id int auto_increment primary key,
    kode varchar(10) unique,
    nama varchar(45),
    jk char(1),
    tmp_lahir varchar(30),
    tgl_lahir date,
    email varchar(45),
    kartu_id int not null references kartu(id)
);

CREATE TABLE pesanan(
    id int not null auto_increment primary key,
    tanggal date,
    total double,
    pelanggan_id int not null references pelanggan(id)
);

CREATE TABLE pembayaran(
    id int not null auto_increment primary key,
    nokuitansi varchar(10) unique,
    tanggal date,
    jumlah double,
    ke int,
    pesanan_id int not null references pesanan(id)
);

CREATE TABLE jenis_produk(
    id int not null auto_increment primary key,
    nama varchar(45)
);

-- Tugas 1

CREATE TABLE produk(
    id int not null auto_increment primary key,
    kode varchar(10) unique,
    nama varchar(45),
    harga_beli double,
    harga_jual double,
    stok int,
    min_stok int,
    jenis_produk_id int not null references jenis_produk(id)
);

CREATE TABLE pesanan_items(
    id int not null auto_increment primary key,
    pesanan_id int not null references pesanan(id),
    produk_id int not null references produk(id),
    qty int,
    harga double
);

CREATE TABLE vendor(
    id int not null auto_increment primary key,
    nomor varchar(4) unique,
    nama varchar(40),
    kota varchar(30),
    kontak varchar(30)
);

CREATE TABLE pembelian(
    id int not null auto_increment primary key,
    tanggal varchar(45),
    nomor varchar(10),
    produk_id int not null references produk(id),
    jumlah int,
    harga double,
    vendor_id int not null references vendor(id)
);