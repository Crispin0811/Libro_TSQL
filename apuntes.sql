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
--  CAPITULO 3            
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
-- solo se permite una por tabla

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


--***********************************************
--  CAPITULO 4                   
--***********************************************



--***********************************************
-- 4.2 SELECT            (pag 129)
--***********************************************

--Para obtener registros

--***********************************************
-- 4.3 DISTINCT ==> SELECT DISTINCT <CAMPO> FROM <NOMBRE_TABLA>                   
--***********************************************

-- Devuelve valores unicos del campo requerido

    --SELECT DISTINCT UNI_PRO FROM PRODUCTO

--***********************************************
--  4.4 ORDER BY                   
--***********************************************


-- Devuelve valores ordenados

    -- SELECT * FROM PRODUCTO
    -- ORDER BY PRE_PRO DESC    ==> ordenar de forma ordenada por el precio del producto

-- Ordenamiento anidado

    -- SELECT * FROM CLIENTE
    -- ORDER BY YEAR(FEC_REG) DESC, MONTH(FEC_REG) ==> se necesita que se ordene por año y mes de nacimiento


--***********************************************
--  4.5 TOP  ==> SELECT TOP 10 * FROM <NOMBRE_TABLA>                 
--***********************************************

-- Con numneros

    -- SELECT TOP 10 * FROM CLIENTE ==> devuelve los 10 primeros registros del la tabla CLIENTE

--Con porcentaje

    -- SELECT TOP 50 PERCENT * FROM CLIENTE ==> devuelve la mitas de registros (50%) de la tabla CLIENTE


--***********************************************
--  4.6 CONSULTAS DE ALGUNOS CAMPOS                   
--***********************************************

--Para especificar que campo será llamado

    -- SELECT CAMPO1, COMPO2, CAMPO3 FROM <NOMBRE_TABLA>

    -- SELECT DIR_CLI FROM CLIENTE

    -- SELECT C.DIR_CLI FROM CLIENTE C ==> usando alias

--***********************************************
--  4.7 CONSULTAS DE CABECERA                   
--***********************************************

--Para que el resultado muestre con un nombre de columna diferente

    -- SELECT CAMPO1 AS <NUEVO_NOMBRE1>, CAMPO2 AS <NUEVO_NOMBRE2> FROM <NOMBRE_TABLA>

    -- SELECT DIR_CLI DIRECCION, TLF_CLI AS 'TELEFONO CLIENTE' FROM CLIENTE

--***********************************************
--  4.8 CAMPO CALCULADO                   
--***********************************************

--Se quiere agregar 10% al precio para el precio de venta

    -- SELECT COD_PRO CODIGO, DES_PRO DESCRIPCION,PRE_PRO PRECIO, (PRE_PRO * 1.1) AS 'PRECIO VENTA'
    -- FROM PRODUCTO
    -- ORDER BY [PRECIO VENTA] DESC

    -- SELECT COD_PRO CODIGO,
    --     DES_PRO DESCRIPCION, 
    --     SAC_PRO 'STOCK ACTUAL', 
    --     SMI_PRO 'STOCK MINIMO', 
    --     (SAC_PRO - SMI_PRO) 'DIFERENCIA'
    -- FROM PRODUCTO
    -- ORDER BY 'DIFERENCIA' DESC


--***********************************************
--  4.9 CONSULTAS QUE CREAN TABLAS DE REGISTRO                   
--***********************************************

-- Permite crear tablas con la información resultante

    -- SELECT * INTO CLIENTE_BAK
    -- FROM CLIENTE

--***********************************************
--  4.10 CONDICIONALES                   
--***********************************************

-- Operadores logico (pag. 140)

    -- WHERE CAMPO1 LIKE 'A%' ==> busca registros que empiezan con a
    -- WHERE CAMPO1 LIKE '%A' ==> busca registros que terminen con a
    -- WHERE CAMPO1 LIKE '%A%' ==> busca registros que contengan la a

    -- WHERE CAMPO1 LIKE '_A%' ==> busca registros que la segunda letra sea a. Se puede agregar cuantos "_" se necesite.
    -- WHERE CAMPO1 LIKE '__A%' ==> busca registros que la tercera letra sea a.

    -- WHERE CAMPO1 IS NOT NULL ==> muestra registros que el la columna 'CAMPO1' no tenga nulos

    -- WHERE CAMPO1 LIKE '[MDC]%' ==> muestra registros que puedan empezar con M D o C
    -- WHERE CAMPO1 LIKE '[^MDC]%' ==> muestra registros que NO deban empezar con M D o C
    -- WHERE CAMPO1 LIKE '[_MDC]%' ==> muestra registros que la segunda letra sea M D o C

