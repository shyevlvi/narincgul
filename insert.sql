-- ============================================================
-- Narıncgül Bijuteriya Mağazası İdarəetmə Sistemi
-- Milestone 3 - insert.sql (test məlumatları)
-- Əvvəl schema.sql icra olunmalıdır (təmiz bazada, ID-lər 1-dən başlayır).
-- ============================================================
SET search_path TO narincgul, public;

-- 1. Kateqoriyalar (4 kateqoriya - Milestone 1, qayda 3)
INSERT INTO category (category_name, description) VALUES
('Sırğa',      'Müxtəlif model və materialdan sırğalar'),
('Üzük',       'Gündəlik və xüsusi günlər üçün üzüklər'),
('Qolbaq',     'Zəncirli, muncuqlu və hörmə qolbaqlar'),
('Boyunbağı',  'Kulonlu və zəncirli boyunbağılar');

-- 2. Müştərilər
INSERT INTO customer (first_name, last_name, email, phone_number, address, created_at) VALUES
('Leyla',   'Məmmədova',  'leyla.memmedova@gmail.com',  '050 111 22 33', 'Bakı, Nəsimi rayonu, 28 May küçəsi 14',     '2026-07-20 10:15'),
('Nigar',   'Həsənova',   'nigar.hasanova@mail.ru',     '055 222 33 44', 'Bakı, Yasamal rayonu, Şərifzadə küçəsi 7',  '2026-07-25 14:40'),
('Aysel',   'Quliyeva',   'aysel.quliyeva@gmail.com',   '070 333 44 55', 'Bakı, Binəqədi rayonu, Əhmədli 21',          '2026-08-02 09:05'),
('Səbinə',  'Əliyeva',    'sebine.aliyeva@gmail.com',   '077 444 55 66', 'Sumqayıt, 9-cu mikrorayon, ev 12',           '2026-08-15 18:30'),
('Günel',   'Rzayeva',    'gunel.rzayeva@yahoo.com',    '051 555 66 77', 'Bakı, Xətai rayonu, Əhməd Rəcəbli 33',       '2026-08-28 11:00'),
('Ülviyyə', 'Babayeva',   'ulviyye.babayeva@gmail.com', '050 666 77 88', 'Gəncə, Nizami küçəsi 45',                    '2026-09-05 16:20'),
('Fidan',   'Kərimova',   'fidan.kerimova@gmail.com',   '055 777 88 99', 'Bakı, Səbail rayonu, Neftçilər pr. 90',      '2026-09-20 13:45'),
('Nərmin',  'İsmayılova', 'nermin.ismayilova@mail.ru',  '070 888 99 00', 'Bakı, Nərimanov rayonu, Əhməd Cavad 5',      '2026-10-01 12:10'),
('Xəyalə',  'Səfərova',   'xeyale.seferova@gmail.com',  '077 123 45 67', 'Mingəçevir, Heydər Əliyev pr. 18',           '2026-10-08 15:25'),
('Rəna',    'Hüseynova',  'rena.huseynova@gmail.com',   '050 234 56 78', 'Bakı, Xəzər rayonu, Mərdəkan 11',            '2026-10-30 10:50'),
('Türkan',  'Nağıyeva',   'turkan.nagiyeva@yahoo.com',  '055 345 67 89', 'Lənkəran, Səməd Vurğun küçəsi 3',            '2026-11-06 17:35'),
('Kamilə',  'Vəliyeva',   'kamile.veliyeva@gmail.com',  '051 456 78 90', 'Bakı, Suraxanı rayonu, Qaraçuxur 27',        '2026-11-12 19:00');

