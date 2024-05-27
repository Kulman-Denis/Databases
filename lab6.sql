-- 1. Вивести значення наступних колонок: назва книги, ціна, назва видавництва. Використовувати внутрішнє з'єднання, застосовуючи where.
SELECT b.Name, b.Price, p.Producer
FROM book b
JOIN producer p ON b.Producer_ID = p.Producer_ID
WHERE b.Name IS NOT NULL AND b.Price IS NOT NULL AND p.Producer IS NOT NULL;

-- 2. Вивести значення наступних колонок: назва книги, назва категорії. Використовувати внутрішнє з'єднання, застосовуючи inner join.
SELECT b.Name, c.Category
FROM book b
JOIN category c ON b.Category_ID = c.Category_ID;

-- 3. Вивести значення наступних колонок: назва книги, ціна, назва видавництва, формат.
SELECT b.Name, b.Price, p.Producer, f.Form
FROM book b
JOIN producer p ON b.Producer_ID = p.Producer_ID
JOIN form f ON b.Form_ID = f.Form_ID;

-- 4. Вивести значення наступних колонок: тема, категорія, назва книги, назва видавництва. Фільтр по темам і категоріям.
SELECT t.Topic, c.Category, b.Name, p.Producer
FROM book b
JOIN producer p ON b.Producer_ID = p.Producer_ID
JOIN topic t ON b.Topic_ID = t.Topic_ID
JOIN category c ON b.Category_ID = c.Category_ID
WHERE t.Topic IN ('Операційні системи', 'Програмування') AND c.Category IN ('Windows 2000', 'Linux');

-- 5. Вивести книги видавництва 'BHV', видані після 2000 р.
SELECT b.*
FROM book b
JOIN producer p ON b.Producer_ID = p.Producer_ID
WHERE p.Producer = 'BHV' AND YEAR(b.Date) > 2000;

-- 6. Вивести загальну кількість сторінок по кожній назві категорії. Фільтр по спадаючій кількості сторінок.
SELECT c.Category, SUM(b.Pages) AS Total_Pages
FROM book b
JOIN category c ON b.Category_ID = c.Category_ID
GROUP BY c.Category
ORDER BY Total_Pages DESC;

-- 7. Вивести середню вартість книг по темі 'Використання ПК' і категорії 'Linux'.
SELECT AVG(b.Price) AS Average_Price
FROM book b
JOIN topic t ON b.Topic_ID = t.Topic_ID
JOIN category c ON b.Category_ID = c.Category_ID
WHERE t.Topic = 'Використання ПК' AND c.Category = 'Linux';

-- 8. Вивести всі дані універсального відношення. Використовувати внутрішнє з'єднання, застосовуючи where.
SELECT *
FROM universal_view
WHERE Name IS NOT NULL AND Price IS NOT NULL AND Producer IS NOT NULL;

-- 9. Вивести всі дані універсального відношення. Використовувати внутрішнє з'єднання, застосовуючи inner join.
SELECT uv.*
FROM universal_view uv;

-- 10. Вивести всі дані універсального відношення. Використовувати зовнішнє з'єднання, застосовуючи left join / right join.
SELECT uv.*
FROM universal_view uv
LEFT JOIN producer p ON uv.Producer = p.Producer;

-- 11. Вивести пари книг, що мають однакову кількість сторінок. Використовувати само об’єднання і аліаси (self join).
SELECT b1.Name AS Book1, b2.Name AS Book2, b1.Pages
FROM book b1
JOIN book b2 ON b1.Pages = b2.Pages AND b1.Name <> b2.Name;

-- 12. Вивести тріади книг, що мають однакову ціну. Використовувати самооб'єднання і аліаси (self join).
SELECT b1.Name AS Book1, b2.Name AS Book2, b3.Name AS Book3, b1.Price
FROM book b1
JOIN book b2 ON b1.Price = b2.Price AND b1.Name <> b2.Name
JOIN book b3 ON b1.Price = b3.Price AND b1.Name <> b3.Name AND b2.Name <> b3.Name;

-- 13. Вивести всі книги категорії 'C ++'. Використовувати підзапити (subquery).
SELECT * FROM book
WHERE Category_ID = (
    SELECT Category_ID
    FROM category
    WHERE Category = 'C++'
);

-- 14. Вивести книги видавництва 'BHV', видані після 2000 р. Використовувати підзапити (subquery).
SELECT * FROM book 
WHERE Producer_ID IN (     
    SELECT Producer_ID     
    FROM producer     
    WHERE Producer = 'BHV' 
) 
AND YEAR(Date) > 2000 
LIMIT 0, 1000;


-- 15. Вивести список видавництв, у яких розмір книг перевищує 400 сторінок. Використовувати пов'язані підзапити (correlated subquery).
SELECT p.Producer FROM producer p
WHERE EXISTS (
    SELECT *
    FROM book b
    WHERE b.Producer_ID = p.Producer_ID
    AND b.Pages > 400
);

-- 16. Вивести список категорій в яких більше 3-х книг. Використовувати пов'язані підзапити (correlated subquery).
SELECT c.Category FROM category c
WHERE (
SELECT COUNT(*)
FROM book b
WHERE b.Category_ID = c.Category_ID
) > 3;

-- 17. Вивести список книг видавництва 'BHV', якщо в списку є хоча б одна книга цього видавництва. Використовувати exists.
SELECT * FROM book b 
WHERE EXISTS ( SELECT * FROM book 
    WHERE Producer_ID IN ( 
        SELECT Producer_ID 
        FROM producer 
        WHERE Producer = 'BHV' 
    ) 
) 
LIMIT 0, 1000;

-- 18. Вивести список книг видавництва 'BHV', якщо в списку немає жодної книги цього видавництва. Використовувати not exists.
SELECT * FROM book b 
WHERE NOT EXISTS ( SELECT * FROM book 
    WHERE Producer_ID IN ( 
        SELECT Producer_ID 
        FROM producer 
        WHERE Producer = 'BHV' 
    ) 
) 
LIMIT 0, 1000;

-- 19. Вивести відсортований загальний список назв тем і категорій. Використовувати union.
( SELECT Topic AS Title FROM topic)
UNION
( SELECT Category AS Title FROM category)
ORDER BY Title;

-- 20. Вивести відсортований в зворотному порядку загальний список перших слів, назв книг і категорій що не повторюються. Використовувати union.
( SELECT SUBSTRING_INDEX(Name, ' ', 1) AS First_Word
FROM book
UNION
SELECT SUBSTRING_INDEX(Category, ' ', 1) AS First_Word
FROM category)
ORDER BY First_Word DESC;