-- Esto correrá en sql server


------------------------------------------------------------
/*
SECCION 0. CABECERA DEL SCRIPT
Proposito:
- Definir una cabecera uniforme para todos los scripts del curso.
- Garantizar que cada archivo comience con contexto claro.
- Facilitar lectura, mantenimiento y auditoria de scripts SQL.

Contenido:
- Nombre del proyecto o base de datos.
- Fecha de generacion del script.
- Autor o responsable.
- Descripcion breve del objetivo del archivo.
- Advertencias sobre operaciones destructivas.
- Notas sobre dependencias o prerrequisitos.

Buenas practicas:
- Mantener esta cabecera en ASCII puro.
- No incluir informacion sensible.
- Actualizar fecha y descripcion segun el contenido del script.
- Usar esta seccion como plantilla base para todos los capitulos.

Ejemplo de uso:
-- Colocar esta cabecera al inicio de cada archivo .sql
-- Luego incluir SECCION 1, SECCION 2, etc.

============================================================
*/
------------------------------------------------------------

use master
go

-- Si la base bd_intro existe:
-- 1. La pone en SINGLE_USER
-- 2. Desconecta a todos (ROLLBACK IMMEDIATE)
-- 3. La elimina
if exists (select 1 from sys.databases where name = 'bd_intro')
begin
alter database bd_intro set single_user with rollback immediate;
drop database bd_intro;
end
go

-- Crea la base de datos bd_intro desde cero
create database bd_intro;
go

-- Cambia el contexto a la nueva base
use bd_intro;
go

/*
SECCIÓN 1. CREACIÓN DE TABLAS Y TIPOS DE DATOS
Objetivos:
- Aprender a crear tablas y definir tipos de datos en SQL Server.
- Comprender la diferencia entre columnas obligatorias y opcionales.
- Reconocer claves primarias y sintaxis de lote con GO.

Conceptos:
CREATE TABLE: sirve para definir una nueva tabla con sus columnas.
PRIMARY KEY: asegura que cada valor es único y no puede repetirse.
NOT NULL/NULL: indica si una columna puede aceptar valores nulos.
GO: separa bloques de ejecución en SQL Server.

Errores frecuentes:
- No usar el tipo de dato adecuado para cada columna.
- Confundir NULL con cadenas vacías.
- No definir una clave primaria cuando el registro debe identificarse unívocamente.
============================================================
*/

CREATE TABLE Persona (
    Cedula           INTEGER PRIMARY KEY, -- PRIMARY KEY: NO SE REPITE, NO PUEDE SER NULL
    Nombre           VARCHAR(50) NOT NULL, -- CHAR, VARCHARN
    Apellido         VARCHAR(50) NOT NULL, -- CHAR, VARCHARN
    Direccion        VARCHAR(200) NULL, -- CHAR, VARCHARN, PUEDE SER NULO
    Telefono         VARCHAR(20) NOT NULL,
    FechaNacimiento  DATE NOT NULL -- DATE, DATETIME
)
GO

CREATE TABLE Producto (
    Producto     VARCHAR(10) PRIMARY KEY,
    Nombre       VARCHAR(100) NOT NULL,
    Descripcion  VARCHAR(255) NULL,
    Costo        DECIMAL(10,2) NOT NULL,
    Precio       DECIMAL(10,2) NOT NULL
);

CREATE TABLE Factura (
    NumeroFactura  INT PRIMARY KEY,
    Fecha          DATE NOT NULL,
    Cedula         INT,
    Sucursal       INT
);

CREATE TABLE Sucursal (
    Sucursal   INT PRIMARY KEY,
    Direccion  VARCHAR(200) NOT NULL,
    Nombre     VARCHAR(100) NOT NULL
);

/*
RESUMEN DE LA SECCIÓN
En esta sección se aprendió:
1. Cómo crear tablas en SQL Server con CREATE TABLE.
2. Cómo definir claves primarias con PRIMARY KEY.
3. Cómo usar NOT NULL y NULL para controlar la validez de datos.

Conceptos que deben dominarse antes de continuar:
- Estructura básica de una tabla.
- Tipos de datos simples (INTEGER, VARCHAR, DATE, DECIMAL).
- Propósito de la clave primaria.

---
*/

/*
SECCIÓN 2. INSERCIÓN DE DATOS
Objetivos:
- Aprender a insertar filas en tablas nuevas.
- Comprender el orden y los valores requeridos por cada columna.
- Identificar cuándo se usan valores nulos indirectamente.

Conceptos:
INSERT INTO: agrega nuevas filas a una tabla existente.
VALUES: contiene los datos que se almacenarán en cada columna.

Errores frecuentes:
- No respetar el orden de las columnas declaradas.
- Insertar valores en columnas que no admiten NULL sin proporcionar datos.
- Omitir comillas en valores de texto.
============================================================
*/

