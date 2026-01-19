-- 1. Таблица клиентов
CREATE TABLE clients (
    client_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100),
    registracia_data DATE
);

-- 2. Таблица мастеров
CREATE TABLE masteri (
    rabotnik_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    doljnost VARCHAR(50),
    zarplata DECIMAL(10,2),
    hire_date DATE
);

-- 3. Таблица услуг
CREATE TABLE services (
    service_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    opisanie TEXT,
    price DECIMAL(8,2) NOT NULL,
    duration_seansa INT  -- в минутах
);

-- 4. Таблица записей на приём
CREATE TABLE zapisi (
    zapisi_id SERIAL PRIMARY KEY,
    client_id INT NOT NULL,
    rabotnik_id INT NOT NULL,
    service_id INT NOT NULL,
    vremya TIMESTAMP NOT NULL,
    status VARCHAR(20) DEFAULT 'запланировано',
    FOREIGN KEY (client_id) REFERENCES clients(client_id) ON DELETE CASCADE,
    FOREIGN KEY (rabotnik_id) REFERENCES masteri(rabotnik_id) ON DELETE RESTRICT,
    FOREIGN KEY (service_id) REFERENCES services(service_id) ON DELETE RESTRICT
);

-- 5. Таблица косметики / товаров
CREATE TABLE kosmetika (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    brand VARCHAR(50),
    price DECIMAL(8,2) NOT NULL,
    kolichestvo INT DEFAULT 0  -- остаток на складе
);

-- 6. Таблица продаж
CREATE TABLE sales (
    sales_id SERIAL PRIMARY KEY,
    client_id INT NOT NULL,
    product_id INT NOT NULL,
    vremya TIMESTAMP NOT NULL,
    kolichestvo INT NOT NULL CHECK (kolichestvo > 0),
    summa DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (client_id) REFERENCES clients(client_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES kosmetika(product_id) ON DELETE RESTRICT
);

-- 7. Таблица отзывов
CREATE TABLE feedback (
    otziv_id SERIAL PRIMARY KEY,
    client_id INT NOT NULL,
    zapisi_id INT NOT NULL UNIQUE,  -- обеспечивает связь 1:1 с записью
    comment TEXT,
    rating INT CHECK (rating >= 1 AND rating <= 5),
    otziv_date DATE,
    FOREIGN KEY (client_id) REFERENCES clients(client_id) ON DELETE CASCADE,
    FOREIGN KEY (zapisi_id) REFERENCES zapisi(zapisi_id) ON DELETE CASCADE
);

INSERT INTO clients VALUES (1, 'Анна Кузнецов', '+79684590831', 'аннакузнецов@bk.ru', '2025-03-29');
INSERT INTO clients VALUES (2, 'Алексей Петрова', '+72424900347', 'алексейпетрова@yandex.ru', '2025-12-16');
INSERT INTO clients VALUES (3, 'Николай Попов', '+74640318663', 'николайпопов@gmail.com', '2025-04-10');
INSERT INTO clients VALUES (4, 'Алексей Петрова', '+78946061860', 'алексейпетрова@mail.ru', '2025-03-17');
INSERT INTO clients VALUES (5, 'Татьяна Попов', '+77639334101', 'татьянапопов@gmail.com', '2025-06-04');
INSERT INTO clients VALUES (6, 'Мария Морозов', '+73299891606', 'марияморозов@bk.ru', '2025-11-11');

INSERT INTO masteri VALUES (1, 'Мария Федорова', 'Массажист', 58043.81, '2026-01-05');
INSERT INTO masteri VALUES (2, 'Дмитрий Петрова', 'Парикмахер', 31272.93, '2025-10-18');
INSERT INTO masteri VALUES (3, 'Татьяна Иванова', 'Массажист', 43359.38, '2025-04-22');
INSERT INTO masteri VALUES (4, 'Анна Смирнов', 'Парикмахер', 97829.64, '2024-04-27');
INSERT INTO masteri VALUES (5, 'Ольга Сидорова', 'Парикмахер', 83209.10, '2025-05-22');

INSERT INTO services VALUES (1, 'Эпиляция', 'Профессиональная эпиляция в салоне красоты', 3405.71, 38);
INSERT INTO services VALUES (2, 'Маникюр', 'Профессиональная маникюр в салоне красоты', 1287.78, 76);
INSERT INTO services VALUES (3, 'Педикюр', 'Профессиональная педикюр в салоне красоты', 4727.92, 34);
INSERT INTO services VALUES (4, 'Стрижка', 'Профессиональная стрижка в салоне красоты', 3307.84, 32);
INSERT INTO services VALUES (5, 'Укладка', 'Профессиональная укладка в салоне красоты', 4139.78, 48);
INSERT INTO services VALUES (6, 'Чистка лица', 'Профессиональная чистка лица в салоне красоты', 2515.55, 51);

INSERT INTO zapisi VALUES (1, 1, 3, 3, '2026-01-17 07:05:39', 'запланировано');
INSERT INTO zapisi VALUES (2, 3, 2, 5, '2026-01-16 05:05:39', 'выполнено');
INSERT INTO zapisi VALUES (3, 5, 3, 5, '2026-01-02 04:35:39', 'выполнено');
INSERT INTO zapisi VALUES (4, 5, 3, 2, '2026-01-19 07:05:39', 'отменено');
INSERT INTO zapisi VALUES (5, 6, 3, 3, '2026-01-04 01:50:39', 'отменено');
INSERT INTO zapisi VALUES (6, 3, 5, 6, '2026-01-10 06:35:39', 'запланировано');

INSERT INTO kosmetika VALUES (1, 'Vichy Бальзам', 'Vichy', 563.82, 16);
INSERT INTO kosmetika VALUES (2, 'La Roche-Posay Сыворотка', 'La Roche-Posay', 1610.51, 35);
INSERT INTO kosmetika VALUES (3, 'Bioderma Шампунь', 'Bioderma', 1994.01, 17);
INSERT INTO kosmetika VALUES (4, 'Estée Lauder Гель', 'Estée Lauder', 2276.02, 41);
INSERT INTO kosmetika VALUES (5, 'Nivea Сыворотка', 'Nivea', 2263.85, 12);
INSERT INTO kosmetika VALUES (6, 'La Roche-Posay Гель', 'La Roche-Posay', 501.66, 21);

INSERT INTO sales VALUES (1, 5, 3, '2026-01-10 16:16:39', 4, 7976.04);
INSERT INTO sales VALUES (2, 2, 1, '2026-01-08 21:24:39', 1, 563.82);
INSERT INTO sales VALUES (3, 5, 2, '2026-01-11 10:01:39', 5, 8052.55);
INSERT INTO sales VALUES (4, 1, 2, '2026-01-15 08:21:39', 3, 4831.53);
INSERT INTO sales VALUES (5, 4, 1, '2025-12-26 03:59:39', 2, 1127.64);
INSERT INTO sales VALUES (6, 2, 6, '2026-01-03 08:26:39', 5, 2508.30);

INSERT INTO feedback VALUES (1, 5, 4, 'Мастер профессионал!', 3, '2026-01-14');
INSERT INTO feedback VALUES (2, 3, 6, 'Быстро и качественно.', 5, '2026-01-09');
INSERT INTO feedback VALUES (3, 6, 5, 'Мастер профессионал!', 3, '2026-01-11');
INSERT INTO feedback VALUES (4, 1, 1, 'Мастер профессионал!', 5, '2026-01-13');
INSERT INTO feedback VALUES (5, 3, 2, 'Быстро и качественно.', 4, '2026-01-09');

