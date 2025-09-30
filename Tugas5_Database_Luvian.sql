-- Worksheet 6
-- Soal 1
DELIMITER $$

CREATE PROCEDURE pro_naik(IN jenis_produk INT, IN persentasi_kenaikan INT)
BEGIN
    UPDATE produk 
    SET harga_jual = harga_jual + (harga_jual * persentasi_kenaikan / 100) 
    WHERE jenis_produk_id = jenis_produk;
END $$

DELIMITER ;

CALL pro_naik(1, 4);

-- Soal 2
DELIMITER $$

CREATE FUNCTION umur(tgl_lahir DATE)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE umur INT;
    SET umur = YEAR(CURDATE()) - YEAR(tgl_lahir);
    RETURN umur;
END $$

DELIMITER ;

-- Soal 3
DELIMITER $$

CREATE FUNCTION kategori_harga(harga DOUBLE)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    RETURN CASE
        WHEN harga > 0 AND harga <= 500000 THEN 'Murah'
        WHEN harga > 500000 AND harga <= 3000000 THEN 'Sedang'
        WHEN harga > 3000000 AND harga <= 10000000 THEN 'Mahal'
        WHEN harga > 10000000 THEN 'Sangat Mahal'
        ELSE 'Tidak Valid'
    END;
END $$

DELIMITER ;

SELECT kode, nama, harga_jual, kategori_harga(harga_jual) FROM produk;

-- Worksheet 7
-- Soal 1
SELECT * FROM pesanan;

ALTER TABLE pembayaran ADD status_pembayaran VARCHAR(25);

DELIMITER $$

CREATE TRIGGER cek_pembayaran BEFORE INSERT ON pembayaran
FOR EACH ROW
BEGIN
    DECLARE total_bayar DECIMAL(10, 2);
    DECLARE total_pesanan DECIMAL(10, 2);

    SELECT COALESCE(SUM(jumlah), 0) INTO total_bayar FROM pembayaran WHERE pesanan_id = NEW.pesanan_id;
    SELECT total INTO total_pesanan FROM pesanan WHERE id = NEW.pesanan_id;

    IF total_bayar + NEW.jumlah >= total_pesanan THEN
        SET NEW.status_pembayaran = 'Lunas';
    ELSE
        SET NEW.status_pembayaran = 'Cicilan';
    END IF;
END $$

DELIMITER ;

INSERT INTO pembayaran (nokuitansi, tanggal, jumlah, ke, pesanan_id) VALUES ('KWI001', '2023-03-03', 200000, 1, 1);

-- Soal 2
DELIMITER $$

CREATE PROCEDURE kurangi_stok(IN jumlah_pesanan INT, IN id_produk INT)
BEGIN
    UPDATE produk
    SET stok = stok - jumlah_pesanan
    WHERE id = id_produk;
END $$

DELIMITER ;

CALL kurangi_stok(3, 7);

-- Soal 3
DELIMITER $$

CREATE TRIGGER trig_kurangi_stok
AFTER INSERT ON pesanan_items
FOR EACH ROW
BEGIN
    CALL kurangi_stok(NEW.qty, NEW.produk_id);
END $$

DELIMITER ;

INSERT INTO pesanan_items (produk_id, pesanan_id, qty, harga) VALUES (7, 3, 10, 500000);