-- 3. İşçilər (2 administrator, 8 satış işçisi; biri deaktivdir)
INSERT INTO employee (first_name, last_name, email, role, hire_date, is_active) VALUES
('Aytən',   'Hümmətova',  'ayten.hummetova@narincgul.az', 'Administrator', '2025-01-10', TRUE),
('Ülvi',    'Şirəliyev',  'ulvi.shiraliyev@narincgul.az', 'Administrator', '2025-01-10', TRUE),
('Mələk',   'Məmmədova',  'melek.memmedova@narincgul.az', 'Satış işçisi',  '2025-03-01', TRUE),
('Rasim',   'Xəlilov',    'rasim.xelilov@narincgul.az',   'Satış işçisi',  '2025-03-01', TRUE),
('Ayxan',   'Ağayev',     'ayxan.agayev@narincgul.az',    'Satış işçisi',  '2025-04-15', TRUE),
('Samirə',  'Cəfərova',   'samire.ceferova@narincgul.az', 'Satış işçisi',  '2025-06-01', TRUE),
('Elnur',   'Qasımov',    'elnur.qasimov@narincgul.az',   'Satış işçisi',  '2025-08-20', TRUE),
('Lalə',    'Orucova',    'lale.orucova@narincgul.az',    'Satış işçisi',  '2025-09-10', TRUE),
('Tural',   'Bayramov',   'tural.bayramov@narincgul.az',  'Satış işçisi',  '2026-01-12', TRUE),
('Vüsal',   'Mikayılov',  'vusal.mikayilov@narincgul.az', 'Satış işçisi',  '2025-02-01', FALSE);

-- 4. Məhsullar (hər kateqoriyada 5 məhsul)
INSERT INTO product (product_name, description, price, stock_quantity, image_url, category_id) VALUES
-- Sırğa (1)
('Mirvari Damla Sırğa',        'Süni mirvari damlalı sırğa',            18.90, 40, 'images/products/mirvari-damla-sirga.jpg',   1),
('Gümüş Halqa Sırğa',          'Gümüşü rəngli klassik halqa sırğa',      14.50, 60, 'images/products/gumus-halqa-sirga.jpg',     1),
('Qızılı Ulduz Sırğa',         'Kiçik ulduz formalı sırğa',              12.00, 35, 'images/products/qizili-ulduz-sirga.jpg',    1),
('Kristal Çiçək Sırğa',        'Çiçək formalı, kristal daşlı sırğa',     22.00, 25, 'images/products/kristal-cicek-sirga.jpg',   1),
('Uzun Zəncirli Sırğa',        'Zəncir formalı uzun sırğa',              16.50, 30, 'images/products/uzun-zencirli-sirga.jpg',   1),
-- Üzük (2)
('Zircon Daşlı Üzük',          'Parlaq zircon daşlı üzük',               19.90, 30, 'images/products/zircon-dasli-uzuk.jpg',     2),
('Qızılı Nazik Üzük',          'Gündəlik taxmaq üçün nazik üzük',        11.50, 50, 'images/products/qizili-nazik-uzuk.jpg',     2),
('Gümüş Hörmə Üzük',           'Hörmə naxışlı gümüşü üzük',              13.00, 45, 'images/products/gumus-horme-uzuk.jpg',      2),
('Firuzə Daşlı Üzük',          'Firuzəyi daşlı üzük',                    24.00, 20, 'images/products/firuze-dasli-uzuk.jpg',     2),
('Ayarlanan Kəpənək Üzük',     'Ölçüsü ayarlanan kəpənək formalı üzük',   9.90, 55, 'images/products/kepenek-uzuk.jpg',          2),
-- Qolbaq (3)
('Gümüş Zəncirli Qolbaq',      'İncə gümüşü zəncirli qolbaq',            17.00, 40, 'images/products/gumus-zencirli-qolbaq.jpg', 3),
('Mirvari Muncuq Qolbaq',      'Mirvari muncuqlardan qolbaq',            21.50, 28, 'images/products/mirvari-muncuq-qolbaq.jpg', 3),
('Qızılı Halqalı Qolbaq',      'Halqalardan ibarət qızılı qolbaq',       15.90, 33, 'images/products/qizili-halqali-qolbaq.jpg', 3),
('Dərili Hörmə Qolbaq',        'Dəri hörmə qolbaq, metal qapaqlı',       12.50, 38, 'images/products/derili-horme-qolbaq.jpg',   3),
('Çiçəkli Charm Qolbaq',       'Çiçək charm-lı qolbaq (stokda yoxdur)',  23.00,  0, 'images/products/cicekli-charm-qolbaq.jpg',  3),
-- Boyunbağı (4)
('Mirvari Uzun Boyunbağı',     'Uzun mirvari boyunbağı',                 34.00, 15, 'images/products/mirvari-uzun-boyunbagi.jpg',4),
('Qızılı Ürək Kulonlu Boyunbağı','Ürək kulonlu nazik boyunbağı',         18.50, 42, 'images/products/urek-kulonlu-boyunbagi.jpg',4),
('Gümüş Ay Kulonlu Boyunbağı', 'Ay formalı kulonlu boyunbağı',           20.00, 36, 'images/products/ay-kulonlu-boyunbagi.jpg',  4),
('Kristal Damla Boyunbağı',    'Kristal damla kulonlu boyunbağı',        27.50, 18, 'images/products/kristal-damla-boyunbagi.jpg',4),
('Nazik Zəncirli Boyunbağı',   'Gündəlik nazik zəncirli boyunbağı',      13.90, 48, 'images/products/nazik-zencirli-boyunbagi.jpg',4);

