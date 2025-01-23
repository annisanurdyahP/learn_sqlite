CREATE TABLE IF NOT EXISTS users (
    user_id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT NOT NULL UNIQUE,
    email TEXT NOT NULL UNIQUE,
    password TEXT NOT NULL,
    full_name TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Membuat tabel untuk kategori kursus (course_categories)
CREATE TABLE IF NOT EXISTS course_categories (
  category_id INTEGER PRIMARY KEY AUTOINCREMENT,
  category_name TEXT NOT NULL UNIQUE,
  description TEXT
  );

-- Membuat tabel untuk kursus (courses)
CREATE TABLE IF NOT EXISTS courses (
  course_id INTEGER PRIMARY KEY AUTOINCREMENT,
  course_name TEXT NOT NULL,
  description TEXT,
  category_id INTEGER,
  price REAL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (category_id) REFERENCES course_categories(category_id)
  );

  CREATE TABLE IF NOT EXISTS purchases (
    purchase_id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER,
    course_id INTEGER,
    purchase_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    total_price REAL,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- Membuat tabel untuk transaksi pembayaran (payments)
CREATE TABLE IF NOT EXISTS payments (
    payment_id INTEGER PRIMARY KEY AUTOINCREMENT,
    purchase_id INTEGER,
    payment_method TEXT,
    payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    amount REAL,
    status TEXT CHECK(status IN ('pending', 'completed', 'failed')) DEFAULT 'pending',
    FOREIGN KEY (purchase_id) REFERENCES purchases(purchase_id)
);

-- Menambahkan lebih banyak data pengguna
INSERT INTO users (username, email, password, full_name) VALUES
('alice', 'alice@example.com', 'hashed_password', 'Alice Wonderland'),
('bob', 'bob@example.com', 'hashed_password', 'Bob Marley'),
('charlie', 'charlie@example.com', 'hashed_password', 'Charlie Brown'),
('david', 'david@example.com', 'hashed_password', 'David Beckham'),
('emma', 'emma@example.com', 'hashed_password', 'Emma Watson'),
('frank', 'frank@example.com', 'hashed_password', 'Frank Ocean'),
('grace', 'grace@example.com', 'hashed_password', 'Grace Hopper'),
('harry', 'harry@example.com', 'hashed_password', 'Harry Potter'),
('ivy', 'ivy@example.com', 'hashed_password', 'Ivy League'),
('jack', 'jack@example.com', 'hashed_password', 'Jack Sparrow');

-- Menambahkan lebih banyak kategori kursus
INSERT INTO course_categories (category_name, description) VALUES
('Business', 'Courses related to entrepreneurship and business strategies'),
('Marketing', 'Courses related to marketing and advertising techniques'),
('Health & Wellness', 'Courses related to fitness and mental health');

-- Menambahkan lebih banyak kursus
INSERT INTO courses (course_name, description, category_id, price) VALUES
('Entrepreneurship 101', 'Learn how to start your own business', 4, 149.99),
('Digital Marketing', 'Master the art of online marketing', 5, 199.99),
('Yoga for Beginners', 'A guide to starting your yoga journey', 6, 59.99),
('Advanced Python', 'Deep dive into Python for data science and AI', 2, 199.99),
('ReactJS Essentials', 'Learn to build web apps with ReactJS', 1, 149.99),
('Adobe Photoshop Basics', 'Learn to edit photos like a pro', 3, 79.99);

-- Menambahkan lebih banyak pembelian
INSERT INTO purchases (user_id, course_id, total_price) VALUES
(1, 3, 89.99),
(2, 6, 59.99),
(3, 4, 129.99),
(4, 8, 149.99),
(5, 7, 149.99),
(6, 9, 79.99),
(7, 10, 149.99),
(8, 1, 99.99),
(9, 5, 199.99),
(10, 2, 129.99);

-- nambahin user_id = 3 untuk beli course lain
INSERT INTO purchases (user_id, course_id, total_price) VALUES
(3, 7, 149.99),
(3, 1, 99.99),
(1, 4, 129.99),
(1, 2, 129.99),
(3, 5, 199.99),
(7, 2, 129.99);



-- Menambahkan lebih banyak transaksi pembayaran
INSERT INTO payments (purchase_id, payment_method, amount, status) VALUES
(3, 'Credit Card', 89.99, 'completed'),
(4, 'PayPal', 59.99, 'completed'),
(5, 'Bank Transfer', 129.99, 'pending'),
(6, 'Credit Card', 149.99, 'completed'),
(7, 'PayPal', 149.99, 'completed'),
(8, 'Bank Transfer', 79.99, 'completed'),
(9, 'Credit Card', 149.99, 'completed'),
(10, 'PayPal', 99.99, 'failed'),
(11, 'Bank Transfer', 199.99, 'completed'),
(12, 'Credit Card', 129.99, 'completed');


SELECT * from users;
SELECT * from users where user_id = 1;
SELECT * FROM users WHERE username LIKE '%e%';

--ambil kolom tertentu--
SELECT username, full_name FROM users;

-- Ambil pengguna yang dibuat setelah tanggal tertentu
SELECT * from users where created_at > '2024-01-01';
SELECT username, full_name, created_at from users where created_at > '2024-01-01';

-- ambil pengguna dengan 2 kondisi--
SELECT * FROM users WHERE username = 'david' AND email LIKE '%example.com';
SELECT * from users WHERE username = 'alice' and email LIKE '%exam%';
SELECT username, full_name from users where username = 'alice' and email like '%exam%';

-- ambil pengguna yang dibuat sebelum tahun 2024/ memiliki email domain tertentu--
SELECT * from users WHERE created_at < '2024-01-01' OR email LIKE '%example.com';

--ambil semua pengguna kecuali yang memiliki username 'bob'--
SELECT * FROM users WHERE NOT username = 'bob';

-- pencarian dengan like
SELECT * from users WHERE username LIKE '%ice%';

-- ambil pengguna dengan username yang diawali huruf 'a'
SELECT * FROM users where username like 'a%';

--ambil pengguna dengan username di akhiri huruf "e"
SELECT * FROM users where username like '%e';

-- ambil pengguna dengan username yang memiliki panjang 5 karakter
SELECT * from users WHERE username LIKE '_____';

-- BETWEEEN --
-- ambil semua kursus dengan harga antara 50 hingag 150
SELECT * FROM courses WHERE price BETWEEN 50 AND 150;
SELECT * FROM courses where price BETWEEN 20 AND 50; --kosong
select * from courses WHERE price between 79 AND 150;
SELECT * from courses;
select * from users;

-- ambil pengguna yang dibuat anteara dua tanggal tertentu
select * from users where created_at BETWEEN '2024-01-01' AND '2024-12-31';
select * from users where created_at BETWEEN '2025-01-01' AND '2025-01-31';

--IN --
--ambil pengguna dengan username tertentu
SELECT * from courses where category_id IN (1,2,3);
select * from users where username IN ('alice','bob');

--EXPERT query---
-- MEMPELAJARI RELASI ANTARA TABEL--
-- 1. ONE TO ONE :Satu baris di tabel pertama berhubungan dengan satu baris di tabel kedua.
-- One-to-One antara users dan user_profiles, di mana setiap pengguna hanya memiliki satu profil,
-- dan setiap profil hanya dimiliki oleh satu pengguna.
SELECT u.username, up.bio from users u JOIN usersprofile up ON u.user_id = up.user_id;

-- 2. One-to-Many: Satu baris di tabel pertama berhubungan dengan banyak baris di tabel kedua.
-- course_categories dan courses
-- Untuk mendapatkan semua kursus beserta kategori mereka:
SELECT c.course_name, c.description AS course_description, cc.category_name
FROM courses c
JOIN course_categories cc ON c.category_id = cc.category_id;

SELECT * FROM courses;
SELECT * from course_categories;

--nambahin courses_category karena kurang 3 kategori
INSERT INTO course_categories (category_name, description)
VALUES
('Career Development', 'Learn how to interview'),
('Finance & Accounting', 'learn how to manage money in your company'),
('Personal Development', 'Understand about mindfullness,time management, etc');

-- hanya mengambil courses yang "Business" saja


-- 3. Many-to-Many: Banyak baris di tabel pertama berhubungan dengan banyak baris di tabel kedua, sering diimplementasikan dengan tabel penghubung.
-- users dan courses (Melalui purchases)
--Seorang pengguna (users) bisa membeli banyak kursus (courses),
-- dan sebuah kursus bisa dibeli oleh banyak pengguna.
-- Relasi ini menggunakan tabel penghubung purchases.
SELECT * FROM users;
SELECT * FROM courses;
select * from purchases;

SELECT u.username, c.course_name, p.total_price
from users u
JOIN purchases p ON u.user_id = p.user_id
JOIN courses c ON p.course_id = c.course_id
WHERE u.user_id = 1; -- misalnya untuk user dengan user_id = 1

SELECT u.username, c.course_name, p.total_price
from users u
JOIN purchases p ON u.user_id = p.user_id
JOIn courses c ON p.course_id = c.course_id
WHERE u.user_id = 7; -- course_id cuma ada 6 course, jadi kalau user ini course_id nya 10, datanya ga akan muncul.

-- 4. one to many : Setiap pembelian (purchases) dapat memiliki banyak pembayaran
-- (payments), tetapi setiap pembayaran hanya terkait dengan satu pembelian.
-- purchases dan payments
-- purchases memiliki relasi one-to-many dengan payments melalui purchase_id.
-- Untuk mendapatkan informasi pembayaran untuk pembelian tertentu:
SELECT * from payments;
SELECT * from purchases;

SELECT p.payment_method, p.payment_date, p.amount, p.status
FROM payments p
JOIN purchases pu ON p.purchase_id = pu.purchase_id
WHERE pu.purchase_id = 1;  -- Misalnya, untuk purchase_id = 1

-- melihat semua pembelian pengguna dan pembayaran pengguna
SELECT * FROM users WHERE user_id = 2;
SELECT * FROM purchases WHERE user_id = 2;
SELECT * FROM payments WHERE purchase_id IN (SELECT purchase_id FROM purchases WHERE user_id = 2);


SELECT u.username, c.course_name, p.total_price, py.payment_method, py.payment_date, py.status
FROM users u
JOIN purchases p ON u.user_id = p.user_id
JOIN courses c ON p.course_id = c.course_id
JOIN payments py ON p.purchase_id = py.purchase_id
WHERE u.user_id = 2; --misalnya untuk user dengan user_id = 1

