
DROP TRIGGER CheckPublisherCategory;

-- Тригер 1
INSERT INTO topic (Topic) VALUES ('1');

-- Тригер 2
INSERT INTO book (Name, Date, New) VALUES ('Books', '2010-04-02', 1);

-- Тригер 3
INSERT INTO book (Name, Pages, Price) VALUES ('Books', 200, 30);

-- Тригер 4
INSERT INTO book (Name, Producer_ID, Circulation) VALUES ('Books', (SELECT Producer_ID FROM producer WHERE Producer = 'BHV' LIMIT 1), 4000);

INSERT INTO book (Name, Producer_ID, Circulation) VALUES ('Books', (SELECT Producer_ID FROM producer WHERE Producer = 'Diasoft' LIMIT 1), 8000);

-- Тригер 5
INSERT INTO book (Name, Code, Price, Producer_ID, Pages, Form_ID, Date, Circulation, Topic_ID, Category_ID, N, New)  
VALUES ('Books', '4000', 20, 1, 200, 1, '2010-05-27', 5000, 1, 1, '4', 1);

-- Тригер 8
INSERT INTO book (N, Code, New, Name, Price, Producer_ID, Pages, Form_ID, Date, Circulation, Topic_ID, Category_ID) 
VALUES 
(9000, '301', 0, 'Books1', 10.00, 5, 90, 1, '2024-05-01', 1000, 1, 1);

-- Тригер 9
INSERT INTO book (N, Code, New, Name, Price, Producer_ID, Pages, Form_ID, Date, Circulation, Topic_ID, Category_ID) 
VALUES 
(9000, '301', 1, 'Books1', 10.00, 1, 90, 1, '2024-05-01', 1000, 1, 1),
(9001, '302', 1, 'Books2', 10.00, 1, 150, 2, '2024-05-02', 1500, 2, 2),
(9002, '303', 1, 'Books3', 10.00, 1, 250, 3, '2024-05-03', 2000, 3, 3),
(9003, '304', 1, 'Books4', 10.00, 1, 90, 1, '2024-05-04', 1000, 1, 1),
(9004, '305', 1, 'Books5', 10.00, 1, 150, 2, '2024-05-05', 1500, 2, 2),
(9005, '306', 1, 'Books6', 10.00, 1, 250, 3, '2024-05-06', 2000, 3, 3),
(9006, '307', 1, 'Books7', 10.00, 1, 150, 2, '2024-05-07', 1500, 2, 2),
(9007, '308', 1, 'Books8', 10.00, 1, 250, 3, '2024-05-08', 2000, 3, 3),
(9008, '309', 1, 'Books9', 10.00, 1, 90, 1, '2024-05-09', 1000, 1, 1),
(9009, '310', 1, 'Books10', 10.00, 1, 150, 2, '2024-05-10', 1500, 2, 2),
(9010, '311', 1, 'Books11', 10.00, 1, 250, 3, '2024-05-11', 2000, 3, 3);

-- Тригер 10
INSERT INTO book (N, Code, New, Name, Price, Producer_ID, Pages, Form_ID, Date, Circulation, Topic_ID, Category_ID) VALUES
(2, 5110, 0, 'Апаратні засоби мультимедіа.Відеосистема PC', 15.51, 1, 400, 1, '2000-07-24', 5000, 1, 1),

-- 1. Кількість тем може бути в діапазоні від 5 до 10.
DELIMITER //

CREATE TRIGGER CheckTopicCount
BEFORE INSERT ON topic
FOR EACH ROW
BEGIN
    DECLARE topic_count INT;
    SELECT COUNT(*) INTO topic_count FROM topic;
    IF topic_count < 5 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Допускається мінімум 5 тем';
    ELSEIF topic_count >= 10 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Допускається максимум 10 тем';
    END IF;
END //

DELIMITER ;

-- 2. Новинкою може бути тільки книга видана в поточному році.
DELIMITER //
CREATE TRIGGER CheckNewBookYear
BEFORE INSERT ON book
FOR EACH ROW
BEGIN
    IF NEW.New = TRUE AND YEAR(NEW.Date) <> YEAR(CURDATE()) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Нові книги повинні вийти в поточному році';
    END IF;
END //
DELIMITER ;

-- 3. Книга з кількістю сторінок до 100 не може коштувати більше 10 $, до 200 - 20 $, до 300 - 30 $.
DELIMITER //
CREATE TRIGGER CheckBookPrice
BEFORE INSERT ON book
FOR EACH ROW
BEGIN
    IF NEW.Pages <= 100 AND NEW.Price > 10 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Книги до 100 сторінок не можуть коштувати більше 10 доларів';
    ELSEIF NEW.Pages <= 200 AND NEW.Price > 20 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Книги до 200 сторінок не можуть коштувати більше 20 доларів';
    ELSEIF NEW.Pages <= 300 AND NEW.Price > 30 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Книги до 300 сторінок не можуть коштувати більше 30 доларів';
    END IF;