--***********************************************
--  4.11 CONSULTAR INTERNAS                   
--***********************************************

-- SELECT COD_VEN CODIGO, 
--         NOM_VEN + ' ' + APE_VEN AS VENDEDOR, 
--         SUE_VEN SUELDO,
--         FIN_VEN 'FECHA INICIO',
--         NOM_DIS 'DISTRITO'
-- FROM VENDEDOR V INNER JOIN DISTRITO D
-- ON V.COD_DIS = D.COD_DIS


-- SELECT F.NUM_FAC FACTURA, 
--         F.FEC_FAC 'FECHA FACTURADA', 
--         V.NOM_VEN + ' ' + V.APE_Ven VENDEDOR,
--         C.RSO_CLI CLIENTE
-- FROM FACTURA F 
-- INNER JOIN VENDEDOR V 
-- ON F.COD_VEN = V.COD_VEN 
-- INNER JOIN CLIENTE C 
-- ON F.COD_CLI = C.COD_CLI
-- ORDER BY F.FEC_FAC DESC

--***********************************************
--  4.12 CONSULTAS EXTERNAS                   
--***********************************************

--***********************************************
--  LEFT JOIN                   
--***********************************************

-- SELECT D.COD_DIS,
--         D.NOM_DIS,
--         V.COD_VEN,
--         V.NOM_VEN,
--         V.APE_Ven,
--         V.SUE_VEN,
--         V.FIN_VEN,
--         V.TIP_VEN,
--         D.COD_DIS
-- FROM DISTRITO D
-- LEFT JOIN VENDEDOR V
-- ON V.COD_DIS = D.COD_DIS
-- ORDER BY V.COD_VEN DESC

--***********************************************
--  RIGHT JOIN                   
--***********************************************

-- SELECT * 
-- FROM VENDEDOR V
-- RIGHT JOIN DISTRITO D
-- ON D.COD_DIS = V.COD_DIS

--***********************************************
--  FULL JOIN                   
--***********************************************

-- SELECT *
-- FROM VENDEDOR V
-- FULL JOIN DISTRITO D
-- ON V.COD_DIS = D.COD_DIS



--***********************************************
--  4.13 CONSULTAS AGRUPADAS                   
--***********************************************

--***********************************************
--  4.13.1 FUNCIONES AGREGADAS                   
--***********************************************

--Hay 5: suma, conteo, promedio, maximo, minimo

    --***********************************************
    --  COUNT                   
    --***********************************************
    
    --Cuenta la cantidad de registro

        -- SELECT COUNT(P.COD_PRO) AS 'CANTIDAD DE PRODUCTOS'
        -- FROM PRODUCTO P

    --Otra forma => al poner * representa a cualquier columna

        -- SELECT COUNT(*) AS 'CANTIDAD DE PRODUCTOS'
        -- FROM PRODUCTO P
    

    --***********************************************
    --  SUM                   
    --***********************************************
    
    -- Permite saber el valor acumulado de una columa

        -- SELECT SUM(P.PRE_PRO) AS 'TOTAL PRECIO'
        -- FROM PRODUCTO P
        -- WHERE P.PRE_PRO > 20
    

    --***********************************************
    --  MAX                   
    --***********************************************
    
    -- Retorna el valor maximo de una columna

        -- SELECT MAX(P.PRE_PRO)
        -- FROM PRODUCTO P


    --***********************************************
    --  MIN                 
    --***********************************************
    
    -- Retorna el valor minimo de una columna

        -- SELECT MIN(P.PRE_PRO)
        -- FROM PRODUCTO P


    --***********************************************
    --  AVG                   
    --***********************************************
    
    -- Retorna el promedio de una columna

        -- SELECT AVG(P.PRE_PRO)
        -- FROM PRODUCTO P

--***********************************************
--  4.13.2 CLAUSULA GROUP BY                   
--***********************************************

