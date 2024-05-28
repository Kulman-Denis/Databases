-- 1. Вивести загальну статистику по всіх книгах
SELECT  
    COUNT(*) AS TotalBooks,
    SUM(Price) AS TotalValue,
    AVG(Price) AS AveragePrice,
    MIN(Price) AS MinPrice,
    MAX(Price) AS MaxPrice 
FROM lab1.work;

-- 2. Вивести загальну кількість книг з встановленою ціною
SELECT COUNT(*) AS BooksWithPrice FROM lab1.work WHERE Price IS NOT NULL;

-- 3. Вивести статистику для книг новинок та не новинок
SELECT  
    New AS New,
    COUNT(*) AS TotalBooks,
    SUM(Price) AS TotalValue,
    AVG(Price) AS AveragePrice,
    MIN(Price) AS MinPrice,
    MAX(Price) AS MaxPrice
FROM lab1.work 
GROUP BY New;

-- 4. Вивести статистику по роках видання
SELECT  
    YEAR(Date) AS Year,
    COUNT(*) AS TotalBooks,
    SUM(Price) AS TotalValue,
    AVG(Price) AS AveragePrice,
    MIN(Price) AS MinPrice,
    MAX(Price) AS MaxPrice
FROM lab1.work 
GROUP BY YEAR(Date);

-- 5. Виключити книги з ціною від 10 до 20 та вивести статистику по роках видання
SELECT  
    YEAR(Date) AS Year,
    COUNT(*) AS TotalBooks,
    SUM(Price) AS TotalValue,
    AVG(Price) AS AveragePrice,
    MIN(Price) AS MinPrice,
    MAX(Price) AS MaxPrice
FROM lab1.work 
WHERE Price NOT BETWEEN 10 AND 20 
GROUP BY YEAR(Date);

-- 6. Відсортувати статистику по спадаючій кількості
SELECT  
    YEAR(Date) AS Year,
    COUNT(*) AS TotalBooks,
    SUM(Price) AS TotalValue,
    AVG(Price) AS AveragePrice,
    MIN(Price) AS MinPrice,
    MAX(Price) AS MaxPrice
FROM lab1.work 
WHERE Price NOT BETWEEN 10 AND 20 
GROUP BY YEAR(Date)
ORDER BY TotalBooks DESC;

-- 7. Вивести загальну кількість кодів книг і кодів книг що не повторюються
SELECT 
    COUNT(Cod) AS TotalBookCodes,
    COUNT(DISTINCT Cod) AS UniqueBookCodes 
FROM lab1.work;

-- 8. Вивести статистику по першій букві назви книги
SELECT 
    LEFT(Name, 1) AS FirstLetter,
    COUNT(*) AS TotalBooks,
    SUM(Price) AS TotalValue 
FROM lab1.work 
GROUP BY FirstLetter;

-- 9. Виключити книги, назви яких починаються з англійської букви або цифри
SELECT 
    LEFT(Name, 1) AS FirstLetter,
    COUNT(*) AS TotalBooks,
    SUM(Price) AS TotalValue 
FROM lab1.work 
WHERE NOT (LEFT(Name, 1) REGEXP '^[a-zA-Z0-9]')
GROUP BY FirstLetter;

-- 10. Включити тільки книги з роками видання більше 2000
SELECT 
    LEFT(Name, 1) AS FirstLetter,
    COUNT(*) AS TotalBooks,
    SUM(Price) AS TotalValue 
FROM lab1.work 
WHERE NOT (LEFT(Name, 1) REGEXP '^[a-zA-Z0-9]') 
AND YEAR(Date) >= 2000
GROUP BY FirstLetter;

-- 11. Відсортувати статистику по спадаючій першій букві назви
SELECT 
    LEFT(Name, 1) AS FirstLetter,
    COUNT(*) AS TotalBooks,
    SUM(Price) AS TotalValue 
