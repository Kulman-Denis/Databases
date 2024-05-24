-- 1. Вивести значення наступних колонок: номер, код, новинка, назва, ціна, сторінки
SELECT Numer, Cod, New, Name, Price, Pages
FROM lab1.work;

-- 2. Вивести значення всіх колонок
SELECT * FROM lab1.work;

-- 3. Вивести значення колонок в наступному порядку: код, назва, новинка, сторінки, ціна, номер
SELECT Cod, Name, New, Pages, Price, Numer
FROM lab1.work;

-- 4 Вивести значення всіх колонок 10 перших рядків
SELECT * FROM lab1.work LIMIT 10;

-- 5. Вивести значення всіх колонок 10% перших рядків
SELECT * FROM lab1.work WHERE RAND() < 0.1;

-- 6. Вивести значення колонки код без повторення однакових кодів
SELECT DISTINCT Cod FROM lab1.work;

-- 7. Вивести всі книги новинки
SELECT * FROM lab1.work WHERE New = 'Yes';

-- 8. Вивести всі книги новинки з ціною від 20 до 30
SELECT * FROM lab1.work WHERE New = 'Yes' AND Price BETWEEN 20 AND 30;

-- 9. Вивести всі книги новинки з ціною менше 20 і більше 30
SELECT * FROM lab1.work WHERE New = 'Yes' AND (Price < 20 OR Price > 30);

-- 10. Вивести всі книги з кількістю сторінок від 300 до 400 і з ціною більше 20 і менше 30
SELECT * FROM lab1.work WHERE Pages BETWEEN 300 AND 400 AND Price BETWEEN 20 AND 30;

-- 11. Вивести всі книги видані взимку 2000 року
SELECT * FROM lab1.work WHERE YEAR(Date) = 2000 AND MONTH(Date) IN (12, 1, 2);

-- 12. Вивести книги зі значеннями кодів 5110, 5141, 4985, 4241
SELECT * FROM lab1.work WHERE Cod IN (5110, 5141, 4985, 4241);

-- 13. Вивести книги видані в 1999, 2001, 2003, 2005 р
SELECT * FROM lab1.work WHERE YEAR(Date) IN (1999, 2001, 2003, 2005);

-- 14. Вивести книги назви яких починаються на літери А-К
SELECT * FROM lab1.work WHERE Name LIKE 'А%' OR Name LIKE 'К%';

-- 15. Вивести книги назви яких починаються на літери "АПП", видані в 2000 році з ціною до 20
SELECT * FROM lab1.work WHERE Name LIKE 'АПП%' AND YEAR(Date) = 2000 AND Price < 20;

-- 16. Вивести книги назви яких починаються на літери "АПП", закінчуються на "е", видані в першій половині 2000 року
SELECT * FROM lab1.work WHERE Name LIKE 'АПП%е' AND Date BETWEEN '2000-01-01' AND '2000-06-30';

-- 17. Вивести книги, в назвах яких є слово Microsoft, але немає слова Windows
SELECT * FROM lab1.work WHERE Name LIKE '%Microsoft%' AND Name NOT LIKE '%Windows%';

-- 18. Вивести книги, в назвах яких присутня як мінімум одна цифра.
SELECT * FROM lab1.work WHERE Name REGEXP '[0-9]';

-- 19. Вивести книги, в назвах яких присутні не менше трьох цифр.
SELECT * FROM lab1.work WHERE Name REGEXP '([0-9].*){3}';

-- 20. Вивести книги, в назвах яких присутній рівно п'ять цифр
SELECT * FROM lab1.work WHERE Name REGEXP '([0-9].*){5}' AND Name NOT REGEXP '([0-9].*){6}';