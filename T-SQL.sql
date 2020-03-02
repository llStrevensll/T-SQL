/*
/*Clausula SELECT y FROM */
select * from Production.Product

select [Name] + ' ' + Color as NombreColor 
from Production.Product

select [Name], ListPrice * 2 as [precio doble] 
from Production.Product

select distinct Color
from Production.Product

/*CASE */
select [Name], ListPrice, [Weight], FinishedGoodsFlag as Estado
from Production.Product

select [Name], ListPrice, [Weight], CASE FinishedGoodsFlag
									WHEN 0 THEN 'No Disponible'
									WHEN 1 THEN 'Disponible'
									END as Estado
from Production.Product
select [Name], CASE 
				WHEN ListPrice < 200 then 'Barato'
				WHEN ListPrice < 500 then 'Aceptable'
				WHEN ListPrice > 500 THEN 'Caro'
				END as Precio,[Weight], CASE FinishedGoodsFlag
									WHEN 0 THEN 'No Disponible'
									WHEN 1 THEN 'Disponible'
									END as Estado
from Production.Product

select [Name], CASE 
				WHEN ListPrice < 200 then 'Barato'
				WHEN ListPrice < 500 then 'Aceptable'
				ELSE 'Caro'
				END as Precio, CASE
								WHEN [Weight] < 200 THEN 'Ligero'
								WHEN [Weight] < 500 THEN 'Peso Medio'
								WHEN [Weight] is null THEN 'No Definido'
								ELSE 'Pesado'
								END as Peso, CASE FinishedGoodsFlag
									WHEN 0 THEN 'No Disponible'
									WHEN 1 THEN 'Disponible'
									END as Estado
from Production.Product*/

/* FECHAS */
/*obtener fechas get
	getdate - propietario de tsql
	current_timestamp - estandar de sql
*/
/*
select GETDATE()
select CURRENT_TIMESTAMP;*/
/*
select SYSDATETIME()
select SYSDATETIMEOFFSET()*/
/*
select GETUTCDATE()
select SYSUTCDATETIME()*/

/*CAST O CONVERT
Solo fecha
solo hora*/
/*
select (CAST(GETDATE() AS DATE))
select (CONVERT(DATE, GETDATE()))

select (CAST(GETDATE() AS TIME))
select (CONVERT(TIME, GETDATE()))*/

/*DATEPART - MONTH DAY YEAR  - DATENAME
parte en especifico de la fecha
*/
/*
select DATEPART(MONTH, '19911103') as Mes

select DATEPART(DAY, GETDATE()) as Dia

select DATEPART(YEAR, GETDATE()) as Año

select DATEPART(DAYOFYEAR, GETDATE()) as [Dia del Año]

select DATEPART(WEEK, GETDATE()) as [Semana del Año]

SELECT MONTH('19911103') as Mes
SELECT DAY(GETDATE()) as Día
SELECT YEAR(GETDATE()) as Año

select DATENAME(MONTH, '19911103') as Mes
select DATENAME(WEEKDAY, GETDATE()) as Dia
select DATENAME(YEAR, GETDATE()) as Año*/

/*DATEADD DATEDIFF SWITCHOFFSET TODATETIMEOFFSET
*/
/*
SELECT DATEADD(MONTH, 1, '19911103')
SELECT DATENAME(MONTH, DATEADD(MONTH, 2, '19911103'))
SELECT DATEADD(YEAR, 1, '19911103')

SELECT DATEDIFF(MONTH, '19980513', GETDATE()) / 12

SELECT SWITCHOFFSET('2019-02-15 17:00:00 -04:00', '-07:00')
SELECT SYSDATETIMEOFFSET()
SELECT SWITCHOFFSET(SYSDATETIMEOFFSET(), '+01:00')

SELECT SWITCHOFFSET('2019-02-15 17:00:00 -04:00', '-07:00')
SELECT TODATETIMEOFFSET('2019-02-15 17:00:00 -04:00', '-07:00')*/