INSERT INTO PERSONA ( Cedula, Nombre, Apellido, Direccion, Telefono, FechaNacimiento)
VALUES 
(1,'Maurend', 'Bravo', 'Calle 51...', '1001', '2006-05-30'),
(2,'Diego', 'Mayor', 'Avenida 25...', '1002', '2008-04-29')
go

INSERT INTO PERSONA ( Cedula, Nombre, Apellido, Direccion, Telefono, FechaNacimiento)
VALUES  
(3,'Héctor', 'Manzano', 'Edificio...', '1003', '2007-05-30'),
(4,'Águeda', 'Cortés', 'C2...', '1004', '2008-04-29')
go

INSERT INTO PERSONA ( Cedula, Nombre, Apellido, Direccion, Telefono, FechaNacimiento)
VALUES  
(5,'Moisés', 'Manzano', 'Calle...', '1005', '2012-05-30')
go

INSERT INTO Producto (Producto, Nombre, Descripcion, Costo, Precio)
VALUES ('P001', 'Cebolla', 'Cebolla por kilo', 1.00, 1.50);
INSERT INTO Producto (Producto, Nombre, Descripcion, Costo, Precio)
VALUES ('P099', 'Tomate', 'Tomate por kilo', 1.03, 1.55);
INSERT INTO Producto (Producto, Nombre, Descripcion, Costo, Precio)
VALUES ('P055', 'Papas', 'Papas por kilo', 1.80, 2.70);
INSERT INTO Producto (Producto, Nombre, Descripcion, Costo, Precio)
VALUES ('P567', 'Queso', 'Queso por kilo', 1.99, 2.99);
INSERT INTO Producto (Producto, Nombre, Descripcion, Costo, Precio)
VALUES ('P333', 'Camisa Polo', 'Camisa individual', 3.00, 4.50);
go

INSERT INTO Sucursal (Sucursal, Direccion, Nombre)
VALUES
(99, 'Bella Vista...', 'Campoamor'),
(98, 'La Paragua...', 'El Rosal'),
(67, '5 de Julio...', 'La rebaja');

/*
RESUMEN DE LA SECCIÓN
En esta sección se aprendió:
1. Cómo insertar filas en las tablas Persona, Producto y Sucursal.
2. Que una tabla puede recibir varios registros en un mismo bloque de VALUES.
3. Que los valores deben coincidir con el orden y los tipos de las columnas.

Conceptos que deben dominarse antes de continuar:
- Sintaxis básica de INSERT INTO.
- Tipos de datos y formato de literales.
- Diferencia entre columnas NOT NULL y NULL.

---
*/

/*
SECCIÓN 3. CONSULTAS BÁSICAS
Objetivos:
- Aprender a leer datos con SELECT.
- Comprender la diferencia entre seleccionar todas las columnas y columnas específicas.
- Usar alias de tabla y alias de columnas.

Conceptos:
SELECT: extrae datos de una tabla.
FROM: indica la tabla o tablas de donde se obtienen los datos.
Alias: permite renombrar tablas o columnas temporalmente para consulta.

Errores frecuentes:
- Seleccionar columnas inexistentes.
- Olvidar la cláusula FROM.
- No usar alias cuando hay ambigüedad de nombres.
============================================================
*/

-- Muestra cedula, nombre y apellido de todas las personas
select cedula, nombre, apellido from persona
go

-- Muestra todas las columnas de la tabla persona
select * from persona
go

-- Muestra solo nombre, apellido y telefono de cada persona
select nombre, apellido, telefono from persona
go

-- Igual que el anterior, pero usando alias de tabla (p)
select p.nombre, p.apellido, p.telefono from persona AS p
go

-- Alias sin la palabra AS; funciona igual
select nombre, p.apellido, p.telefono from persona p
go

-- Muestra todas las columnas de persona
select * from Persona
go

-- Muestra todas las columnas de producto
select * from producto
go

-- Muestra todas las columnas de sucursal
SELECT * FROM SUCURSAL
go

/*
RESUMEN DE LA SECCIÓN
En esta sección se aprendió:
1. A consultar datos simples con SELECT.
2. A usar SELECT * para todas las columnas y columnas específicas para resultados más controlados.
3. A utilizar alias de tabla con AS o sin AS.

Conceptos que deben dominarse antes de continuar:
- Sintaxis básica de SELECT y FROM.
- Uso de alias para consultas más claras.
- Comprensión de la salida de SELECT *.

---
*/

