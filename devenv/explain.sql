-- Удаление существующей таблицы, если она есть
DROP TABLE IF EXISTS Users;

-- Создание таблицы
CREATE TABLE Users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    age INT,
    city VARCHAR(100)
);

-- Функция для генерации случайных данных
CREATE OR REPLACE FUNCTION generate_random_users(count INT) RETURNS VOID AS $$
DECLARE
    i INT;
    random_name TEXT;
    random_email TEXT;
    random_age INT;
    random_city TEXT;
    cities TEXT[] := ARRAY['New York', 'Los Angeles', 'Chicago', 'Houston', 'Phoenix'];
BEGIN
    FOR i IN 1..count LOOP
        random_name := 'User' || i;
        random_email := 'user' || i || '@example.com';
        random_age := (RANDOM() * 70 + 18)::INT;
        random_city := cities[(RANDOM() * array_length(cities, 1) + 1)::INT];
        INSERT INTO Users (name, email, age, city)
        VALUES (random_name, random_email, random_age, random_city);
    END LOOP;
END;
$$ LANGUAGE plpgsql;

-- Генерация 10000 пользователей
SELECT generate_random_users(10000);


EXPLAIN ANALYZE
SELECT city, AVG(age) as average_age
FROM Users
WHERE registration_date > NOW() - INTERVAL '1 year'
GROUP BY city
HAVING COUNT(*) > 100
ORDER BY average_age DESC;
