--***********************************************
--              TIPOS DE DATOS
--***********************************************

-- DATOS DE CARACTERES
-- CHAR = es de longitud fija
-- VARCHAR = es de lo longitud variable,  administra los espacios en blaco

-- Comulna de tipo TEXT puede almacenar hasta 8kb

--TIPOS DE DATOS PARA FECHA Y HORA
-- DATETIME = acepta fecha y hora
-- DATETIME2 = acepta fecha, hora y milisegundo
-- TIME
-- DATE

-- DECIMALES
-- decimal (5,2) = permitirá registro de 5 caracteres con dos decimales.

-- ENTEROS
-- INT = almacenará numeros enteros de gran cantidad
-- TINYINT =  almacenará valor de 0 a 255


--***********************************************
--  TERCER CAPITULO DEL LIBRO                   
--***********************************************


--***********************************************
--              CREAR UNA TABLA                  
--***********************************************

-- Antes de crear debemos verificar que la base de datos existe o no. Para evitar posibles errores
-- se utiliza la siguinete sentencia.

-- IF OBJECT_ID('<NOMBRE_TABLA>') IS NOT NULL
--     DROP TABLE <NOMBRE_TABLA>

-- CREATE TABLE NOMBRE_TABLA(
--     PruebaId varchar(8),
--     PruebaNombre varchar(50)
-- )

--***********************************************
--       VER LAS TABLAS DE UNA BBDD ACTIVA                  
--***********************************************

--SP_TABLES

--***********************************************
--          VER LAS COLUMAS DE UNA BD                 
--***********************************************

-- SP_COLUMNS <NOMBRE_TABLA>

--***********************************************
--     MODIFICAR UNA TABLA                   
--***********************************************

-- MODIFICAR TIPO O TAMAÑO DE UNA COLUMA

--     ALTER TABLE <NOMBRE_TABLA>
--     ALTER COLUMN <NOMBRE_COLUMNA> TIPO(12)

-- AGREGAR CAMPO

--     ALTER TABLE <NOMBRE_TABLA>
--     ADD <NOMBRE_COLUMNA> TIPO(),
--     <NOMBRE_COLUMNA> TIPO() 

-- ELIMINAR CAMPO 

--     ALTER TABLE <NOMBRE_TABLA>
--     DROP COLUMN <NOMBRE_COLUMNA>

--***********************************************
--  ELIMINAR UNA TABLA                
--***********************************************

-- DROP TABLE <NOMBRE_TABLA>

-- Con restriccion

--     IF OBJECT_ID('<NOMBRE_TABLA>') IS NOT NULL
--         DROP TABLE <NOMBRE_TABLA>

--***********************************************
--  RESTRICCIONES DE NULOS O NO NULOS                   
--***********************************************

-- CREATE TABLE <NOMBRE_TABLA>(
--     CAMPO1 TIPO() NULL | NOT NULL,
--     CAMPO2 TIPO() NULL | NOT NULL
-- )

-- ALTER TABLE <NOMBRE_TABLA>
--     ADD COLUMN1 TIPO() NULL


--***********************************************
--  LLAVE PRIMARIA (SIMPLE Y COMPUESTA) , recomendable INT o CHAR para las llaves primarias            
--***********************************************

-- CREATE TABLE <NOMBRE_TABLA>(

--     CAMPO1 TIPO() NOT NULL PRIMARY KEY,
--     CAMPO2 TIPO() NULL
-- )

--AÑADIR LLAVE PRIMARY A UNA TABLA

-- ALTER TABLE <NOMBRE_TABLA>
-- ADD PRIMARY KEY (CAMPO_CLAVE)

--LLAVE PRIMARIA COMPUESTA

-- CREATE TABLE <NOMBRE_TABLA>(
-- CAMPO1 TIPO() NOT NULL,
-- CAMPO2 TIPO() NOT NULL,
-- CAMPO3 TIPO() NULL | NOT NULL,
-- PRIMARY KEY (CAMPO1,CAMPO2)
--  )

-- OTRA FORMA
-- ALTER TABLE <NOMBRE_TABLA>
-- PRIMARY KEY (CAMPO1,CAMPO2)

--***********************************************
--  LLAVE SECUNDARIA O FORANEA         
--***********************************************

-- CREATE TABLE <NOMBRE_TABLA1>(
--     CAMPO1 TIPO() NOT NULL PRIMARY KEY,
--     CAMPO2 TIPO() NOT NULL,
--     CAMPO3 TIPO() NOT NULL REFERENCES <NOMBRE_TABLA2>
-- )

-- OTRA FORMA => QUEREMOS QUE CAMPO 3 SEA LA LLAVE FORANEA

--     CREATE TABLE <NOMBRE_TABLA1>(
--         CAMPO1 TIPO() NOT NULL PRIMARY KEY,
--         CAMPO2 TIPO() NOT NULL,
--         CAMPO3 TIPO() NOT NULL,
--         FOREIGN KEY (CAMPO3) REFERENCES <NOMBRE_TABLA2>
--     )

-- OTRA FORMA

--     ALTER TABLE <NOMBRE_TABLA1>
--     ADD FOREIGN KEY (CAMPO2) REFERENCES <NOMBRE_TABLA2>



