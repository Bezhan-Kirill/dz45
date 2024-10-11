SELECT Секции.Название, COUNT(Инструкторы.id_секции)
FROM Секции, Инструкторы
WHERE Секции.id_секции = Инструкторы.id_секции
GROUP BY Секции.Название



SELECT Расписание.дата AS 'дата', Расписание.время AS 'время', Секции.Название, COUNT(Посетители.id_секции) AS 'Количество посетителей'
FROM Расписание, Посетители, Секции
WHERE Расписание.дата = '2024-01-15' AND Расписание.время = '11:00:00' AND Расписание.id_секции = Секции.id_секции AND Секции.id_секции = Посетители.id_секции
GROUP BY Расписание.дата, Расписание.время, Секции.Название



SELECT COUNT(*) AS 'пользуются услугами определенного мобильного оператора'
FROM Посетители
WHERE телефон LIKE '%996%' or телефон LIKE '%995%' or телефон LIKE '%999%'



SELECT COUNT(*) Количество
FROM Посетители
WHERE Фамилия IN ('Иванов', 'Борисов', 'Денисов');



SELECT Посетители.Имя, COUNT(*), Инструкторы.Имя +' '+ Инструкторы.Фамилия
FROM Посетители, Инструкторы
WHERE Посетители.id_секции = Инструкторы.id_секции AND Инструкторы.Имя = 'Валерий'
GROUP BY Посетители.Имя, Инструкторы.Имя, Инструкторы.Фамилия
HAVING COUNT(*) > 1;



SELECT Посетители.Имя, Посетители.Фамилия, Посетители.телефон, COUNT(*) Мин_посещений
FROM Посетители INNER JOIN Журнал_посещений
ON Посетители.id_посетителя = Журнал_посещений.id_посетителя
GROUP BY Посетители.Имя, Посетители.Фамилия, Посетители.телефон
HAVING COUNT(*) =(
	SELECT MIN(Посещений.Мин_посещений) FROM (
		SELECT COUNT(*) Мин_посещений
		FROM Журнал_посещений
		GROUP BY Журнал_посещений.id_посетителя
	) Посещений
);



SELECT COUNT(Посетители.id_посетителя) AS 'Число посетителей в определенной секции за первую половину текущего года',Секции.Название AS Секция, 2024 AS 'Год'
FROM Посетители, Журнал_посещений, Расписание, Секции
WHERE Посетители.id_посетителя = Журнал_посещений.id_посетителя AND Журнал_посещений.id_занятия = Расписание.id_занятия AND Расписание.дата > '2024-01-01' AND Расписание.дата < '2024-06-30' AND Секции.id_секции = 1
GROUP BY Секции.Название



SELECT COUNT(Посетители.id_посетителя) AS 'Число посетителей за год', 2023 AS 'Год'
FROM Посетители, Журнал_посещений, Расписание
WHERE Посетители.id_посетителя = Журнал_посещений.id_посетителя AND Журнал_посещений.id_занятия = Расписание.id_занятия AND Расписание.дата > '2023-01-01' AND Расписание.дата < '2023-12-31'