/* COALESCE  - ISNULL*/
/*COALESCE : returna la primera expresion dentro de una lista que no sea nula
ISNULL: TOMA DOS PARAMETROS, si el orimero es null , retorna el segundo*/
/*
SELECT COALESCE(null, null, 'Sandielly', null, 'Diana') as Nombre

select [Name], color, coalesce([Name] + ' - ' + Color, [Name] + ' - ' + 'Color No Especificado') as [Nombre y Color]
from Production.Product

select [Name], color, isnull([Name] + ' - ' + Color, [Name] + ' - ' + 'Color No Especificado') as [Nombre y Color]
from Production.Product*/

/* NULLIF */
/*retorna null si los parametros son iguales*/
/*
select NULLIF('sandy', 'w')
select NULLIF(10,10)
select NULLIF('2019210', '2019210')

select [Name], MakeFlag, FinishedGoodsFlag, NULLIF(MakeFlag, FinishedGoodsFlag) AS [Nulo si son iguales]
FROM Production.Product*/

/* SUBSTRING - LEFT - RIGHT */
/*SUBSTRING - Extreaer caracteres en relacion a posiciones especificadas*/
/*LEFT,RIGHT Extrae segun la direccion*/
/*
select SUBSTRING('Strevens Full',1,8) as [Texto extraido]

select LEFT('Strevens', 4) as [Texto extraido]

select RIGHT('Strevens', 4) as [Texto extraido]*/

/* CHARINDEX, PATININDEX */
/*CHARINDEX-Retorna la posición en donde se encuentra la primera ocurrencia de un caracter*/
/*PATINDEX-Retorna la posición en donde se encuentra la primera ocurrencia de un Patrón*/
/*
select CHARINDEX('r', 'Strevens Full') as [Indice]

select LEFT('Strevens Full', CHARINDEX(' ','Strevens Full') -1)/*-1 para quitar tambien el espacio*/

select * from Production.ProductReview
select LEFT(ReviewerName, 
						CASE WHEN CHARINDEX(' ', ReviewerName) = 0 then LEN(ReviewerName)
						ELSE CHARINDEX(' ', ReviewerName) -1 end)
from Production.ProductReview


select PATINDEX('%.com%', 'favor enviar los datos a correo.@email.com y adjuntar la factura del mes pasado')

select PATINDEX('%[0-9]%','strevens839230')

select PATINDEX('%___-___-____%', 'MI NUMERO ES 809-556-5612 agregame!')*/


/* LEN,REPLACE, REPLICATE, STUFF */
/*STUFF: Elimina cierta porción de caracteres que le especifiquemos y le insertamos un texto en su lugar*/
/*select LEN('Strevens Full') as Longitud

select LEN([Name]) as longitud
from Production.Product

select REPLACE('Strevens Full',' ','-') as Nombre

select [Name], REPLACE(ProductNumber, '-', '/')
from Production.Product

select Replicate('hola!', 5) 

select STUFF('123456789', 1, 5, 'aquí habían numeros ') as [STUFF]

select STUFF('1234-5678-7894-5412', 1, 15, 'XXXX-XXXX-XXXX-') as [STUFF]
select STUFF('1234-5678-7894-5412', 1, 15, 'Visa ending in ') as [STUFF]

select * from Production.ProductReview
select ReviewerName, STUFF(EmailAddress, 4, LEN(EmailAddress) - 6, '*****') as [Email]
from Production.ProductReview*/

/* WHERE */
/*
select * from Production.Product where Color = 'Red'
select * from Production.Product where ListPrice < 1000
select *
from Production.Product
where ListPrice - (ListPrice * 0.2) > 500

select [Name], ListPrice
from Production.Product
where color is null*/


/* WHERE combinar condiciones*/
/*
select [Name], Color, [Weight]
from Production.Product
where Color = 'Red' and [Weight] < 100

select [Name], Color, [Weight]
from Production.Product
where Color = 'Red' or [Weight] < 100

select [Name], Color, [Weight]
from Production.Product
where (Color = 'Red' and [Weight] < 100) or (Color = 'silver' and [Weight] < 100)*/