-- Recuperar informacion agrupar 

    -- SELECT D.NOM_DIS,
    --         COUNT(C.COD_DIS)
    -- FROM DISTRITO D
    -- INNER JOIN CLIENTE C
    -- ON D.COD_DIS = C.COD_DIS
    -- GROUP BY D.NOM_DIS


    -- SELECT V.NOM_VEN + ' ' + V.APE_Ven 'VENDEDOR',
    --         COUNT(F.COD_VEN)
    -- FROM FACTURA F
    -- INNER JOIN VENDEDOR V
    -- ON V.COD_VEN = F.COD_VEN
    -- GROUP BY V.NOM_VEN + ' ' + V.APE_Ven


    --USANDO HAVING

        -- SELECT D.NOM_DIS,
        --         COUNT(P.COD_DIS)
        -- FROM PROVEEDOR P
        -- INNER JOIN DISTRITO D
        -- ON P.COD_DIS = D.COD_DIS
        -- GROUP BY D.NOM_DIS
        -- HAVING COUNT(P.COD_DIS) >=2


        -- SELECT YEAR(F.FEC_FAC) 'AÑO',
        --         MONTH(F.FEC_FAC) 'MES',
        --         COUNT(*) 'TOTAL'
        -- FROM FACTURA F
        -- GROUP BY YEAR(F.FEC_FAC), MONTH(F.FEC_FAC)
        -- HAVING MONTH(F.FEC_FAC) BETWEEN 1 AND 6


--***********************************************
--  4.13.3 GROUP BY CON RESUMENES     https://www.youtube.com/watch?v=bbkybT9qnTg&ab_channel=kudvenkat               
--***********************************************

    -- Para poner subtotales en el resultado de las busquedas
    -- ROLLUP y CUBE (pag. 157)

    -- SELECT P.UNI_PRO,
    --         COUNT(*) 'TOTAL'
    -- FROM PRODUCTO P
    -- GROUP BY P.UNI_PRO
    -- WITH ROLLUP

    -- SELECT P.UNI_PRO,
    --         COUNT(*) 'TOTAL'
    -- FROM PRODUCTO P
    -- GROUP BY CUBE(P.UNI_PRO)
    
    -- SELECT CASE 
    --             WHEN YEAR(F.FEC_FAC) IS NULL
    --                 THEN 'TOTAL'
    --                 ELSE CAST(YEAR(F.FEC_FAC) AS CHAR(4))
    --         END AS 'AÑO',
    --         CASE 
    --             WHEN MONTH(F.FEC_FAC) IS NULL
    --                 THEN 'TOTAL POR AÑO'
    --                 ELSE CAST(MONTH(F.FEC_FAC) AS CHAR(2))
    --         END AS 'MES',
    --         COUNT(*) AS TOTAL
    -- FROM FACTURA F
    -- GROUP BY ROLLUP (YEAR(F.FEC_FAC), MONTH(F.FEC_FAC))


--***********************************************
--  4.14 SUBCONSULTAS       (pag 161)            
--***********************************************

--Select anidada dentro de una instruccion

    -- SELECT P.*,
    --         (SELECT NOM_DIS 
    --         FROM DISTRITO D 
    --         WHERE P.COD_DIS = D.COD_DIS) AS DISTRITO
    -- FROM PROVEEDOR P

--***********************************************
-- 4.15 VISTAS  => CREATE VIEW <NOMBRE_VISTA>                   
--***********************************************


--Despues de crear una vista puede ser consultada como si fuera una tabla

    -- Validar que la vista existe

        -- IF OBJECT_ID('<NOMBRE_VISTA>') IS NOT NULL
        --     DROP VIEW <NOMBRE_VISTA>
        -- GO

    -- Crear una vista

        -- CREATE VIEW <NOMBRE_VISTA>
        -- AS 
        --     SELECT * FROM PROVEEDOR
        -- GO

    --ejecutar una vista

        -- SELECT * FROM <NOMBRE_VISTA>



--***********************************************
--  CAPITULO 5                   
--***********************************************


--***********************************************
-- 5.2.1 VARIABLES E IDENTIFICADORES                       
--***********************************************

-- Declarar una variable (debe empezar com @ obligatoriamente)

    -- DECLARE @NOMBRE VARCHAR(30)

    -- DECLARE @NOMBRE VARCHAR(30), 
    --         @APELLIDO_PATERNO VARCHAR(30),
    --         @APELLIDO_MATERNO VARCHAR(30)


-- Asiganr valor a una variable

    -- SET @NOMBRE = 'KEVIN'
    -- SET @APELLIDO_PATERNO = 'CRISPIN'
    -- SET @APELLIDO_MATERNO = 'GONZALES'

-- Otra manera (declaracion-asignación)

    -- DECLARE @HASPRO INT = 1,
    --         @HASPET INT = 0