/*
SECCION 4. FILTROS Y ORDENAMIENTO  
Objetivos:  
- Aprender a filtrar datos con WHERE.  
- Comprender ORDER BY y el orden ascendente/descendente.  
- Aplicar condiciones multiples.  
- Usar BETWEEN, NOT BETWEEN, LIKE, DISTINCT y TOP.  

Conceptos:  
WHERE: selecciona filas que cumplen condiciones.  
ORDER BY: ordena resultados por una o mas columnas.  
AND / OR / NOT: combinan condiciones logicas.  
BETWEEN: selecciona valores dentro de un rango.  
LIKE: busca patrones de texto.  
DISTINCT: elimina duplicados.  
TOP: limita la cantidad de filas devueltas.  

Errores frecuentes:  
- Usar = NULL o <> NULL (siempre falla).  
- Confundir BETWEEN con > y <.  
- No usar % correctamente en LIKE.  
- Pensar que TOP ordena por si mismo.  
- Ordenar por columnas que no existen.  
*/


-- Busca cedulas entre 1 y 3 usando comparaciones explicitas  
select * from persona where cedula >= 1 and cedula <= 3
go

-- Hace lo mismo pero usando BETWEEN (incluye los extremos)  
select * from persona where cedula between 1 and 3
go

-- Busca cedulas que NO estan entre 1 y 3 usando negacion  
select * from persona where not ( cedula >= 1 and cedula <= 3 )
go

-- Hace lo mismo pero usando NOT BETWEEN  
select * from persona where cedula not between 1 and 3
go


-- Busca apellidos que comienzan con M  
-- % significa "cualquier cosa despues"  
select * from persona where apellido like 'M%'

-- Busca apellidos que terminan en o  
-- % al inicio significa "cualquier cosa antes"  
select * from persona where apellido like '%o'

-- Busca apellidos que comienzan con M y terminan en o  
select * from persona where apellido like 'M%o'

-- Busca apellidos que NO cumplen el patron anterior  
select * from persona where apellido not like 'M%o'

-- Busca apellidos donde la tercera letra es r  
-- _ representa exactamente un caracter  
select * from persona where apellido like '__r%'

-- Busca apellidos donde la tercera letra es r o y  
-- [ry] significa "r o y"  
select * from persona where apellido like '__[ry]%'
go


-- Muestra todos los apellidos, incluyendo repetidos  
select apellido from persona
go

-- Muestra solo apellidos sin repetir  
select distinct apellido from persona
go

-- Muestra las primeras 2 filas  
select top 2 * from persona
go

-- Muestra solo la primera fila  
select top 1 * from persona
go


-- Ordena por apellido ascendente  
select * from Persona
order by Apellido
go 

-- Filtra por cedula y ordena por apellido  
select * from Persona
where cedula = 1 or cedula = 4
order by Apellido
go 

-- Igual que el anterior pero orden descendente  
select * from Persona
where cedula = 1 or cedula = 4 or cedula = 5
order by Apellido DESC
go 

-- Filtra por apellido exacto y ordena por varias columnas  
select * from Persona
where Apellido = 'Manzano'
order by Apellido, Nombre DESC, Cedula
go 

-- Ordena por varias columnas sin filtro  
select * from Persona
order by Apellido, Nombre DESC, Cedula
go

/*
SECCIÓN 5. ALTER TABLE
Objetivos:
- Aprender a modificar la estructura de una tabla existente.
- Añadir y eliminar columnas.
- Establecer valores por defecto y restricciones de NULL.

Conceptos:
ALTER TABLE: modifica la definición de una tabla.
ADD COLUMN: agrega una nueva columna a una tabla existente.
DROP COLUMN: elimina una columna.
DEFAULT: asigna un valor predeterminado para nuevos registros.

Errores frecuentes:
- Agregar columnas con tipos incompatibles.
- Eliminar columnas que aún se usan en consultas.
- No prever el comportamiento de columnas NOT NULL.
============================================================
*/

-- Agrega la columna credito a persona, pero aun sin NOT NULL ni DEFAULT
alter table persona
add credito
numeric (12,2)
-- not null
-- default 0.0
go

-- Muestra la tabla persona con la nueva columna (tendra NULL en todas las filas)
select * from persona
go

-- Elimina la columna credito de la tabla persona
alter table persona drop column credito
go

-- Muestra la tabla persona nuevamente sin la columna
select * from persona
go

-- Agrega la columna credito correctamente: NOT NULL y con valor por defecto 0.0
alter table persona
add credito
numeric (12,2)
not null
default 0.0
go