-- 5. Sifarişlər (hamısı "Yeni" statusu ilə yaradılır, status sonra dəyişdirilir)
INSERT INTO orders (order_date, delivery_address, customer_id) VALUES
('2026-08-05 11:20', 'Bakı, Nəsimi rayonu, 28 May küçəsi 14',     1),   -- 1
('2026-08-12 15:05', 'Bakı, Yasamal rayonu, Şərifzadə küçəsi 7',  2),   -- 2
('2026-08-20 12:30', 'Bakı, Binəqədi rayonu, Əhmədli 21',          3),   -- 3
('2026-09-02 17:45', 'Sumqayıt, 9-cu mikrorayon, ev 12',           4),   -- 4
('2026-09-10 10:10', 'Bakı, Xətai rayonu, Əhməd Rəcəbli 33',       5),   -- 5
('2026-09-18 14:55', 'Bakı, Nəsimi rayonu, 28 May küçəsi 14',     1),   -- 6
('2026-09-25 19:15', 'Gəncə, Nizami küçəsi 45',                    6),   -- 7
('2026-10-03 13:00', 'Bakı, Səbail rayonu, Neftçilər pr. 90',      7),   -- 8
('2026-10-11 16:40', 'Bakı, Nərimanov rayonu, Əhməd Cavad 5',      8),   -- 9
('2026-10-19 11:35', 'Mingəçevir, Heydər Əliyev pr. 18',           9),   -- 10
('2026-10-27 18:20', 'Bakı, Yasamal rayonu, Şərifzadə küçəsi 7',  2),   -- 11
('2026-11-04 12:50', 'Bakı, Xəzər rayonu, Mərdəkan 11',            10),  -- 12
('2026-11-10 15:30', 'Lənkəran, Səməd Vurğun küçəsi 3',            11),  -- 13
('2026-11-14 20:10', 'Bakı, Suraxanı rayonu, Qaraçuxur 27',        12),  -- 14
('2026-11-17 09:45', 'Bakı, Binəqədi rayonu, Əhmədli 21',          3);   -- 15

-- 6. Sifariş sətirləri (unit_price verilmir - trigger məhsulun cari qiymətini yazır,
--    sifarişin total_amount-u da trigger ilə avtomatik hesablanır)
INSERT INTO order_item (order_id, product_id, quantity) VALUES
(1, 1, 1),  (1, 7, 1),
(2, 3, 2),  (2, 14, 1),
(3, 6, 1),  (3, 18, 1), (3, 2, 1),
(4, 11, 1),
(5, 16, 1), (5, 12, 1),
(6, 17, 1), (6, 10, 2),
(7, 4, 1),  (7, 13, 1),
(8, 20, 2), (8, 9, 1),
(9, 5, 1),  (9, 8, 1),
(10, 19, 1),(10, 1, 1),
(11, 7, 2), (11, 18, 1),
(12, 2, 1), (12, 12, 1),
(13, 14, 2),(13, 3, 1),
(14, 9, 1),
(15, 17, 1),(15, 20, 1);

