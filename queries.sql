""" Задача 2. Простые выборки: """
SELECT contact_name, country FROM customers
--1) "имя контакта" и "город" (contact_name, country) из таблицы customers (ТОЛЬКО ЭТИ ДВЕ КОЛОНКИ)

SELECT order_id, (shipped_date - order_date) AS difference FROM orders
--2) идентификатор заказа и разницу между датами формирования (order) заказа и его отгрузкой (shipped_date) из таблицы orders

SELECT DISTINCT city FROM customers
--3) все города без повторов, в которых зарегистрированы заказчики (customers)

SELECT COUNT(*) FROM orders
--4) количество заказов (таблица orders)

SELECT COUNT(*) AS ship_country FROM orders
--5) количество стран, в которые отгружался товар (таблица orders, колонка ship_country)

""" Задача 3. Фильтрация и сортировка """
SELECT * FROM orders WHERE ship_country IN ('France', 'Germany', 'Spain')
--1) заказы, доставленные в страны France, Germany, Spain (таблица orders, колонка ship_country)

SELECT DISTINCT ship_country, ship_city FROM orders
--2) уникальные города и страны, куда отправлялись заказы, отсортировать по странам и городам (таблица orders, колонки ship_country, ship_city)

SELECT AVG (shipped_date - order_date) FROM orders WHERE ship_country = 'Germany'
--3) сколько дней в среднем уходит на доставку товара в Германию (таблица orders, колонки order_date, shipped_date, ship_country)

SELECT MIN(unit_price), MAX(unit_price) FROM products WHERE discontinued != 1
--4) минимальную и максимальную цену среди продуктов, не снятых с продажи (таблица products, колонки unit_price, discontinued не равно 1)

SELECT MIN(unit_price), MAX(unit_price) FROM products WHERE discontinued != 1 AND units_in_stock >= 20

""" Задача 4. Фильтрация по шаблону и группировка """
SELECT DISTINCT ship_city, ship_country FROM orders WHERE ship_city LIKE '%burg'
--1) заказы, отправленные в города, заканчивающиеся на 'burg'. Вывести без повторений две колонки (город, страна) (см.таблица orders, колонки ship_city, ship_country)

SELECT order_id, customer_id, freight, ship_country FROM orders WHERE ship_country LIKE 'P%' ORDER BY freight DESC LIMIT 10
--2) из таблицы orders идентификатор заказа, идентификатор заказчика, вес и страну отгрузки. Заказ отгружен в страны, начинающиеся на "Р". Результат отсортирован по весу (по убыванию). Вывести первые 10 записей.

SELECT last_name, home_phone FROM employees WHERE region IS NULL
--3) фамилию и телефон сотрудников, у которых в данных отсутствует регион (см. таблицу employees)

SELECT country, COUNT(*) FROM suppliers GROUP BY country ORDER BY COUNT(*) DESC
--4) количество поставщиков (suppliers) в каждой из стран. Результат отсортировать по убыванию количества поставщиков в стране.

SELECT SUM(ship_via * freight), ship_country FROM orders WHERE ship_region IS NOT NULL GROUP BY ship_country HAVING SUM(ship_via * freight) > 2750 ORDER BY SUM(ship_via * freight) DESC
--5) суммарный вес заказов (в которых известен регион) по странам, но вывести только те результаты, где суммарный вес на страну больше 2750. Отсортировать по убыванию суммарного веса (см. таблицу orders, колонки ship_region, ship_country, freight)

SELECT country FROM customers UNION SELECT country FROM suppliers UNION SELECT country FROM employees
--6) страны, в которых зарегистрированы и заказчики (customers) и поставщики (suppliers) и работники (employees).

SELECT country FROM customers INTERSECT SELECT country FROM suppliers EXCEPT SELECT country FROM employees
--7) страны, в которых зарегистрированы и заказчики (customers) и поставщики (suppliers), но не зарегистрированы работники (employees).