-- Muestra la tabla persona con la columna credito ya inicializada en 0.0
select * from persona
go

-- Agrega la columna sucursal, que luego se usara como foreign key
-- Representa la sucursal donde la persona se inscribió, aunque puede comprar en cualquiera
alter table persona add sucursal integer
go

-- Muestra la tabla persona con la nueva columna sucursal
select * from persona
go

/*
RESUMEN DE LA SECCIÓN
En esta sección se aprendió:
1. A modificar la estructura de una tabla con ALTER TABLE.
2. A agregar y eliminar columnas.
3. A definir una columna con NOT NULL y DEFAULT.

Conceptos que deben dominarse antes de continuar:
- Cómo alterar columnas sin perder datos.
- El efecto de NOT NULL en columnas nuevas.
- Uso de SELECT después de cambios estructurales.

---
*/


/*
RESUMEN DE LA SECCION  
En esta seccion se aprendio:  
1. A filtrar filas con WHERE y operadores logicos.  
2. A ordenar resultados con ORDER BY.  
3. A usar BETWEEN, NOT BETWEEN, LIKE, DISTINCT y TOP.  

Conceptos que deben dominarse antes de continuar:  
- Diferencias entre BETWEEN y comparaciones directas.  
- Como funcionan los patrones de LIKE.  
- Como DISTINCT elimina duplicados.  
- Como TOP limita resultados sin ordenar por si mismo.  
*/

/*
SECCIÓN 6. FUNCIONES Y COLUMNAS CALCULADAS
Objetivos:
- Aprender a crear columnas calculadas en consultas.
- Usar funciones de fecha y expresiones aritméticas.
- Comprender alias de columnas en resultados.

Conceptos:
Columnas calculadas: expresiones que se evalúan en la consulta.
DATEDIFF: calcula la diferencia entre fechas.
Alias de columna: renombra el resultado de una expresión.

Errores frecuentes:
- Olvidar que las operaciones aritméticas siguen precedencia de operadores.
- Ordenar por números de columnas sin entender su posición.
- Confundir el nombre de las columnas reales con los alias.
============================================================
*/

-- Construye un nombre completo "Apellido, Nombre"
-- Calcula la edad usando DATEDIFF en años
-- Calcula un sueldo ficticio multiplicando la cedula por 100.75
-- Ordena primero por la columna 2 (edad) y luego por la columna 1 (completo)
select
Apellido + ', ' + Nombre as completo,
DATEDIFF ( year , FechaNacimiento , getdate() ) as edad,
cedula * 100.75 as sueldo
from persona
order by 2, 1
go

-- Muestra cedula y telefono
-- Calcula (1 + cedula/10) usando division entera (resultado truncado)
-- Calcula (1 + cedula/10.0) usando division decimal (resultado con decimales)
select cedula, telefono, (1+cedula/10), (1+cedula/10.0)
from persona
go

-- Muestra nombre, telefono, cedula y credito
-- Calcula un aumento del 10% (credito * 0.1)
-- Calcula el nuevo credito sumando el aumento
select nombre, telefono, cedula, credito, credito * 0.1 aumento, credito + credito * 0.1 nuevo, credito
from persona
go

/*
RESUMEN DE LA SECCIÓN
En esta sección se aprendió:
1. A crear columnas nuevas en la consulta usando expresiones.
2. A usar funciones como DATEDIFF para calcular valores de fecha.
3. A asignar alias para hacer los resultados más legibles.

Conceptos que deben dominarse antes de continuar:
- Expresiones aritméticas y de concatenación.
- Uso de alias de columna.
- Cómo SQL evalúa las expresiones en SELECT.

---
*/

/*
SECCIÓN 7. TABLAS ADICIONALES
Objetivos:
- Conocer más tablas y su uso en el modelo de datos.
- Entender que un sistema puede tener varias tablas relacionadas.
- Revisar el contenido de tablas sin datos y con datos.

Conceptos:
Una base de datos suele tener varias tablas que representan diferentes entidades.
SELECT * permite comprobar rápidamente los registros de cada tabla.

Errores frecuentes:
- Asumir que todas las tablas tienen datos.
- No revisar la estructura antes de usar una tabla en joins.
============================================================
*/

select * from factura 
go 

select * from persona 
go

select * from Sucursal
go

/*
RESUMEN DE LA SECCIÓN
En esta sección se aprendió:
1. A consultar diferentes tablas del mismo modelo.
2. A reconocer tablas con datos y tablas vacías.
3. A verificar que las tablas se crearon correctamente.

Conceptos que deben dominarse antes de continuar:
- Que el modelo de datos puede incluir varias tablas.
- Cómo usar SELECT * para inspeccionar datos.
- Qué es una tabla vacía.

---
*/

