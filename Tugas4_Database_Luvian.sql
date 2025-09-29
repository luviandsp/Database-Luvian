-- Worksheet 5
-- Soal 5.1

-- Soal 1
CREATE VIEW pesanan_pelanggan_kartu AS
SELECT
    pesanan.id,
    pesanan.tanggal,
    pesanan.total,
    pelanggan.kode,
    pelanggan.nama,
    kartu.nama AS nama_kartu,
    kartu.diskon
FROM
    pesanan
INNER JOIN
    pelanggan ON pesanan.pelanggan_id = pelanggan.id
INNER JOIN
    kartu ON pelanggan.kartu_id = kartu.id;

SELECT * FROM pesanan_pelanggan_kartu;

-- Soal 2
CREATE VIEW pembelian_produk_vendor AS
SELECT
    pembelian.id,
    pembelian.tanggal,
    pembelian.nomor,
    pembelian.jumlah,
    pembelian.harga,
    produk.nama AS nama_produk,
    vendor.nama AS nama_vendor,
    vendor.kontak
FROM
    pembelian 
INNER JOIN
    produk ON pembelian.produk_id = produk.id
INNER JOIN
    vendor ON pembelian.vendor_id = vendor.id;

SELECT * FROM pembelian_produk_vendor;

-- Soal 3
CREATE VIEW detail_pesanan_pelanggan AS
SELECT
    pesanan.id,
    pesanan.tanggal,
    pesanan.total,
    pelanggan.nama AS nama_pelanggan,
    produk.kode AS kode_produk,
    produk.nama AS nama_produk,
    jenis_produk.nama AS jenis_produk,
    pesanan_items.qty,
    pesanan_items.harga AS harga_jual
FROM
    pesanan
INNER JOIN
    pelanggan ON pesanan.pelanggan_id = pelanggan.id
INNER JOIN
    pesanan_items ON pesanan_items.pesanan_id = pesanan.id
INNER JOIN
    produk ON pesanan_items.produk_id = produk.id
INNER JOIN
    jenis_produk ON produk.jenis_produk_id = jenis_produk.id;

SELECT * FROM detail_pesanan_pelanggan;

-- Soal 5.2
-- Soal 1

START TRANSACTION;

INSERT INTO
    produk (kode, nama, harga_jual, harga_beli, stok, min_stok, jenis_produk_id)
VALUES
    ('L005', 'Laptop ASUS', 15000000, 12000000, 12, 4, 5),
    ('L006', 'Laptop Dell', 12500000, 11000000, 15, 5, 5);

UPDATE produk SET stok = 40 WHERE kode = 'LN01';

SAVEPOINT sebelum_hapus_pembayaran;

DELETE FROM pembayaran WHERE id = 5;

ROLLBACK TO SAVEPOINT sebelum_hapus_pembayaran;

UPDATE kartu SET iuran = 50000 WHERE id = 2;

COMMIT;