FROM lab1.work 
WHERE NOT (LEFT(Name, 1) REGEXP '^[a-zA-Z0-9]') 
AND YEAR(Date) >= 2000
GROUP BY FirstLetter
ORDER BY FirstLetter DESC;

-- 12. Вивести статистику по місяцях і роках видання
SELECT  
    YEAR(Date) AS Year,
    MONTH(Date) AS Month,
    COUNT(*) AS TotalBooks,
    SUM(Price) AS TotalValue,
    AVG(Price) AS AveragePrice,
    MIN(Price) AS MinPrice,
    MAX(Price) AS MaxPrice
FROM lab1.work 
GROUP BY Year, Month;

-- 13. Виключити дані з незаповненими датами
SELECT  
    YEAR(Date) AS Year,
    MONTH(Date) AS Month,
    COUNT(*) AS TotalBooks,
    SUM(Price) AS TotalValue,
    AVG(Price) AS AveragePrice,
    MIN(Price) AS MinPrice,
    MAX(Price) AS MaxPrice
FROM lab1.work 
WHERE Date IS NOT NULL
GROUP BY Year, Month;

-- 14. Фільтр по спадаючому року і зростанню місяця
SELECT  
    YEAR(Date) AS Year,
    MONTH(Date) AS Month,
    COUNT(*) AS TotalBooks,
    SUM(Price) AS TotalValue,
    AVG(Price) AS AveragePrice,
    MIN(Price) AS MinPrice,
    MAX(Price) AS MaxPrice
FROM lab1.work 
WHERE Date IS NOT NULL
GROUP BY Year, Month
ORDER BY Year DESC, Month ASC;

-- 15. Статистика для новинок з конвертацією цін в грн, євро та руб.
SELECT  
    New AS IsNew,
    COUNT(*) AS TotalBooks,
    SUM(Price) AS TotalValue,
    SUM(Price * 38.90) AS TotalValueUAH,
    SUM(Price * 0.93) AS TotalValueEUR,
    SUM(Price * 0.42) AS TotalValueRUB
FROM lab1.work 
GROUP BY IsNew;

-- 16. Округлення цін до цілого числа
SELECT  
    New AS IsNew,
    COUNT(*) AS TotalBooks,
    SUM(Price) AS TotalValue,
    ROUND(SUM(Price * 38.90), 0) AS TotalValueUAH,
    ROUND(SUM(Price * 0.93), 0) AS TotalValueEUR,
    ROUND(SUM(Price * 0.42), 0) AS TotalValueRUB
FROM lab1.work 
GROUP BY IsNew;

-- 17. Вивести статистику по видавництвах
SELECT
Producer AS Publisher,
COUNT(*) AS TotalBooks,
SUM(Price) AS TotalValue,
AVG(Price) AS AveragePrice,
MIN(Price) AS MinPrice,
MAX(Price) AS MaxPrice
FROM lab1.work
GROUP BY Publisher;

-- 18. Вивести статистику за темами і видавництвами
SELECT
Producer AS Publisher,
Topic,
COUNT(*) AS TotalBooks,
SUM(Price) AS TotalValue,
AVG(Price) AS AveragePrice,
MIN(Price) AS MinPrice,
MAX(Price) AS MaxPrice
FROM lab1.work
GROUP BY Publisher, Topic
ORDER BY Publisher, Topic;

-- 19. Вивести статистику за категоріями, темами і видавництвами
SELECT
Producer AS Publisher,
Topic,
Category,
COUNT(*) AS TotalBooks,
SUM(Price) AS TotalValue,
AVG(Price) AS AveragePrice,
MIN(Price) AS MinPrice,
MAX(Price) AS MaxPrice
FROM lab1.work
GROUP BY Publisher, Topic, Category
ORDER BY Publisher, Topic, Category;

-- 20. Вивести список видавництв з ціною сторінки більше 10 копійок
SELECT DISTINCT Producer FROM lab1.work WHERE ROUND(Price / Pages, 2) > 0.10;