-- Створення основних таблиць 
CREATE TABLE IF NOT EXISTS Books (
   id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
   code INT NOT NULL UNIQUE,
   is_new TINYINT(1) NOT NULL DEFAULT 0,
   name VARCHAR(255) NOT NULL,
   price DECIMAL(10, 2) NOT NULL,
   producer_id INT NOT NULL,
   pages INT NOT NULL,
   format VARCHAR(30) NOT NULL,
   publish_date DATE NOT NULL,
   circulation INT,
   topic_id INT NOT NULL,
   category_id INT NOT NULL,
   CONSTRAINT price_check CHECK (price >= 0),
   CONSTRAINT circulation_check CHECK (circulation >= 0)
);

CREATE TABLE IF NOT EXISTS categories (
   id INT PRIMARY KEY AUTO_INCREMENT,
   name VARCHAR(300) NOT NULL
);

CREATE TABLE IF NOT EXISTS producers (
   id INT PRIMARY KEY AUTO_INCREMENT,
   name VARCHAR(300) NOT NULL
);

CREATE TABLE IF NOT EXISTS topics (
   id INT PRIMARY KEY AUTO_INCREMENT,
   name VARCHAR(300) NOT NULL
);

-- Вставка даних у таблиці 
INSERT INTO categories (name) VALUES
('Підручники'), ('Апаратні засоби'), ('Інші книги'), ('Windows 2000'), 
('Linux'), ('Unix'), ('Інші операційні системи'), ('C&C++'), 
('SQL'), ('Захист та безмпека ПК');

INSERT INTO producers (name) VALUES
('BHV'), ('Вільямс'), ('МікроАрт'), ('DiaSoft'), ('ДМК'), ('Триумф'),
('Еком'), ('Києво-Могилянська академія'), ('Університет "Україна"'), ('Вінниця: ВДТУ');

INSERT INTO topics (name) VALUES
('Використання ПК в цілому'), ('Операційні системи'), ('Програмування');

-- Завантаження даних в таблицю books 
INSERT INTO books (code, is_new, name, price, producer_id, pages, format, publish_date, circulation, topic_id, category_id) VALUES
(5110, 0, 'Апаратні засоби мультимедіа.Відеосистема PC', 15.51, 1, 400, '70х100/16', '2000-07-24', 5000, 1, 1),
(4985, 0, 'Засвой самостійно модернізацію та ремонт ПК за 24 години, 2-ге вид', 18.9, 2, 288, '70х100/16', '2000-07-07', 5000, 1, 1),
(5141, 0, 'Структури даних та алгоритми', 37.80, 2, 384, '70х100/16', '2000-09-29', 5000, 1, 1),
(5127, 0, 'Автоматизація інженерно-графічних робіт', 11.58, 1, 256, '70х100/16', '2000-06-15', 5000, 1, 1),
(5110, 0, 'Апаратні засоби мультимедіа. Відеосистема РС', 15.51, 1, 400, '70х100/16', '2000-07-24', 5000, 1, 6),
(5199, 0, 'Залізо IBM 2001', 30.07, 2, 368, '70х100/16', '2000-12-02', 5000, 1, 2),
(3851, 0, 'Захист інформації та безпека компьютерних систем', 26.00, 4, 480, '84х108/16', '1999-02-04', 5000, 1, 10),
(3932, 0, 'Як перетворити персональний компьютер на вимірювальний комплекс', 7.65, 5, 144, '60х88/16', '1999-06-09', 5000, 1, 3),
(4713, 0, 'Plug-ins. Додаткові програми для музичних програм', 11.41, 5, 144, '70х100/16', '2000-02-22', 5000, 1, 3),
(5217, 0, 'Windows МЕ. Найновіші версії програм', 16.57, 6, 320, '70х100/16', '2000-08-25', 5000, 2, 4),
(4829, 0, 'Windows 2000 Professional крок за кроком з CD', 27.25, 7, 320, '70х100/16', '2000-04-28', 5000, 2, 4),
(5170, 0, 'Linux версії', 24.43, 5, 346, '70х100/16', '2000-09-29', 5000, 2, 5),
(860, 0, 'Операційна система UNIX', 3.50, 1, 395, '84х100/16', '1997-05-05', 5000, 2, 6),
(44, 0, 'Відповіді на актуальні запитання щодо OS/2 Warp', 5.00, 4, 352, '60х84/16', '1996-03-20', 5000, 2, 7),
(5176, 0, 'Windows Ме. Спутник користувача', 12.79, 1, 306, '-', '2000-10-10', 5000, 2, 7),
(5462, 0, 'Мова програмування С++. Лекції та вправи', 29.00, 4, 656, '84х108/16', '2000-12-12', 5000, 3, 8),
(4982, 0, 'Мова програмування С. Лекції та вправи', 29.00, 4, 432, '84х108/16', '2000-07-12', 5000, 3, 8),
(4687, 0, 'Ефективне використання C++. 50 рекомендацій щодо покращення ваших програм та проектів', 17.60, 6, 240, '70х100/16', '2000-02-03', 5000, 3, 8),
(235, 0, 'Інформаційні системи і структури даних', 0.5, 8, 288, '60х90/16', '2004-07-08', 400, 1, 3),
(8746, 1, 'Бази даних в інформаційних системах', 0.5, 9, 418, '60х84/16', '2018-07-25', 100, 3, 9),
(2154, 1, 'Сервер на основі операційної системи FreeBSD 6.1', 0, 9, 216, '60х84/16', '2015-11-03', 500, 3, 7),
(2662, 0, 'Організація баз даних та знань', 0, 10, 208, '60х90/16', '2001-10-10', 1000, 3, 9),
(5641, 1, 'Організація баз даних та знань', 0, 1, 384, '70х100/16', '2021-12-15', 5000, 3, 9);

-- Створення зовнішніх ключів для полів producer_id, topic_id, category_id 
ALTER TABLE books ADD CONSTRAINT fk_producer FOREIGN KEY (producer_id) REFERENCES producers(id) ON DELETE CASCADE;
ALTER TABLE books ADD CONSTRAINT fk_topic FOREIGN KEY (topic_id) REFERENCES topics(id) ON DELETE CASCADE;
ALTER TABLE books ADD CONSTRAINT fk_category FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE CASCADE;