--***********************************************
--  3.5 RESTRICCIONES PARA DATOS                   
--***********************************************



--***********************************************
--  IDENTITY ==> COLUMNA1 INT IDENTITY(INICIO,CANTIDAD_INDREMENTO)       "pag 104 del libro"         
--***********************************************

-- Solo se usa para datos de tipo numerico ya que define un auto incremento de valores en la columna

-- CREATE TABLE <NOMBRE_TABLA>(
--     COLUMNA1 INT NOT NULL PRIMARY KEY IDENTITY(1000, 1)
-- )

-- Para el ejemplo anterior el registro empezará desde 1000 autoincrementando en 1.

--***********************************************
--  DEFAULT ==> CAMPO2 TIPO() DEFAULT <VALOR>                   
--***********************************************

--Permite agregar un valor default segun el valor del dato

-- CREATE TABLE <NOMBRE_TABLA1>(
--     CAMPO1 TIPO() NOT NULL PRIMARY KEY,
--     CAMPO2 TIPO() NOT NULL DEFAULT '<VALOR_DEFAULT>',
--     CAMPO3 TIPO() NOT NULL,
-- )

-- Otra manera

-- ALTER TABLE <NOMBRE_TABLA>
-- ADD DEFAULT '<VALOR_DEFAULT>'
-- FOR CAMPO1

--***********************************************
--  UNIQUE ==> CAMPO2 TIPO() UNIQUE            
--***********************************************

-- Para que los datos de una columna no tengan datos duplicados

-- CREATE TABLE <NOMBRE_TABLA>(
--     CAMPO1 TIPO() NOT NULL PRIMARY KEY,
--     CAMPO2 TIPO() NOT NULL DEFAULT '<VALOR_DEFAULT>',
--     CAMPO3 TIPO() NOT NULL  UNIQUE,
-- )

-- Otra manera

-- ALTER TABLE <NOMBRE_TABLA>
-- ADD CONTAINS <NOMBRE_REFERENCIAL>
-- UNIQUE CAMPO3

-- En este ejemplo estamos diciendo que el CAMPO3 tendrá valores unicos



--***********************************************
--  3.6 SENTENCIAS DML PARA DATOS                   
--***********************************************



--***********************************************
--  INSERT ==> Insertar valores a una tabla o vista             
--***********************************************

-- INSERT INTO <NOMBRE_TABLA> VALUES (VALOR1, VALOR2, VALOR3)

-- Para campos especificos

    -- INSERT INTO <NOMBRE_TABLA> (CAMPO1,CAMPO2,CAMPO3) VALUES (VALOR1, VALOR2, VALOR3)

-- Inserción multiple

    -- INSERT INTO <NOMBRE_TABLA> VALUES 
    --     (VALOR1, VALOR2, VALOR3),
    --     (VALOR1, VALOR2, VALOR3),
    --     (VALOR1, VALOR2, VALOR3)

    -- Tambien

        -- INSERT INTO <NOMBRE_TABLA> (CAMPO1,CAMPO2,CAMPO3) VALUES
        --     (VALOR1, VALOR2, VALOR3),
        --     (VALOR1, VALOR2, VALOR3),
        --     (VALOR1, VALOR2, VALOR3)

-- PASAR DATOS DE UNA TABLA A OTRA USANDO ***** INSERT *****

    -- Pasar todos los registro de la tabla <NOMBRE_TABLA_ORIGEN> a <NOMBRE_TABLA_DESTINO>

        -- INSERT INTO <NOMBRE_TABLA_DESTINO>
        -- SELECT * FROM <NOMBRE_TABLA_ORIGEN>


--***********************************************
--  UPDATE ==> Actualizar un registro de una tabla o vista              
--***********************************************


-- UPDATE <NOMBRE_TABLA> 
-- SET CAMPO1 = VALOR1 , CAMPO2 = VALOR2 
-- WHERE <CONDICIÓN>

--***********************************************
--  DELETE  ==> Eliminar registros de la base de datos                   
--***********************************************

-- DELETE FROM <NOMBRE_TABLA> WHERE <CONDICIÓN>



--***********************************************
--  3.7 MANEJO DE DATOS MASIVOS EN SQL SERVER                   
--***********************************************



--***********************************************
--  INSTRUCCIÓN BULK INSERT                   
--***********************************************

-- Permite pasar datos de un archivo plano a una tabla en SQL SERVER

--Sinstaxis

    -- BULK INSERT <NOMBRE_TABLA>
    -- FROM '<DIRECCION_ARCHIVO>'
    -- WITH(
    --     FIELDTERMINATOR = ',',   => como estan separador los datos
    --     ROWTERMINATOR = '/n',    => representacion de salto de lines
    --     FIRSTROW = 1             => desde que fila empezará a recorrec para la insercion
    -- )

--Ejemplo 

    -- BULK INSERT PROVEEDOR
    -- FROM 'c:\productos.txt',
    -- WITH(
    --     FIELDTERMINATOR = ',',
    --     ROWTERMINATOR = '/n',
    --     FIRSTROW = 1
    -- )