/*
SECCIÓN 8. UPDATE
Objetivos:
- Aprender a modificar datos existentes.
- Entender el impacto de UPDATE sin WHERE.
- Usar condiciones para actualizar solo los registros deseados.

Conceptos:
UPDATE: cambia valores de una o más filas.
SET: indica las columnas y los nuevos valores.
WHERE: filtra las filas que se modificarán.

Errores frecuentes:
- Olvidar WHERE y actualizar toda la tabla.
- Usar condiciones demasiado amplias o ambiguas.
- No revisar los datos antes de ejecutar UPDATE.
============================================================
*/

/*
ATENCIÓN
Este UPDATE modificará todos los registros de la tabla.
Este es uno de los errores más comunes en SQL.
Nunca ejecutar algo similar en producción sin verificar
la cláusula WHERE.
*/

-- Esto es terrible: actualiza la sucursal de todas las personas
-- Falta el WHERE, por eso afecta a toda la tabla
update persona set sucursal = 67 -- where cedula = 1
go

-- Muestra el resultado despues del UPDATE masivo
select * from persona
go

-- Actualiza solo a las personas con cedula 1 o 4
update persona set sucursal = 67 where cedula = 1 or cedula = 4
go

-- Actualiza a las personas con cedula 2 y 5 usando IN
update persona set sucursal = 98 where cedula in (2, 5)
go

-- Actualiza a la persona con cedula 3
update persona set sucursal = 99 where cedula = 3
go

-- Calcula credito usando telefono * (1 + cedula/10)
-- cedula/10 es division entera, por lo que trunca decimales
-- Esto produce resultados incorrectos si esperas decimales
update persona
set credito = telefono*(1+cedula/10)
go

-- Muestra los valores calculados con division entera
select * from persona
go

-- Corrige el calculo forzando division decimal con 10.0
-- Ahora cedula/10.0 produce decimales reales
update persona
set credito = telefono*(1+cedula/10.0)
go

-- Muestra los valores corregidos
select * from persona
go

/*
RESUMEN DE LA SECCIÓN
En esta sección se aprendió:
1. Cómo actualizar datos con UPDATE y SET.
2. El peligro de un UPDATE sin WHERE.
3. Cómo usar condiciones específicas como IN.

Conceptos que deben dominarse antes de continuar:
- Importancia de WHERE en UPDATE.
- Cómo aplicar operaciones aritméticas en SET.
- Validar qué filas se modificarán antes de ejecutar.

---
*/

/*
SECCIÓN 9. JOINS
Objetivos:
- Aprender a combinar información de varias tablas.
- Conocer la sintaxis clásica y la sintaxis JOIN.
- Comprender por qué se necesita desambiguar columnas.

Conceptos:
JOIN: relaciona filas de dos tablas con una condición.
INNER JOIN: devuelve filas que tienen coincidencias en ambas tablas.
Alias: permite identificar columnas de la tabla correcta.

Errores frecuentes:
- No incluir la condición de unión y obtener productos cartesianos.
- No usar alias cuando la misma columna existe en varias tablas.
- Confundir la sintaxis antigua con la moderna.
============================================================
*/

-- Muestra todas las filas y columnas de persona
select * from persona
go

-- Muestra todas las filas y columnas de sucursal
select * from Sucursal
go

-- JOIN implicito: une persona y sucursal usando coma
-- Filtra solo la persona con cedula = 1
-- Luego exige que la sucursal de la persona coincida con la sucursal de la tabla sucursal
select * from
persona AS p, sucursal AS s
where p.cedula = 1 and p.sucursal = s.sucursal
go

-- Igual que el anterior pero seleccionando columnas especificas
-- p.nombre, p.apellido, p.FechaNacimiento
-- s.nombre como sucursal y s.Direccion como d_sucursal
select p.nombre, p.apellido, p.FechaNacimiento, s.nombre as sucursal, s.Direccion as d_sucursal from
persona AS p, sucursal AS s
where p.cedula = 1 and p.sucursal = s.sucursal
go

-- JOIN explicito (forma moderna y recomendada)
-- INNER JOIN une solo las filas que cumplen la condicion ON
-- Es importante usar s.sucursal porque la columna existe en ambas tablas
-- Filtra personas con cedula > 2
select
p.Cedula, p.nombre, p.apellido, p.FechaNacimiento, s.nombre as sucursal,
s.sucursal, s.Direccion as d_sucursal from
persona AS p
inner join
sucursal AS s
on p.sucursal = s.sucursal
where p.cedula > 2
go