/* LIKE, BETWEEN */
/*
select FirstName, MiddleName, LastName
from Person.Person
where FirstName like 'P%'/*Inicia con P*/

select FirstName, MiddleName, LastName
from Person.Person
where FirstName like '%P'/*Finaliza con P*/

select FirstName, MiddleName, LastName
from Person.Person
where FirstName not like '%P'/*Finaliza con P*/

select *
from Production.Product
where ListPrice between 100 and 500

select * 
from sales.SalesOrderHeader
where OrderDate between '20110501' and '20110701'

select * 
from sales.SalesOrderHeader
where OrderDate not between '20110501' and '20110701'
*/

/* IN, EXIST */
/*
select * from Production.Product where Color in('red','black','yellow')

select * from Sales.SalesOrderDetail 
where ProductID in(select ProductID from Production.Product where ListPrice < 100)

select * from Sales.SalesOrderDetail 
where ProductID not in(select ProductID from Production.Product where ListPrice < 100)

/*si existe el id mostrara toda la tabla Customer*/
select * from Sales.Customer
where exists(select * from Person.Person where BusinessEntityID = 5454)

select * from Sales.Customer
where exists(select * from Person.Person where BusinessEntityID = 000)*/

/* ORDER BY */
/*
select CustomerID, datename(MONTH, OrderDate) as Mes, TotalDue as Monto
from Sales.SalesOrderHeader
where CustomerID = 29994
order by Mes

select CustomerID, datename(MONTH, OrderDate) as Mes, TotalDue as Monto
from Sales.SalesOrderHeader
where CustomerID = 29994
order by Mes, Monto desc /*mes asc y monto desc */
*/

/* TOP & OFFSET-FETCH */
/*
select top(5) CustomerID, OrderDate as fecha, TotalDue as Monto
from Sales.SalesOrderHeader
where CustomerID = 29994
order by fecha desc
/*50 porciento son 12 registros entonces mostrara 6*/
select top(50) percent CustomerID, OrderDate as fecha, TotalDue as Monto
from Sales.SalesOrderHeader
where CustomerID = 29994
order by fecha desc

select CustomerID, OrderDate as fecha, TotalDue as Monto
from Sales.SalesOrderHeader
where CustomerID = 29994
order by CustomerID desc
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY

select CustomerID, OrderDate as fecha, TotalDue as Monto
from Sales.SalesOrderHeader
where CustomerID = 29994
order by CustomerID desc
OFFSET 5 ROWS /*Filas desde la 5 en adelante*/

select CustomerID, OrderDate as fecha, TotalDue as Monto,
		ROW_NUMBER() over(order by CustomerID) as numero
from Sales.SalesOrderHeader
where YEAR(OrderDate) = 2011
order by numero
OFFSET (0*25) ROWS FETCH NEXT 25 ROWS ONLY*/

/* INNER JOIN */
/*
select P.[Name], P.ListPrice, S.[Name] as SubCategory
from Production.Product as P
	inner join Production.ProductSubcategory as S
	on P.ProductSubcategoryID = S.ProductSubcategoryID

select P.[Name], P.ListPrice, S.[Name] as SubCategory
from Production.Product as P
	inner join Production.ProductSubcategory as S
	on P.ProductSubcategoryID = S.ProductSubcategoryID
Where P.ListPrice > 1000*/

/* LEFT & RIGHT OUTER JOIN */
/*
select P.[Name] as articulo, M.[Name] as modelo
from Production.Product as P
	left join Production.ProductModel as M
	on m.ProductModelID = p.ProductModelID


select P.[Name] as articulo, M.[Name] as modelo
from Production.Product as P
	right join Production.ProductModel as M
	on m.ProductModelID = p.ProductModelID
*/

/* CROSS JOIN(FULL JOIN) & UNION MULTIPLE*/
/*
select * from Production.ProductCategory
select P1.[Name] as Cat1, p2.[Name] as Cat2
from Production.ProductCategory as P1
 cross join Production.ProductCategory as p2

select P.[Name] as Articulo, S.[Name] as SubCategory, C.[Name] as Category
from Production.Product as P
inner join Production.ProductSubcategory as S
	on P.ProductSubcategoryID = S.ProductSubcategoryID
inner join Production.ProductCategory as C
	on S.ProductCategoryID = C.ProductCategoryID*/

