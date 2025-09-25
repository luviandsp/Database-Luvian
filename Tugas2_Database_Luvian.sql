-- Worksheet 2
-- Soal 2.3 (2-6)

-- 2. Tampilkan produk yang kode awalnya bukan huruf M.
SELECT * FROM produk WHERE kode NOT LIKE 'M%';

-- 3. Tampilkan produk-produk televisi.
SELECT * FROM produk WHERE kode LIKE 'TV%';

-- 4. Tampilkan pelanggan mengandung huruf 'SA'.
SELECT * FROM pelanggan WHERE nama LIKE '%SA%';

-- 5. Tampilkan pelanggan yang lahirnya bukan di Jakarta dan mengandung huruf ‘yo‘.
SELECT * FROM pelanggan WHERE tmp_lahir!='Jakarta' AND nama LIKE '%yo%';

-- 6. Tampilkan pelanggan yang karakter huruf ke – 2 nya adalah A
SELECT * FROM pelanggan WHERE nama LIKE '_A%';

-- Soal 2.4 (2-6)
-- 2. Tampilkan produk yang paling murah
SELECT MIN(harga_jual) AS harga_produk_termurah FROM produk;

-- 3. Tampilkan produk yang stoknya paling banyak
SELECT MAX(stok) AS stok_produk_terbanyak FROM produk;

-- 4. Tampilkan dua produk yang stoknya paling sedikit
SELECT * FROM produk ORDER BY stok ASC LIMIT 2;

-- 5. Tampilkan pelanggan yang paling muda
SELECT * FROM pelanggan ORDER BY tgl_lahir DESC LIMIT 1;

-- 6. Tampilkan pelanggan yang paling tua
SELECT * FROM pelanggan ORDER BY tgl_lahir ASC LIMIT 1;

-- Worksheet 3
-- Soal 3.3 (3)

-- 3. Tampilkan data produk: id, kode, nama, dan bonus untuk kode ‘TV01’ →’DVD Player’ , ‘K001’ → ‘Rice Cooker’ selain dari diatas ‘Tidak Ada’
SELECT id, kode, nama, 
CASE 
    WHEN kode='TV01' THEN 'DVD Player'
    WHEN kode='K001' THEN 'Rice Cooker'
    ELSE 'Tidak Ada'
END AS bonus
FROM produk;

-- Soal 3.4 (6 dan 7)

-- 6. Tampilkan statistik data produk dimana harga produknya dibawah rata-rata harga produk secara keseluruhan
SELECT kode, nama, harga_jual FROM produk WHERE harga_jual < (SELECT AVG(harga_jual) FROM produk);

-- 7. Tampilkan data pelanggan yang memiliki kartu dimana diskon kartu yang diberikan diatas 3%
SELECT pelanggan.id, pelanggan.nama, kartu.nama, kartu.diskon FROM pelanggan JOIN kartu ON (pelanggan.kartu_id = kartu.id) WHERE kartu.diskon > 0.03;