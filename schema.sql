-- ============================================================
-- Narıncgül Bijuteriya Mağazası İdarəetmə Sistemi
-- Milestone 3 - schema.sql (bütün CREATE TABLE əmrləri)
-- Verilənlər bazası: narincgul   |   DBMS: PostgreSQL
-- ============================================================
-- İstifadə qaydası: əvvəlcə 00_create_database.sql icra olunur,
-- sonra "narincgul" bazasına qoşulub bu fayl işə salınır.
-- ============================================================

-- Layihə üçün ayrıca schema (bonus: PostgreSQL Schema istifadəsi)
DROP SCHEMA IF EXISTS narincgul CASCADE;   -- yenidən qurmaq üçün
CREATE SCHEMA narincgul;
SET search_path TO narincgul, public;

-- ============================================================
-- 1. CƏDVƏLLƏR
-- Sıra: əvvəl asılılığı olmayan cədvəllər, sonra FK olanlar
-- ============================================================

-- 1.1 Kateqoriya
CREATE TABLE category (
    category_id    INTEGER GENERATED ALWAYS AS IDENTITY,
    category_name  VARCHAR(50)  NOT NULL,
    description    TEXT,
    CONSTRAINT pk_category PRIMARY KEY (category_id),
    CONSTRAINT uq_category_name UNIQUE (category_name)
);

-- 1.2 Müştəri
CREATE TABLE customer (
    customer_id   INTEGER GENERATED ALWAYS AS IDENTITY,
    first_name    VARCHAR(50)  NOT NULL,
    last_name     VARCHAR(50)  NOT NULL,
    email         VARCHAR(100) NOT NULL,
    phone_number  VARCHAR(20),
    address       VARCHAR(255),
    created_at    TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_customer PRIMARY KEY (customer_id),
    CONSTRAINT uq_customer_email UNIQUE (email),
    CONSTRAINT chk_customer_email CHECK (email ~* '^[^@[:space:]]+@[^@[:space:]]+\.[^@[:space:]]+$'),
    CONSTRAINT chk_customer_phone CHECK (phone_number IS NULL OR phone_number ~ '^[0-9+ ]{9,20}$')
);

-- 1.3 İşçi (administrator və satış işçisi)
CREATE TABLE employee (
    employee_id  INTEGER GENERATED ALWAYS AS IDENTITY,
    first_name   VARCHAR(50)  NOT NULL,
    last_name    VARCHAR(50)  NOT NULL,
    email        VARCHAR(100) NOT NULL,
    role         VARCHAR(20)  NOT NULL,
    hire_date    DATE         NOT NULL DEFAULT CURRENT_DATE,
    is_active    BOOLEAN      NOT NULL DEFAULT TRUE,   -- hesabı silmək əvəzinə deaktiv etmək üçün
    CONSTRAINT pk_employee PRIMARY KEY (employee_id),
    CONSTRAINT uq_employee_email UNIQUE (email),
    CONSTRAINT chk_employee_email CHECK (email ~* '^[^@[:space:]]+@[^@[:space:]]+\.[^@[:space:]]+$'),
    CONSTRAINT chk_employee_role CHECK (role IN ('Administrator', 'Satış işçisi'))
);

-- 1.4 Xəbər abunəçisi (digər cədvəllərdən müstəqildir)
CREATE TABLE newsletter_subscriber (
    subscriber_id  INTEGER GENERATED ALWAYS AS IDENTITY,
    email          VARCHAR(100) NOT NULL,
    subscribed_at  TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_subscriber PRIMARY KEY (subscriber_id),
    CONSTRAINT uq_subscriber_email UNIQUE (email),
    CONSTRAINT chk_subscriber_email CHECK (email ~* '^[^@[:space:]]+@[^@[:space:]]+\.[^@[:space:]]+$')
);

