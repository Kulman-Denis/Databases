USE lab1;

-- Створення таблиці producer
CREATE TABLE IF NOT EXISTS producer (
    Producer_ID INT PRIMARY KEY AUTO_INCREMENT,
    Producer VARCHAR(50) NOT NULL
);

-- Створення таблиці topic
CREATE TABLE IF NOT EXISTS topic (
    Topic_ID INT PRIMARY KEY AUTO_INCREMENT,
    Topic VARCHAR(50) NOT NULL
);

-- Створення таблиці category
CREATE TABLE IF NOT EXISTS category (
    Category_ID INT PRIMARY KEY AUTO_INCREMENT,
    Category VARCHAR(50) NOT NULL
);

-- Створення таблиці form
CREATE TABLE IF NOT EXISTS form (
    Form_ID INT PRIMARY KEY AUTO_INCREMENT,
    Form VARCHAR(30) NOT NULL
);

-- Створення таблиці book
CREATE TABLE IF NOT EXISTS book (
    N INT NOT NULL,
    Code INT NOT NULL,
    New BOOLEAN NOT NULL,
    Name VARCHAR(100) NOT NULL,
    Price DECIMAL(5, 2),
    Producer_ID INT NOT NULL,
    Pages INT NOT NULL,
    Form_ID INT NOT NULL,
    Date DATE DEFAULT NULL,
    Circulation INT DEFAULT 0,
    Topic_ID INT NOT NULL,
    Category_ID INT NOT NULL,
    FOREIGN KEY (Producer_ID) REFERENCES producer(Producer_ID) ON DELETE CASCADE,
    FOREIGN KEY (Form_ID) REFERENCES form(Form_ID) ON DELETE CASCADE,
    FOREIGN KEY (Topic_ID) REFERENCES topic(Topic_ID) ON DELETE CASCADE,
    FOREIGN KEY (Category_ID) REFERENCES category(Category_ID) ON DELETE CASCADE
);

-- Завантаження даних в таблиці producer
INSERT INTO producer (Producer) VALUES 
('BHV'), 
('Вільямс'), 
('МикроАрт'), 
('DiaSoft'), 
('ДМК'), 
('Триумф'), 
('Эком'), 
('Києво-Могилянська академія'), 
('Університет "Україна"'), 
('Вінниця: ВДТУ');

-- Завантаження даних в таблиці topic
INSERT INTO topic (Topic) VALUES
('Використання ПК в цілому'),
('Операційні системи'),
('Програмування');

-- Завантаження даних в таблиці category
INSERT INTO category (Category) VALUES
('Підручники'),
('Апаратні засоби'),
('Інші книги'),
('Windows 2000'),
('Linux'),
('Unix'),
('Інші операційні системи'),
('C&C++'),
('SQL'),
('Захист та безпека ПК');

-- Завантаження даних в таблиці form
INSERT INTO form (Form) VALUES
('70х100/16'),
('84х108/16'),
('60х88/16'),
('60х84/16'),
('60х90/16');

-- Завантаження даних в таблиці book
INSERT INTO book (N, Code, New, Name, Price, Producer_ID, Pages, Form_ID, Date, Circulation, Topic_ID, Category_ID) VALUES
(2, 5110, 0, 'Апаратні засоби мультимедіа.Відеосистема PC', 15.51, 1, 400, 1, '2000-07-24', 5000, 1, 1),
(8, 4985, 0, 'Засвой самостійно модернізацію та ремонт за 24 години, 2-ге вид', 18.9, 2, 288, 1, '2000-07-07', 5000, 1, 1),
(9, 5141, 0, 'Структури даних та алгоритми', 37.8, 2, 384, 1, '2000-09-29', 5000, 1, 1),
(20, 5127, 0, 'Автоматизація інженерно-графічних робіт', 11.58, 1, 256, 1, '2000-06-15', 5000, 1, 1),
(31, 5113, 0, 'Апаратні засоби мультимедіа. Відеосистема', 15.51, 1, 400, 1, '2000-07-24', 5000, 1, 2),
(46, 5199, 0, 'Залізо IBM 2001', 30.07, 3, 368, 1, '2000-02-12', 5000, 1, 2),
(50, 3851, 0, 'Захист інформації та безпека компютерних систем', 26, 4, 480, 2, '1900-01-01', 5000, 1, 10),
(58, 3932, 0, 'Як перетворити персональний компютер на вимірювальний комплекс', 7.65, 5, 144, 3, '2000-06-09', 5000, 1, 3),
(59, 4713, 0, 'Plug-ins. Додаткові програми для музичних програм', 11.41, 5, 144, 1, '2000-02-22', 5000, 1, 3),
(175, 5217, 0, 'Windows МЕ. Найновіші версії програм', 16.57, 6, 320, 1, '2000-08-25', 5000, 2, 4),
(176, 4829, 0, 'Windows 2000 Professional крок за кроком з CD', 27.25, 7, 320, 1, '2000-04-28', 5000, 2, 4),
(188, 5170, 0, 'Linux версії', 24.43, 5, 346, 1, '2000-09-29', 5000, 2, 5),
(191, 860, 0, 'Операційна система UNIX', 3.5, 1, 395, 2, '1997-05-05', 5000, 2, 6),
(203, 44, 0, 'Відповіді на актуальні запитання щодо OS/2 Warp', 5, 4, 352, 4, '1996-03-20', 5000, 2, 7),
(206, 5176, 0, 'Windows Ме. Супутник користувача', 12.79, 1, 306, 1, '2000-10-10', 5000, 2, 7),
(209, 5462, 0, 'Мова програмування С++. Лекції та вправи', 29, 4, 656, 2, '2000-12-12', 5000, 3, 8),
(210, 4982, 0, 'Мова програмування С. Лекції та вправи', 29, 4, 432, 2, '2000-12-07', 5000, 3, 8),
(220, 4687, 0, 'Ефективне використання C++. 50 рекомендацій щодо покращення ваших програм та проектів', 17.6, 5, 240, 1, '2000-03-02', 5000, 3, 8),
(222, 235, 0, 'Інформаційні системи і структури даних', NULL, 8, 288, 5, NULL, 400, 1, 3),
(225, 8746, 1, 'Бази даних в інформаційних системах', NULL, 9, 418, 4, '2018-07-25', 100, 3, 9),
(226, 2154, 1, 'Сервер на основі операційної системи FreeBSD 6.1', 0, 9, 216, 4, '2015-11-03', 500, 3, 7),
(245, 2662, 0, 'Організація баз даних та знань', 0, 10, 208, 5, '2001-10-10', 1000, 3, 9),
(247, 5641, 1, 'Організація баз даних та знань', 0, 1, 384, 1, '2021-12-15', 5000, 3, 9);

-- Створити і перевірити представлення для отримання універсального відношення з набору нормалізованих таблиць бази даних.
CREATE OR REPLACE VIEW universal_view AS
SELECT 
    Books.N,
    Books.Code,
    Books.New,
    Books.Name,
    Books.Price,
    Producers.Producer,
    Books.Pages,
    Formats.Form AS Form,
    Books.Date,
    Books.Circulation,
    Topies.Topic,
    Categories.Category 
FROM 
    book Books
JOIN 
    producer Producers ON Books.Producer_ID = Producers.Producer_ID
JOIN 
    form Formats ON Books.Form_ID = Formats.Form_ID
JOIN 
    topic Topies ON Books.Topic_ID = Topies.Topic_ID
JOIN 
    category Categories ON Books.Category_ID = Categories.Category_ID;
    
select * FROM book