/*
RESUMEN DE LA SECCIÓN
En esta sección se aprendió:
1. A combinar tablas con JOIN.
2. A usar alias para distinguir columnas con el mismo nombre.
3. A comprender la unión interna entre persona y sucursal.

Conceptos que deben dominarse antes de continuar:
- Relación entre claves foráneas y joins.
- Diferencias entre sintaxis JOIN y sintaxis clásica.
- La importancia de la condición ON.

---
*/

/*
SECCIÓN 10. CLAVES FORÁNEAS
Objetivos:
- Aprender qué es una clave foránea y cómo se aplica.
- Comprender qué ocurre cuando se viola una restricción.
- Ver el efecto de forzar la integridad referencial.

Conceptos:
FOREIGN KEY: asegura que un valor existe en otra tabla.
REFERENCES: indica la tabla y columna referenciada.
Integridad referencial: evita datos huérfanos.

Errores frecuentes:
- Asignar un valor que no existe en la tabla referenciada.
- No prever las actualizaciones cuando existe la clave foránea.
- No entender por qué falla un UPDATE después de crear la restricción.
============================================================
*/

-- Cuidado, esta sucursal no existe
update persona set sucursal = 167 where cedula = 1 
go

-- Va a fallar ya que la sucursal 167 no existe
select p.nombre, p.apellido, p.FechaNacimiento, s.nombre as sucursal, s.Direccion as d_sucursal from
persona AS p, sucursal AS s
where p.cedula = 1 and p.sucursal = s.sucursal
go

select * from persona 
go

select * from Sucursal
go

-- dejemos todo como estaba antes
update persona set sucursal = 67 where cedula = 1 
go

-- Todo funcionará ya que la sucursl 67 sí está
select p.nombre, p.apellido, p.FechaNacimiento, s.nombre as sucursal, s.Direccion as d_sucursal from
persona AS p, sucursal AS s
where p.cedula = 1 and p.sucursal = s.sucursal
go

-- se fuerza la relación (foreign key)
ALTER TABLE Persona
ADD CONSTRAINT FK_Persona_Sucursal
FOREIGN KEY (sucursal) -- este es el campo persona.sucursal
REFERENCES Sucursal (Sucursal); -- este es el campo sucursal.sucursal
go

-- intentemos cambiar a una sucursla que no exista
-- esto fallará
update persona set sucursal = 167 where cedula = 1 
go

-- no hubo cambios
select * from persona 
go

-- Es importante poner s.sucursal ya que el campo está en más de una tabla
select 
p.Cedula, p.nombre, p.apellido, p.FechaNacimiento, 
s.nombre as sucursal, s.sucursal, s.Direccion as d_sucursal from
persona AS p inner join sucursal AS s on p.sucursal = s.sucursal -- nuevo
where p.cedula > 2 and s.Sucursal > 90
go

/*
RESUMEN DE LA SECCIÓN
En esta sección se aprendió:
1. A crear una restricción de clave foránea con ALTER TABLE.
2. Qué sucede cuando se intenta guardar un valor inexistente.
3. A verificar la integridad referencial con SELECT y JOIN.

Conceptos que deben dominarse antes de continuar:
- La relación entre llaves primarias y foráneas.
- Comportamiento de UPDATE cuando existe una FK.
- Cómo leer errores de restricción de integridad.

---
*/


/*
SECCIÓN 11. NULL Y COALESCE
Objetivos:
- Entender el manejo de valores nulos en SQL Server.
- Reconocer cuándo una columna puede ser NULL.
- Aprender la importancia de tratar NULL en consultas.

Conceptos:
NULL: representa la ausencia de un valor.
Una columna definida como NULL puede no contener datos.

Errores frecuentes:
- Comparar NULL con operadores estándar (=, <>).
- Suponer que NULL es igual a cadena vacía.

Nota: En este script, la columna Direccion de Persona fue definida como NULL,
lo que permite que algunos registros no tengan una dirección.
============================================================
*/

-- Crea la tabla nulos con una columna obligatoria (cedula) y una que permite NULL (valor)
create table nulos (
cedula integer not null,
valor int null)
go

-- Inserta cuatro filas: algunas con valor NULL y otras con valor numerico
insert into nulos values
(1,null),
(2,99),
(3,null),
(4,101)
go

-- Muestra todas las filas de la tabla nulos
select * from nulos
go

-- Esto fallara porque NULL no se compara con operadores (=, <>, >, <)
-- valor <> NULL siempre produce UNKNOWN
select * from nulos where valor <> NULL
go

