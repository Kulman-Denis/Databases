
DROP PROCEDURE IF EXISTS FreeCursorExample;

-- 1. Розробити та перевірити скалярну (scalar) функцію, що повертає загальну вартість книг виданих в певному році.
DELIMITER //
CREATE FUNCTION TotalCostOfBooksInYear(pub_year INT)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE total_cost DECIMAL(10, 2);
    SELECT SUM(Price) INTO total_cost
    FROM book
    WHERE YEAR(Date) = pub_year;
    RETURN IFNULL(total_cost, 0);
END //
DELIMITER ;

SELECT TotalCostOfBooksInYear(2000);

-- 2. Розробити і перевірити табличну (inline) функцію, яка повертає список книг виданих в певному році.
DELIMITER //
CREATE PROCEDURE BooksPublishedInYear(pub_year INT)
BEGIN
    SELECT 
        N, 
        Code, 
        New, 
        Name, 
        Price, 
        Producer_ID, 
        Pages, 
        Form_ID, 
        Date, 
        Circulation, 
        Topic_ID, 
        Category_ID
    FROM 
        book
    WHERE 
        YEAR(Date) = pub_year;
END //
DELIMITER ;

CALL BooksPublishedInYear(2000);

-- 3. Розробити і перевірити функцію типу multi-statement, яка буде:
-- a. приймати в якості вхідного параметра рядок, що містить список назв видавництв, розділених символом ‘;’;  
-- b. виділяти з цього рядка назву видавництва;
-- c. формувати нумерований список назв видавництв.

DELIMITER //

CREATE FUNCTION ParsePublishers(publisher_list TEXT) 
RETURNS TEXT 
DETERMINISTIC
BEGIN
    DECLARE cur_pos INT DEFAULT 1;
    DECLARE remaining_length INT;
    DECLARE cur_publisher VARCHAR(50);
    DECLARE publishers_list TEXT DEFAULT '';
    DECLARE delimiter_pos INT;
    DECLARE publisher_num INT DEFAULT 1;

    SET remaining_length = LENGTH(publisher_list);

    WHILE cur_pos <= remaining_length DO
        SET delimiter_pos = LOCATE(';', publisher_list, cur_pos);

        IF delimiter_pos = 0 THEN
            SET cur_publisher = SUBSTRING(publisher_list, cur_pos);
            SET cur_pos = remaining_length + 1;
        ELSE
            SET cur_publisher = SUBSTRING(publisher_list, cur_pos, delimiter_pos - cur_pos);
            SET cur_pos = delimiter_pos + 1;
        END IF;

        SET publishers_list = CONCAT(publishers_list, publisher_num, '. ', cur_publisher, '\n');
        SET publisher_num = publisher_num + 1;
    END WHILE;

    RETURN publishers_list;
END //

DELIMITER ;

SELECT ParsePublishers('ДМК;DiaSoft;Видавнича група BHV') AS PublishersList;

-- 4. Виконати набір операцій по роботі з SQL курсором: оголосити курсор;
-- a. використовувати змінну для оголошення курсору;
-- b. відкрити курсор;
-- c. переприсвоїти курсор іншої змінної;
-- d. виконати вибірку даних з курсору;
-- e. закрити курсор;

DELIMITER //

CREATE PROCEDURE CursorExample(pub_year INT)
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE book_name VARCHAR(100);
    DECLARE row_num INT DEFAULT 0;
    DECLARE result_list TEXT DEFAULT '';
    DECLARE book_cursor CURSOR FOR
        SELECT Name FROM book WHERE YEAR(Date) = pub_year;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN book_cursor;
    read_loop: LOOP
        FETCH book_cursor INTO book_name;
        IF done THEN
            LEAVE read_loop;
        END IF;
        SET row_num = row_num + 1;
        IF row_num > 1 THEN
            SET result_list = CONCAT(result_list, '\n');
        END IF;
        SET result_list = CONCAT(result_list, row_num, '. ', book_name);
    END LOOP;
    CLOSE book_cursor;
    
    SELECT result_list AS Books_List;
END //

DELIMITER ;

-- 5. Звільнити курсор. Розробити курсор для виводу списка книг виданих у визначеному році.
CALL CursorExample(2000);