END //
DELIMITER ;

-- 4. Видавництво "BHV" не випускає книги накладом меншим 5000, а видавництво Diasoft - 10000.
DELIMITER //
CREATE TRIGGER CheckPublisherCirculation
BEFORE INSERT ON book
FOR EACH ROW
BEGIN
    DECLARE publisher_name VARCHAR(50);
    SELECT Producer INTO publisher_name FROM producer WHERE Producer_ID = NEW.Producer_ID;
    IF publisher_name = 'BHV' AND NEW.Circulation < 5000 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'BHV не може видавати книги накладом менше 5000';
    ELSEIF publisher_name = 'Diasoft' AND NEW.Circulation < 10000 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Diasoft не може видавати книги тиражем менше 10000';
    END IF;
END //
DELIMITER ;

-- 5. Книги з однаковим кодом повинні мати однакові дані.
DELIMITER //
CREATE TRIGGER CheckBookCodeConsistency
BEFORE INSERT ON book
FOR EACH ROW
BEGIN
    DECLARE existing_book_count INT;
    SELECT COUNT(*) INTO existing_book_count FROM book WHERE Code = NEW.Code AND (Name <> NEW.Name OR Price <> NEW.Price OR Producer_ID <> NEW.Producer_ID OR Pages <> NEW.Pages OR Form_ID <> NEW.Form_ID OR Date <> NEW.Date OR Circulation <> NEW.Circulation OR Topic_ID <> NEW.Topic_ID OR Category_ID <> NEW.Category_ID);
    IF existing_book_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Книги з однаковим кодом повинні мати однакові дані';
    END IF;
END //
DELIMITER ;

-- 6. При спробі видалення книги видається інформація про кількість видалених рядків. Якщо користувач не "dbo", то видалення забороняється.
DELIMITER //
CREATE TRIGGER BeforeDeleteBook
BEFORE DELETE ON book
FOR EACH ROW
BEGIN
    declare user_name varchar(255);
    Set user_name = substring_index2(session_user(),'@',1);
    if user_name != 'dbo' then
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Видалення забороненно для цього користувача';
    end if;
    end//
DELIMITER ;

-- 7. Користувач "dbo" не має права змінювати ціну книги.
DELIMITER //

CREATE TRIGGER AfterDeleteBook
AFTER DELETE ON book
FOR EACH ROW
BEGIN
    IF USER() REGEXP "^dbo@" THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Користувачу "dbo" заборонено видаляти книги.';
    END IF;
END //

DELIMITER ;

-- 8. Видавництва ДМК і Еком підручники не видають.
DELIMITER //

CREATE TRIGGER CheckPublisherCategory
BEFORE INSERT ON book
FOR EACH ROW
BEGIN
    IF (SELECT Producer FROM producer WHERE Producer_ID = NEW.Producer_ID) IN ('ДМК', 'Эком') AND (SELECT Category FROM category WHERE Category_ID = NEW.Category_ID) = 'Підручники' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Видавництва ДМК і Еком підручники не видають';
    END IF;
END //

DELIMITER ;



-- 9. Видавництво не може випустити більше 10 новинок протягом одного місяця поточного року.
DELIMITER //

CREATE TRIGGER BeforeInsertBook
BEFORE INSERT ON book
FOR EACH ROW
BEGIN
    DECLARE total_new_books INT;
    SELECT COUNT(*) INTO total_new_books 
    FROM book 
    WHERE Producer_ID = NEW.Producer_ID 
        AND NEW = TRUE 
        AND YEAR(Date) = YEAR(CURDATE());
    IF total_new_books >= 10 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Видавництво не може випустити більше 10 нових книг протягом одного місяця поточного року';
    END IF;
END //

DELIMITER ;

-- 10. Видавництво BHV не випускає книги формату 60х88 / 16.
DELIMITER //

CREATE TRIGGER CheckBhvBookFormat
BEFORE INSERT ON book
FOR EACH ROW
BEGIN
   IF (SELECT Producer FROM producer WHERE Producer_ID = NEW.Producer_ID) = 'BHV' AND (SELECT Form FROM form WHERE Form_ID = NEW.Form_ID) = '60х88/16' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Видавництво BHV не випускає книги формату 60х88 / 16';
    END IF;
END //

DELIMITER ;