-- Forma correcta de verificar que un valor NO sea NULL
select * from nulos where valor is not NULL
go

-- Esto fallara porque valor = NULL nunca funciona
select * from nulos where valor = NULL
go

-- Forma correcta de verificar valores NULL
select * from nulos where valor is NULL
go

-- Muestra cedula, valor y el producto cedula * valor
-- Si valor es NULL, el resultado de la multiplicacion tambien es NULL
select cedula, valor, cedula * valor from nulos
go

-- Muestra cedula, valor y dos formas de multiplicar
-- COALESCE(valor, 0) reemplaza NULL por 0
-- cedula * COALESCE(valor, 0) garantiza un numero sin NULL
select cedula, valor, cedula * valor,
coalesce (valor, 0), cedula * coalesce (valor, 0)
from nulos
go

/*
RESUMEN DE LA SECCIÓN
En esta sección se aprendió:
1. Qué significa NULL en una columna.
2. Que NULL no es igual a un valor vacío.
3. La necesidad de manejar NULL en consultas.

Conceptos que deben dominarse antes de continuar:
- La diferencia entre NULL y valores concretos.
- Que una columna NULL no almacena datos.
- La importancia de comprobaciones específicas para NULL.

---
*/

/*
SECCIÓN 12. RELACIONES MUCHOS A MUCHOS
Objetivos:
- Comprender el concepto de relación muchos a muchos.
- Reconocer que este script no modela directamente una relación M:N.
- Preparar el terreno para el uso de tablas intermedias en el futuro.

Conceptos:
Una relación muchos a muchos necesita una tabla puente.
En este material, las relaciones son de uno a muchos entre Persona y Sucursal.

Errores frecuentes:
- Intentar conectar dos tablas con una sola clave foránea sin tabla intermedia.
- Confundir relaciones uno a muchos con muchos a muchos.
============================================================
*/

-- Crea la tabla Renglon, que representa los detalles de cada factura
CREATE TABLE Renglon (

-- Codigo del producto vendido en el renglón
Producto       varchar(10) NOT NULL,

-- Numero de la factura a la que pertenece el renglón
Factura        int NOT NULL,

-- Cantidad vendida del producto
Cantidad       decimal(10,2) NOT NULL,

-- Llave primaria compuesta: un producto no puede repetirse dentro de la misma factura
CONSTRAINT PK_Renglon PRIMARY KEY (Producto, Factura),

-- Llave foranea: Producto debe existir en la tabla Producto
CONSTRAINT FK_Renglon_Producto FOREIGN KEY (Producto)
REFERENCES Producto (Producto),

-- Llave foranea: Factura debe existir en la tabla Factura
CONSTRAINT FK_Renglon_Factura FOREIGN KEY (Factura)
REFERENCES Factura (NumeroFactura)
);
GO

-- Inserta la factura 234 con fecha 10 mayo 2026
-- Cedula 1 y sucursal 99
INSERT INTO Factura (NumeroFactura, Fecha, Cedula, Sucursal)
VALUES (234, '2026-05-10', 1, 99);

-- Inserta la factura 521 con fecha 10 julio 2026
-- Cedula 1 y sucursal 67
INSERT INTO Factura (NumeroFactura, Fecha, Cedula, Sucursal)
VALUES (521, '2026-07-10', 1, 67);

-- Inserta la factura 686 con fecha 10 septiembre 2026
-- Cedula 4 y sucursal 67
INSERT INTO Factura (NumeroFactura, Fecha, Cedula, Sucursal)
VALUES (686, '2026-09-10', 4, 67);

-- Inserta un renglón: producto P001 en la factura 234 con cantidad 2.50
INSERT INTO Renglon (Producto, Factura, Cantidad)
VALUES ('P001', 234, 2.50);

-- Inserta un renglón: producto P099 en la factura 234 con cantidad 3.00
INSERT INTO Renglon (Producto, Factura, Cantidad)
VALUES ('P099', 234, 3.00);

-- Inserta un renglón: producto P055 en la factura 686 con cantidad 1.00
INSERT INTO Renglon (Producto, Factura, Cantidad)
VALUES ('P055', 686, 1.00);

-- Inserta un renglón: producto P567 en la factura 686 con cantidad 2.00
INSERT INTO Renglon (Producto, Factura, Cantidad)
VALUES ('P567', 686, 2.00);

-- Inserta un renglón: producto P001 en la factura 686 con cantidad 3.00
INSERT INTO Renglon (Producto, Factura, Cantidad)
VALUES ('P001', 686, 3.00);