-- DECLARE @NOMBRE_ESTUDIANTE VARCHAR(50) = 'KEVIN CRISPIN GONZALES',
--         @N1 INT = 15,
--         @N2 INT = 12,
--         @N3 INT = 13,
--         @N4 INT = 18,
--         @PROMEDIO DECIMAL(5,2)
-- SET @PROMEDIO = (@N1 + @N2 + @N3 + @N4) / 4.0


--***********************************************
--  5.2.2 CAST AND CONVERT                   
--***********************************************

-- CAST y CONVERT sirven para cambiar de un tipo de dato a otro.

--Formatos

    -- CAST(@N3 AS VARCHAR(50))
    -- CONVERT(VARCHAR(50), @PROMEDIO)

--Ejemplo

    -- DECLARE @MONEY INT = 15
    -- PRINT('TIENES QUE PAGAR: ' + CAST(@MONEY AS VARCHAR(5)))
    -- PRINT('TIENES QUE PAGAR: ' + CONVERT(VARCHAR(5),@MONEY) )


--***********************************************
-- 5.3 ESTRUCTURAS DE CONTROL                    
--***********************************************


--***********************************************
--  5.3.1 ESTRUCTURA IF                   
--***********************************************

    --BEGIN y END SON IMPORTANTE CUANDO SE USARÁ MAS DE DOS LINEAS DE CODIGO

        -- DECLARE @CODIGO_DISTRITO CHAR(5) = 'D39',
        --         @NOMBRE_DITRITO VARCHAR(50) = 'San Juan2'
        
        -- IF EXISTS(SELECT D.NOM_DIS FROM DISTRITO D WHERE D.NOM_DIS = @NOMBRE_DITRITO)
        --     PRINT('DISTRITO YA SE ENCUENTA REGISTRADO')
        -- ELSE
        --     BEGIN
        --         INSERT INTO DISTRITO VALUES(@CODIGO_DISTRITO,@NOMBRE_DITRITO)
        --         PRINT('DISTRITO REGISTRADO CORRECTAMENTE')
        --     END

        -- Otro ejemplo

        -- DECLARE @ANIO_FECHA VARCHAR(4) = '2018'

        -- IF EXISTS(SELECT * FROM FACTURA F WHERE YEAR(F.FEC_FAC) = @ANIO_FECHA)
        --     BEGIN
        --         SELECT 
        --             YEAR(F.FEC_FAC) AS 'AÑO',
        --             COUNT(*) AS 'TOTAL FACTURAS'
        --         FROM FACTURA F
        --         WHERE YEAR(F.FEC_FAC) = @ANIO_FECHA
        --         GROUP BY YEAR(F.FEC_FAC) 
        --     END
        -- ELSE
        --     BEGIN
        --         PRINT('NO HAY FACTURAS REGISTRADAS')
        --     END

        

--***********************************************
--  5.3.2 ESTRUCTURAS CONDICIONLES MULTIPLES ==> CASE-WHEN-THEN                  
--***********************************************

    
    -- SELECT D.NOM_DIS 'DISTRITO',
    --         COUNT(P.COD_DIS) 'TOTAL PROVEEDORES',
    --         CASE 
    --             WHEN COUNT(P.COD_DIS) = 0 THEN 'NO CUENTA'
    --             ELSE ''
    --         END AS 'MENSAJE'
    -- FROM DISTRITO D
    -- LEFT JOIN PROVEEDOR P
    -- ON P.COD_DIS = D.COD_DIS
    -- GROUP BY D.NOM_DIS


--***********************************************
--  5.3.3 ESTRUCTURA DE CONTROL WHILE                   
--***********************************************

    -- DECLARE @N INT = 1

    -- WHILE(@N <=10)
    --     BEGIN
    --         PRINT('VALOR I: '+ CAST(@N AS CHAR))
    --         SET @N+=1
    --     END


--***********************************************
--  5.4 COMTROL DE ERRORES ==> TRY CATCH                   
--***********************************************

    -- BEGIN TRY
    --     INSERT INTO DISTRITO VALUES('D02', 'SAN JUAN DE ASIS')
    -- END TRY
    -- BEGIN CATCH
    --     DECLARE @MENSAJE VARCHAR(1000)
    --     SET @MENSAJE = CAST(ERROR_MESSAGE() AS VARCHAR(1000))
    --     PRINT('HUBO UN ERROR DE:::: ' + @MENSAJE)
    -- END CATCH



