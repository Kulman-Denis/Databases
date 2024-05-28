
DROP PROCEDURE IF EXISTS GetBooksByPublisherAndYear;

-- 1. Вивести значення наступних колонок: назва книги, ціна, назва видавництва, формат.
DELIMITER //

CREATE PROCEDURE GetBookData()
BEGIN
    SELECT b.Name, b.Price, p.Producer, f.Form
    FROM book b
    JOIN producer p ON b.Producer_ID = p.Producer_ID
    JOIN form f ON b.Form_ID = f.Form_ID;
END //

DELIMITER ;

CALL GetBookData();

-- 2. Вивести значення наступних колонок: тема, категорія, назва книги, назва видавництва. Фільтр по темам і категоріям.
DELIMITER //

CREATE PROCEDURE GetBookDataByTopicAndCategory(IN topic_name VARCHAR(50), IN category_name VARCHAR(50))
BEGIN
    SELECT t.Topic, c.Category, b.Name, p.Producer
    FROM book b
    JOIN producer p ON b.Producer_ID = p.Producer_ID
    JOIN topic t ON b.Topic_ID = t.Topic_ID
    JOIN category c ON b.Category_ID = c.Category_ID
    WHERE t.Topic = topic_name AND c.Category = category_name;
END //

DELIMITER ;

CALL GetBookDataByTopicAndCategory('Операційні системи', 'Windows 2000');

-- 3. Вивести книги видавництва 'BHV', видані після 2000 р.
DELIMITER //

CREATE PROCEDURE GetBooksByPublisherAndYear()
BEGIN
    SELECT *
    FROM book
    WHERE Producer_ID = (SELECT Producer_ID FROM producer WHERE Producer = 'BHV' LIMIT 1) AND YEAR(Date) > 2000;
END //

DELIMITER ;

CALL GetBooksByPublisherAndYear();

-- 4. Вивести загальну кількість сторінок по кожній назві категорії.
DELIMITER //

CREATE PROCEDURE GetTotalPagesByCategory(IN order_type VARCHAR(10))
BEGIN
    SELECT c.Category, SUM(b.Pages) AS Total_Pages
    FROM book b
    JOIN category c ON b.Category_ID = c.Category_ID
    GROUP BY c.Category
    ORDER BY Total_Pages DESC;
END //

DELIMITER ;

CALL GetTotalPagesByCategory('DESC');

-- 5. Вивести середню вартість книг по темі 'Використання ПК' і категорії 'Linux'.
DELIMITER //

CREATE PROCEDURE GetAveragePriceByTopicAndCategory(IN topic_name VARCHAR(50), IN category_name VARCHAR(50), OUT avg_price DECIMAL(10, 2))
BEGIN
    SELECT AVG(b.Price) INTO avg_price
    FROM book b
    JOIN topic t ON b.Topic_ID = t.Topic_ID
    JOIN category c ON b.Category_ID = c.Category_ID
    WHERE t.Topic = topic_name AND c.Category = category_name;
END //

DELIMITER ;

CALL GetAveragePriceByTopicAndCategory('Використання ПК', 'Linux', @avg_price);
SELECT @avg_price AS Average_Price;

-- 6. Вивести всі дані універсального відношення.
DELIMITER //

CREATE PROCEDURE GetAllDataFromUniversalView()
BEGIN
    SELECT *
    FROM universal_view;
END //

DELIMITER ;

CALL GetAllDataFromUniversalView();

-- 7. Вивести пари книг, що мають однакову кількість сторінок.
DELIMITER //

CREATE PROCEDURE GetBookPairsWithSamePageCount()
BEGIN
    SELECT DISTINCT b1.Name AS Book1, b2.Name AS Book2, b1.Pages
    FROM book b1, book b2
    WHERE b1.N <> b2.N AND b1.Pages = b2.Pages;
END //

DELIMITER ;

CALL GetBookPairsWithSamePageCount();