-- 7. Status dəyişiklikləri (satış işçisi təsdiqləyir; trigger stoku azaldır)
-- Təsdiqləndi
UPDATE orders SET employee_id = 3, status = 'Təsdiqləndi' WHERE order_id IN (1, 2, 6);
UPDATE orders SET employee_id = 4, status = 'Təsdiqləndi' WHERE order_id IN (3, 4, 8, 15);
UPDATE orders SET employee_id = 5, status = 'Təsdiqləndi' WHERE order_id IN (5, 7, 10);
UPDATE orders SET employee_id = 6, status = 'Təsdiqləndi' WHERE order_id IN (9, 11);
-- Göndərildi
UPDATE orders SET status = 'Göndərildi' WHERE order_id BETWEEN 1 AND 9;
-- Çatdırıldı
UPDATE orders SET status = 'Çatdırıldı' WHERE order_id BETWEEN 1 AND 7;
-- Ləğv edildi (14: təsdiqdən əvvəl, 15: təsdiqdən sonra - stok geri qayıdır)
UPDATE orders SET status = 'Ləğv edildi' WHERE order_id IN (14, 15);

-- 8. Rəylər
INSERT INTO review (rating, comment, review_date, customer_id, product_id) VALUES
(5, 'Çox zərif sırğadır, mirvarisi real kimi görünür.',      '2026-08-14 10:00', 1, 1),
(4, 'Üzük yaxşıdır, nazik və yüngüldür.',                    '2026-08-14 10:05', 1, 7),
(5, 'Boyunbağı şəkildəkindən də gözəldir.',                  '2026-09-25 18:20', 1, 17),
(4, 'Ulduz sırğalar balaca, amma çox sevimlidir.',           '2026-08-22 12:00', 2, 3),
(3, 'Qolbaq yaxşıdır, qapağı bir az sərtdir.',               '2026-08-22 12:10', 2, 14),
(5, 'Zircon daşı çox parlaqdır, hədiyyə üçün aldım.',        '2026-08-28 09:30', 3, 6),
(5, 'Ay kulonlu boyunbağı gündəlik taxmaq üçün idealdır.',   '2026-08-28 09:40', 3, 18),
(4, 'Halqa sırğalar rahatdır, yük salmır.',                  '2026-08-28 09:45', 3, 2),
(4, 'Qolbaq nazik və gözəldir.',                             '2026-09-10 16:00', 4, 11),
(5, 'Uzun mirvari boyunbağı paltarla çox yaraşır.',          '2026-09-20 11:15', 5, 16),
(4, 'Muncuq qolbaq rahatdır, rəngi dəyişmir.',               '2026-09-20 11:20', 5, 12),
(5, 'Kristal çiçək sırğa çox gözəl göründü.',                '2026-10-03 19:00', 6, 4),
(3, 'Qolbaq şəkildəki kimidir, amma bir az kiçikdir.',       '2026-10-03 19:05', 6, 13),
(4, 'Kəpənək üzük ölçüyə uyğun ayarlanır.',                  '2026-09-28 13:00', 1, 10);

-- 9. Xəbər abunəçiləri
INSERT INTO newsletter_subscriber (email, subscribed_at) VALUES
('leyla.memmedova@gmail.com',  '2026-07-20 10:20'),
('nigar.hasanova@mail.ru',     '2026-07-25 14:45'),
('aysel.quliyeva@gmail.com',   '2026-08-02 09:10'),
('gunel.rzayeva@yahoo.com',    '2026-08-28 11:05'),
('fidan.kerimova@gmail.com',   '2026-09-20 13:50'),
('nermin.ismayilova@mail.ru',  '2026-10-01 12:15'),
('aynur.abbasova@gmail.com',   '2026-10-05 20:00'),
('lale.hasanli@gmail.com',     '2026-10-12 08:30'),
('turkan.nagiyeva@yahoo.com',  '2026-11-06 17:40'),
('sevil.mustafayeva@mail.ru',  '2026-11-09 21:10'),
('kamile.veliyeva@gmail.com',  '2026-11-12 19:05'),
('gulnar.ahmadova@gmail.com',  '2026-11-15 10:25');