-- Lista cada renglón con su producto y su factura
-- Cruza Renglon con Producto y Factura
select r.Producto, p.Nombre as nombre_producto, r.Cantidad,
r.Factura, f.Fecha, f.Cedula
from Renglon r
inner join Producto p on r.Producto = p.Producto
inner join Factura f on r.Factura = f.NumeroFactura
go

-- Muestra todas las facturas con sus productos
-- Una factura puede tener varios renglones
select f.NumeroFactura, f.Fecha, r.Producto, r.Cantidad
from Factura f
inner join Renglon r on f.NumeroFactura = r.Factura
order by f.NumeroFactura
go

-- Muestra los productos vendidos en una factura especifica
-- Cambia el numero para consultar otra factura
select r.Factura, r.Producto, p.Nombre, r.Cantidad
from Renglon r
inner join Producto p on r.Producto = p.Producto
where r.Factura = 234
go

-- Muestra cuantas unidades se vendieron de cada producto
-- Agrupa por producto
-- Leer apartado sobre group by y having
select r.Producto, p.Nombre, sum(r.Cantidad) as total_vendido
from Renglon r
inner join Producto p on r.Producto = p.Producto
group by r.Producto, p.Nombre
order by total_vendido desc
go

-- Muestra el total de renglones por factura
-- Cuantos productos distintos tiene cada factura
-- Leer apartado sobre group by y having
select r.Factura, count(*) as cantidad_renglones
from Renglon r
group by r.Factura
order by r.Factura
go

-- Muestra el detalle completo: factura, fecha, producto, cantidad
-- Incluye el nombre del producto
select f.NumeroFactura, f.Fecha, r.Producto, p.Nombre, r.Cantidad
from Factura f
inner join Renglon r on f.NumeroFactura = r.Factura
inner join Producto p on r.Producto = p.Producto
order by f.NumeroFactura, r.Producto
go

-- Muestra las facturas donde aparece un producto especifico
-- Cambia 'P001' por otro codigo
select r.Producto, p.Nombre, r.Factura, f.Fecha
from Renglon r
inner join Producto p on r.Producto = p.Producto
inner join Factura f on r.Factura = f.NumeroFactura
where r.Producto = 'P001'
go


/*
RESUMEN DE LA SECCIÓN
En esta sección se aprendió:
1. Qué es una relación muchos a muchos.
2. Que se requiere una tabla adicional para modelarla.
3. Que este script muestra relaciones de uno a muchos.

Conceptos que deben dominarse antes de continuar:
- Diferencia entre relaciones 1:N y M:N.
- La función de una tabla de unión.
- Cómo planean ampliarse los modelos relacionales.

---
*/


/*
------------------------------------------------------------
RESUMEN GENERAL DE LOS PUNTOS VISTOS EN SQL SERVER
------------------------------------------------------------

CREATE TABLE:
Se usa para crear tablas nuevas definiendo columnas, tipos de datos y restricciones.  
Se vieron claves primarias (PRIMARY KEY), columnas obligatorias (NOT NULL) y columnas opcionales (NULL).  
Tipos usados: INT, VARCHAR, DATE, DECIMAL.

INSERT INTO:
Permite agregar filas a una tabla.  
Se insertaron filas individuales y múltiples.  
Las fechas se insertaron en formato YYYY-MM-DD.

SELECT:
Permite consultar datos de una tabla.  
Se usaron consultas con todas las columnas (SELECT *) y con columnas espec�ficas.  
Se usaron alias de tabla para simplificar nombres, por ejemplo: persona p.

WHERE:
Permite filtrar filas según condiciones.  
Se usaron comparaciones por número y por texto.  
Se combinaron condiciones con OR.

ORDER BY:
Permite ordenar los resultados.  
Se usó orden ascendente y descendente.  
Se ordenó por una columna y por varias columnas.

FUNCIONES:
Se usó DATEDIFF para calcular edades.  
Se hicieron operaciones aritméticas como cedula * 100.75.  
Se construyeron columnas calculadas como Apellido + ', ' + Nombre.

ALIAS:
Se usaron alias de tabla y alias de columnas para hacer las consultas más claras.

TABLAS ADICIONALES:
Se crearon tablas Producto, Factura y Sucursal.  
Esto introduce la idea de modelos con varias tablas relacionadas, aunque no se usaron JOIN todav�a.

SINTESIS:
Se cubrieron los fundamentos esenciales de SQL Server: crear tablas, insertar datos, consultar informaci�n, filtrar, ordenar, usar alias y calcular valores.  
Este conjunto de comandos forma la base de cualquier trabajo posterior con SQL.

*/