-- 8. Вивести тріади книг, що мають однакову ціну.
DELIMITER //

CREATE PROCEDURE GetBookTriosWithSamePrice()
BEGIN
    SELECT b1.N AS Book1_ID, b1.Name AS Book1, 
           b2.N AS Book2_ID, b2.Name AS Book2, 
           b3.N AS Book3_ID, b3.Name AS Book3, 
           b1.Price
    FROM book b1
    JOIN book b2 ON b1.Price = b2.Price AND b1.N < b2.N
    JOIN book b3 ON b1.Price = b3.Price AND b2.N < b3.N
    LIMIT 1;
END //

DELIMITER ;

CALL GetBookTriosWithSamePrice();

-- 9. Вивести всі книги категорії 'C ++'.
DELIMITER //

CREATE PROCEDURE GetBooksByCategory(IN category_name VARCHAR(50))
BEGIN
    SELECT *
    FROM universal_view
    WHERE Category = category_name;
END //

DELIMITER ;

CALL GetBooksByCategory('C&C++');

-- 10. Вивести список видавництв, у яких розмір книг перевищує 400 сторінок.
DELIMITER //

CREATE PROCEDURE GetPublishersWithBooksOverPages(IN min_pages INT)
BEGIN
    SELECT p.Producer
    FROM book b
    JOIN producer p ON b.Producer_ID = p.Producer_ID
    WHERE b.Pages > min_pages
    GROUP BY p.Producer;
END //

DELIMITER ;

CALL GetPublishersWithBooksOverPages(400);

-- 11. Вивести список категорій за якими більше 3-х книг.
DELIMITER //

CREATE PROCEDURE GetCategoriesWithMoreThan3Books(IN min_books INT)
BEGIN
    SELECT c.Category
    FROM book b
    JOIN category c ON b.Category_ID = c.Category_ID
    GROUP BY c.Category
    HAVING COUNT(*) > min_books;
END //

DELIMITER ;

CALL GetCategoriesWithMoreThan3Books(3);

-- 12. Вивести список книг видавництва 'BHV', якщо в списку є хоча б одна книга цього видавництва.
DELIMITER //

CREATE PROCEDURE GetBooksByPublisherIfAtLeastOne(IN producer_name VARCHAR(50))
BEGIN
    SELECT *
    FROM universal_view
    WHERE Producer = producer_name;
END //

DELIMITER ;

CALL GetBooksByPublisherIfAtLeastOne('BHV');

-- 13. Вивести список книг видавництва 'BHV', якщо в списку немає жодної книги цього видавництва.
DELIMITER //

CREATE PROCEDURE GetBooksByPublisherIfNone(IN producer_name VARCHAR(50))
BEGIN
    SELECT *
    FROM universal_view
    WHERE Producer != producer_name;
END //

DELIMITER ;

CALL GetBooksByPublisherIfNone('BHV');

-- 14. Вивести відсортований загальний список назв тем і категорій.
DELIMITER //

CREATE PROCEDURE GetSortedTopicsAndCategories()
BEGIN
    SELECT * FROM (
        (SELECT Topic AS Name FROM topic)
        UNION
        (SELECT Category AS Name FROM category)
    ) AS CombinedNames
    ORDER BY Name;
END //

DELIMITER ;

CALL GetSortedTopicsAndCategories();

-- 15. Вивести відсортований в зворотному порядку загальний список перших слів назв книг і категорій що не повторюються
DELIMITER //

CREATE PROCEDURE GetDistinctFirstWordsInReverseOrder()
BEGIN
    SELECT DISTINCT SUBSTRING_INDEX(Name, ' ', 1) AS FirstWord
    FROM (
        SELECT Name FROM book
        UNION ALL
        SELECT Category AS Name FROM category
    ) AS CombinedNames
    ORDER BY FirstWord DESC;
END //

DELIMITER ;

CALL GetDistinctFirstWordsInReverseOrder();