-- 1.5 Məhsul
CREATE TABLE product (
    product_id      INTEGER GENERATED ALWAYS AS IDENTITY,
    product_name    VARCHAR(100)  NOT NULL,
    description     TEXT,
    price           NUMERIC(10,2) NOT NULL,
    stock_quantity  INTEGER       NOT NULL DEFAULT 0,
    image_url       VARCHAR(255),
    category_id     INTEGER       NOT NULL,
    CONSTRAINT pk_product PRIMARY KEY (product_id),
    CONSTRAINT chk_product_price CHECK (price > 0),
    CONSTRAINT chk_product_stock CHECK (stock_quantity >= 0),
    CONSTRAINT fk_product_category FOREIGN KEY (category_id)
        REFERENCES category (category_id)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

-- 1.5.1 Sifariş
CREATE TABLE orders (
    order_id          INTEGER GENERATED ALWAYS AS IDENTITY,
    order_date        TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status            VARCHAR(20)   NOT NULL DEFAULT 'Yeni',
    total_amount      NUMERIC(10,2) NOT NULL DEFAULT 0,
    delivery_address  VARCHAR(255)  NOT NULL,
    customer_id       INTEGER       NOT NULL,
    employee_id       INTEGER,      -- sifarişi təsdiqləyən işçi (təsdiqlənənə qədər boşdur)
    CONSTRAINT pk_orders PRIMARY KEY (order_id),
    CONSTRAINT chk_orders_status CHECK (status IN ('Yeni', 'Təsdiqləndi', 'Göndərildi', 'Çatdırıldı', 'Ləğv edildi')),
    CONSTRAINT chk_orders_total CHECK (total_amount >= 0),
    CONSTRAINT fk_orders_customer FOREIGN KEY (customer_id)
        REFERENCES customer (customer_id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_orders_employee FOREIGN KEY (employee_id)
        REFERENCES employee (employee_id)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

-- 1.6 Sifariş sətri (Orders və Product arasında M:N əlaqəni həll edir)
CREATE TABLE order_item (
    order_item_id  INTEGER GENERATED ALWAYS AS IDENTITY,
    order_id       INTEGER       NOT NULL,
    product_id     INTEGER       NOT NULL,
    quantity       INTEGER       NOT NULL,
    unit_price     NUMERIC(10,2) NOT NULL,   -- sifariş anındakı qiymət
    CONSTRAINT pk_order_item PRIMARY KEY (order_item_id),
    CONSTRAINT uq_order_item_product UNIQUE (order_id, product_id),
    CONSTRAINT chk_order_item_qty CHECK (quantity > 0),
    CONSTRAINT chk_order_item_price CHECK (unit_price > 0),
    CONSTRAINT fk_order_item_order FOREIGN KEY (order_id)
        REFERENCES orders (order_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_order_item_product FOREIGN KEY (product_id)
        REFERENCES product (product_id)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

-- 1.7 Rəy
CREATE TABLE review (
    review_id    INTEGER GENERATED ALWAYS AS IDENTITY,
    rating       SMALLINT  NOT NULL,
    comment      TEXT,
    review_date  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    customer_id  INTEGER   NOT NULL,
    product_id   INTEGER   NOT NULL,
    CONSTRAINT pk_review PRIMARY KEY (review_id),
    CONSTRAINT chk_review_rating CHECK (rating BETWEEN 1 AND 5),
    CONSTRAINT fk_review_customer FOREIGN KEY (customer_id)
        REFERENCES customer (customer_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_review_product FOREIGN KEY (product_id)
        REFERENCES product (product_id)
        ON UPDATE CASCADE ON DELETE CASCADE
);

-- ============================================================
-- 2. İNDEKSLƏR (JOIN və axtarışı sürətləndirmək üçün)
-- ============================================================
CREATE INDEX idx_product_category   ON product (category_id);
CREATE INDEX idx_product_name       ON product (product_name);
CREATE INDEX idx_orders_customer    ON orders (customer_id);
CREATE INDEX idx_orders_status      ON orders (status);
CREATE INDEX idx_order_item_product ON order_item (product_id);
CREATE INDEX idx_review_product     ON review (product_id);

-- ============================================================
-- 3. TRIGGER-LƏR (bonus) - biznes qaydalarını avtomatik yoxlayır
-- ============================================================

-- 3.1 Sifariş sətri əlavə olunanda: qiyməti yaz, stoku yoxla (qayda 5, 8)
CREATE OR REPLACE FUNCTION fn_order_item_before_insert()
RETURNS TRIGGER AS $$
DECLARE
    v_stock   INTEGER;
    v_price   NUMERIC(10,2);
    v_status  VARCHAR(20);
BEGIN
    SELECT status INTO v_status FROM orders WHERE order_id = NEW.order_id;
    IF v_status IS DISTINCT FROM 'Yeni' THEN
        RAISE EXCEPTION 'Yalnız statusu "Yeni" olan sifarişə məhsul əlavə etmək olar (order_id=%)', NEW.order_id;
    END IF;

    SELECT stock_quantity, price INTO v_stock, v_price
    FROM product WHERE product_id = NEW.product_id;

    IF v_stock < NEW.quantity THEN
        RAISE EXCEPTION 'Stokda kifayət qədər məhsul yoxdur (product_id=%, stok=%, istənilən=%)',
                        NEW.product_id, v_stock, NEW.quantity;
    END IF;

    -- vahid qiymət göstərilməyibsə, sifariş anındakı məhsul qiyməti yazılır
    IF NEW.unit_price IS NULL THEN
        NEW.unit_price := v_price;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_order_item_before_insert
BEFORE INSERT ON order_item
FOR EACH ROW EXECUTE FUNCTION fn_order_item_before_insert();

-- 3.2 Sətir dəyişəndə sifarişin ümumi məbləğini yenidən hesabla (qayda 8)
CREATE OR REPLACE FUNCTION fn_order_total_recalc()
RETURNS TRIGGER AS $$
DECLARE
    v_order INTEGER;
BEGIN
    v_order := COALESCE(NEW.order_id, OLD.order_id);
    UPDATE orders
       SET total_amount = COALESCE((SELECT SUM(quantity * unit_price)
                                      FROM order_item
                                     WHERE order_id = v_order), 0)
     WHERE order_id = v_order;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_order_item_total
AFTER INSERT OR UPDATE OR DELETE ON order_item
FOR EACH ROW EXECUTE FUNCTION fn_order_total_recalc();

-- 3.3 Status dəyişəndə: ardıcıllığı yoxla, təsdiqdə stokdan çıx (qayda 9, 10)
CREATE OR REPLACE FUNCTION fn_order_status_change()
RETURNS TRIGGER AS $$
DECLARE
    r           RECORD;
    v_role      VARCHAR(20);
    v_active    BOOLEAN;
BEGIN
    IF NEW.status = OLD.status THEN
        RETURN NEW;
    END IF;

    -- Yeni -> Təsdiqləndi -> Göndərildi -> Çatdırıldı; istənilən mərhələdə Ləğv edildi
    IF NOT ( (OLD.status = 'Yeni'         AND NEW.status = 'Təsdiqləndi')
          OR (OLD.status = 'Təsdiqləndi' AND NEW.status = 'Göndərildi')
          OR (OLD.status = 'Göndərildi'  AND NEW.status = 'Çatdırıldı')
          OR (NEW.status = 'Ləğv edildi' AND OLD.status <> 'Ləğv edildi') ) THEN
        RAISE EXCEPTION 'Yanlış status keçidi: % -> %', OLD.status, NEW.status;
    END IF;

    IF NEW.status = 'Təsdiqləndi' THEN
        -- yalnız səlahiyyətli (aktiv satış işçisi) təsdiqləyə bilər
        SELECT role, is_active INTO v_role, v_active
        FROM employee WHERE employee_id = NEW.employee_id;
        IF v_role IS DISTINCT FROM 'Satış işçisi' OR v_active IS NOT TRUE THEN
            RAISE EXCEPTION 'Sifarişi yalnız aktiv satış işçisi təsdiqləyə bilər';
        END IF;

        IF NOT EXISTS (SELECT 1 FROM order_item WHERE order_id = NEW.order_id) THEN
            RAISE EXCEPTION 'Boş sifarişi təsdiqləmək olmaz (order_id=%)', NEW.order_id;
        END IF;

        -- miqdarı stokdan çıx
        FOR r IN SELECT product_id, quantity FROM order_item WHERE order_id = NEW.order_id LOOP
            UPDATE product
               SET stock_quantity = stock_quantity - r.quantity
             WHERE product_id = r.product_id
               AND stock_quantity >= r.quantity;
            IF NOT FOUND THEN
                RAISE EXCEPTION 'Stok çatmır, sifariş təsdiqlənmədi (product_id=%)', r.product_id;
            END IF;
        END LOOP;

    ELSIF NEW.status = 'Ləğv edildi'
          AND OLD.status IN ('Təsdiqləndi', 'Göndərildi', 'Çatdırıldı') THEN
        -- təsdiqdən sonra ləğv olunarsa, stok geri qaytarılır
        FOR r IN SELECT product_id, quantity FROM order_item WHERE order_id = NEW.order_id LOOP
            UPDATE product
               SET stock_quantity = stock_quantity + r.quantity
             WHERE product_id = r.product_id;
        END LOOP;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_order_status_change
BEFORE UPDATE OF status ON orders
FOR EACH ROW EXECUTE FUNCTION fn_order_status_change();

-- ============================================================
-- 4. VIEW-LAR (bonus)
-- ============================================================

-- 4.1 Aylıq satış hesabatı (ləğv olunmuş və hələ təsdiqlənməmiş sifarişlər sayılmır)
CREATE VIEW v_monthly_sales AS
SELECT TO_CHAR(order_date, 'YYYY-MM') AS month,
       COUNT(*)                       AS order_count,
       SUM(total_amount)              AS total_revenue
FROM orders
WHERE status IN ('Təsdiqləndi', 'Göndərildi', 'Çatdırıldı')
GROUP BY TO_CHAR(order_date, 'YYYY-MM')
ORDER BY month;

-- 4.2 Ən çox satılan məhsullar
CREATE VIEW v_top_products AS
SELECT p.product_id,
       p.product_name,
       c.category_name,
       SUM(oi.quantity) AS total_sold
FROM order_item oi
JOIN orders   o ON o.order_id    = oi.order_id
JOIN product  p ON p.product_id  = oi.product_id
JOIN category c ON c.category_id = p.category_id
WHERE o.status IN ('Təsdiqləndi', 'Göndərildi', 'Çatdırıldı')
GROUP BY p.product_id, p.product_name, c.category_name
ORDER BY total_sold DESC, p.product_name
LIMIT 10;

-- 4.3 Sifariş təfərrüatı (müştəri + məhsul + məbləğ bir yerdə)
CREATE VIEW v_order_details AS
SELECT o.order_id,
       o.order_date,
       o.status,
       c.first_name || ' ' || c.last_name AS customer_name,
       p.product_name,
       oi.quantity,
       oi.unit_price,
       oi.quantity * oi.unit_price        AS line_total
FROM orders o
JOIN customer   c  ON c.customer_id = o.customer_id
JOIN order_item oi ON oi.order_id   = o.order_id
JOIN product    p  ON p.product_id  = oi.product_id;