/* Subconsulta Independiente */
/*
select *
from Sales.SalesOrderDetail
where ProductID = (select top(1) ProductID
					from Production.Product
					order by ListPrice desc) /*retorna un unico valor*/

select *
from Sales.SalesOrderHeader
where CustomerID IN(select CustomerID
					from Sales.Customer
					where TerritoryID = 2)*/

/* Subconsultas correlacionadas */
/*
select P1.[Name], ListPrice, ProductSubcategoryID
from Production.Product as P1
where P1.ListPrice = (select MAX(ListPrice)
						from Production.Product as P2
						where P1.ProductSubcategoryID = P2.ProductSubcategoryID)

select *
from Production.Product as T1
where ListPrice > (select AVG(ListPrice)
					from Production.Product as T2
					where T2.Color = T1.Color)
*/

/*Tablas Derivadas*/
/*
select * 
from(select CustomerID,
		TotalDue,
		case when TotalDue < 62000 then 'Plata'
			 when TotalDue < 124000 then 'Oro'
			 when TotalDue > 124000 then 'Diamante'
			 end as Categoria
from Sales.SalesOrderHeader) as Ordenes
where Categoria = 'Plata'

select Persona.Firstname + ' ' + Persona.LastName as Cliente, Ordenes.Categoria
from(select CustomerID,
		TotalDue,
		case when TotalDue < 62000 then 'Plata'
			 when TotalDue < 124000 then 'Oro'
			 when TotalDue > 124000 then 'Diamante'
			 end as Categoria
	from Sales.SalesOrderHeader) as Ordenes
join Sales.Customer as Clientes
on Ordenes.CustomerID = Clientes.CustomerID
join Person.Person as Persona
on Clientes.PersonID = Persona.BusinessEntityID
*/

/* CTEs */
/*
With Ordenes as
(select CustomerID,
		TotalDue,
		case when TotalDue < 62000 then 'Plata'
			 when TotalDue < 124000 then 'Oro'
			 when TotalDue > 124000 then 'Diamante'
			 end as Categoria
from Sales.SalesOrderHeader
)select CustomerID, Categoria 
	from Ordenes as Ordenes
	where Categoria = 'Plata'*/

/*2 CTEs*/
/*
With Ordenes as
(select CustomerID,
		TotalDue,
		case when TotalDue < 62000 then 'Plata'
			 when TotalDue < 124000 then 'Oro'
			 when TotalDue > 124000 then 'Diamante'
			 end as Categoria
from Sales.SalesOrderHeader
), Ordenes2 as
(select CustomerID, Categoria 
	from Ordenes
	where Categoria = 'Oro') select * 
								from Ordenes2*/

/* Vistas y Funciones */
/*
Create View Sales.VGetClienteCategoria
as
select * 
from(select CustomerID,
		TotalDue,
		case when TotalDue < 62000 then 'Plata'
			 when TotalDue < 124000 then 'Oro'
			 when TotalDue > 124000 then 'Diamante'
			 end as Categoria
from Sales.SalesOrderHeader) as Ordenes
where Categoria = 'Plata'*/

/*select * from Sales.VGetClienteCategoria*/
/*Create Function Sales.fGetClienteCategoria1(@categoria as varchar(10)) returns table
as
return
With Ordenes as
(select CustomerID,
		TotalDue,
		case when TotalDue < 62000 then 'Plata'
			 when TotalDue < 124000 then 'Oro'
			 when TotalDue > 124000 then 'Diamante'
			 end as Categoria
from Sales.SalesOrderHeader
)select CustomerID, Categoria 
	from Ordenes as Ordenes
	where Categoria = @categoria*/

/*select * from Sales.fGetClienteCategoria1('Plata')
select * from Sales.fGetClienteCategoria1('Oro')
select * from Sales.fGetClienteCategoria1('Diamante')*/


