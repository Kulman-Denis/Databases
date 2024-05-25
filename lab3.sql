-- 1. Вивести книги у яких не введена ціна або ціна дорівнює 0
SELECT * FROM lab1.work WHERE Price IS NULL OR Price = 0;

-- 2. Вивести книги у яких введена ціна, але не введений тираж
SELECT * FROM lab1.work WHERE Price IS NOT NULL AND Circulation IS NULL;

-- 3. Вивести книги, про дату видання яких нічого не відомо.
SELECT * FROM lab1.work WHERE Date IS NULL;

-- 4. Вивести книги, з дня видання яких пройшло не більше року.
SELECT *,
    CASE 
        WHEN (YEAR(Date) % 4 = 0 AND YEAR(Date) % 100 != 0) OR (YEAR(Date) % 400 = 0) 
        THEN 'Yes' 
        ELSE 'No' 
    END AS is_leap_year
FROM lab1.work 
WHERE DATEDIFF(CURRENT_DATE, Date) <= 365;

-- 5. Вивести список книг-новинок, відсортованих за зростанням ціни
SELECT * FROM lab1.work WHERE New = '1' ORDER BY Price ASC;

-- 6. Вивести список книг з числом сторінок від 300 до 400, відсортованих в зворотному алфавітному порядку назв
SELECT * FROM lab1.work WHERE Pages BETWEEN 300 AND 400 ORDER BY Name DESC;

-- 7. Вивести список книг з ціною від 20 до 40, відсортованих за спаданням дати
SELECT * FROM lab1.work WHERE Price BETWEEN 20 AND 40 ORDER BY Date DESC;

-- 8. Вивести список книг, відсортованих в алфавітному порядку назв і ціною по спадаючій
SELECT * FROM lab1.work ORDER BY Name ASC, Price DESC;

-- 9. Вивести книги, у яких ціна однієї сторінки < 10 копійок.
SELECT * FROM lab1.work 
WHERE Price IS NOT NULL AND Pages IS NOT NULL AND (Price / Pages) < 0.10;

-- 10. Вивести значення наступних колонок: число символів в назві, перші 20 символів назви великими літерами
SELECT LENGTH(Name) AS Name_Length, UPPER(LEFT(Name, 20)) AS First_20_Capitalized FROM lab1.work;

-- 11. Вивести значення наступних колонок: перші 10 і останні 10 символів назви прописними буквами, розділені '...'
SELECT CONCAT(UPPER(LEFT(Name, 10)), '...', UPPER(RIGHT(Name, 10))) AS First_Last_10_Capitalized FROM lab1.work;

-- 12. Вивести значення наступних колонок: назва, дата, день, місяць, рік
SELECT Name, Date, DAY(Date) AS Day, MONTH(Date) AS Month, YEAR(Date) AS Year FROM lab1.work;

-- 13. Вивести значення наступних колонок: назва, дата, дата в форматі 'dd / mm / yyyy'
SELECT Name, Date, DATE_FORMAT(Date, '%d / %m / %Y') AS Formatted_Date FROM lab1.work;

-- 14. Вивести значення наступних колонок: код, ціна, ціна в грн., ціна в євро, ціна в руб.
SELECT Cod, Price, Price * 36.93 AS UAH, Price * 0.93 AS EUR, Price * 80.16 AS RUB FROM lab1.work;

-- 15. Вивести значення наступних колонок: код, ціна, ціна в грн. без копійок, ціна без копійок округлена
SELECT Cod, Price, FLOOR(Price * 30.3) AS USD, TRUNCATE(Price * 36.93, 0) AS UAH_without_cents, ROUND(Price * 36.93) AS Rounded_UAH FROM lab1.work;

-- 16. Додати інформацію про нову книгу (всі колонки)
INSERT INTO lab1.work (Numer, Cod, Name, Producer, Pages, Form, Date, Circulation, Topic, Category, Price, New) 
VALUES (301, 8919, 'Python', 'Старого Лева', 250, '70х100/16', '2024-05-21', 500, 'Python Класи та обєкти', 'Веб-фреймворки на Python‎', 0, '0');

-- 17. Додати інформацію про нову книгу (колонки обов'язкові для введення)
INSERT INTO lab1.work (Numer, Cod, Name, Date, New, Producer, Pages, Circulation, Topic, Category)
VALUES (301, 8785, 'Python', '2022-05-21', '0', 'Символ-Плюс', 250, 500, 'Посібник з мови програмування Python', 'Библиотеки Python‎');

SET SQL_SAFE_UPDATES = 0;

-- 18. Видалити книги, видані до 1990 року
DELETE FROM lab1.work WHERE YEAR(Date) < 1990;

-- 19. Проставити поточну дату для тих книг, у яких дата видання відсутня
UPDATE lab1.work SET Date = CURRENT_DATE WHERE Date IS NULL;

-- 20. Установити ознаку новинка для книг виданих після 2005 року
UPDATE lab1.work SET New = '1' WHERE YEAR(Date) >= 2005;
SET SQL_SAFE_UPDATES = 1;