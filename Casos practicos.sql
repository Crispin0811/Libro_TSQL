--***********************************************
--  MODULO 03                   
--***********************************************


--***********************************************
--  CASO DESARROLLADO 1                    
--***********************************************

IF OBJECT_ID('PROYECTOS_INDUSTRIALES') IS NULL 
    DROP DATABASE PROYECTOS_INDUSTRIALES


CREATE DATABASE PROYECTOS_INDUSTRIALES

USE PROYECTOS_INDUSTRIALES

CREATE TABLE DISTRITO(
    COD_DIS CHAR(3) NOT NULL PRIMARY KEY,
    NOM_DIS VARCHAR(40)
)

CREATE TABLE CLIENTE(
    IDE_CLI CHAR(5) NOT NULL PRIMARY KEY,
    NOMBR_CLI VARCHAR(50),
    RUC_CLI CHAR(11) UNIQUE,
    COD_DIS CHAR(3),
    EMA_CLI VARCHAR(35) DEFAULT 'No cuenta',
    FOREIGN KEY(COD_DIS) REFERENCES DISTRITO
)

CREATE TABLE PROYECTO(
    NUM_PRO INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    FEC_PRO DATE,
    MON_PRO MONEY
)

CREATE TABLE ENCARGADO(
    IDE_ENC CHAR(5) NOT NULL PRIMARY KEY ,
    APE_ENC VARCHAR(30) NOT NULL,
    NOM_ENC VARCHAR(30) NOT NULL,
    CAR_ENC VARCHAR(30) NOT NULL, 
    COD_DIS CHAR(3) NOT NULL REFERENCES DISTRITO,
    FIN_ENC DATE NOT NULL
)

CREATE TABLE DETALLE_PROYECTO(
    NUM_PRO INT NOT NULL,
    IDE_CLI CHAR(5) NOT NULL,
    IDE_ENC CHAR(5) REFERENCES ENCARGADO,
    DES_DET VARCHAR(40),
    PRIMARY KEY(NUM_PRO, IDE_CLI)
)

ALTER TABLE PROYECTO
    ADD CONSTRAINT CHK_MONTO
    CHECK (MON_PRO>0)

ALTER TABLE ENCARGADO
    ADD CONSTRAINT CHK_CARRERA
    CHECK (CAR_ENC IN('Jefe','Contador','Supervisor','Vendedor'))

ALTER TABLE DETALLE_PROYECTO
    ALTER COLUMN DES_DET VARCHAR(100)

ALTER TABLE CLIENTE
    ADD TEL_CLI CHAR(11) NOT NULL,
    HIJ_CLI INT NOT NULL

ALTER TABLE CLIENTE
    DROP COLUMN HIJ_CLI

INSERT INTO DISTRITO VALUES ('ABC','SAN JUAN')

UPDATE CLIENTE
    SET EMA_CLI = 'maria_lopez@gMail.com'
    WHERE NOMBR_CLI = 'María Lopez'

UPDATE CLIENTE
    SET TEL_CLI = '00000000'

UPDATE PROYECTO
    SET MON_PRO -= 5000
    WHERE YEAR(FEC_PRO) = 2012 AND MONTH(FEC_PRO) BETWEEN 1 AND 6


--***********************************************
-- CASO DESARROLLADO 2           
--***********************************************

IF OBJECT_ID('RENT_CAR') IS NOT NULL
    DROP DATABASE RENT_CAR


CREATE DATABASE RENT_CAR

USE RENT_CAR

CREATE TABLE DISTRITO(
    IDE_DIS CHAR(3) NOT NULL PRIMARY KEY,
    DES_DIS VARCHAR(40) NOT NULL
)

CREATE TABLE CLIENTE(
    IDE_CLI CHAR(5) NOT NULL PRIMARY KEY,
    APE_CLI VARCHAR(30) NOT NULL,
    NOM_CLI VARCHAR(30) NOT NULL,
    DNI_CLI CHAR(8) NOT NULL,
    TEL_CLI VARCHAR(25) NOT NULL DEFAULT '000-00000',
    IDE_DIS CHAR(3),
    FOREIGN KEY(IDE_DIS) REFERENCES DISTRITO
)

CREATE TABLE ALQUILER(
    NUM_ALQ INT NOT NULL PRIMARY KEY,
    FEC_ALQ DATE NOT NULL,
    MON_ALQ MONEY NOT NULL CHECK (MON_ALQ > 0)
)

CREATE TABLE AUTOMOVIL(
    MAT_AUT CHAR(10) NOT NULL PRIMARY KEY,
    COL_AUT VARCHAR(30) NOT NULL CHECK (COL_AUT IN ('Rojo','Plata','Negro')),
    MOD_AUT VARCHAR(30) NOT NULL
)

CREATE TABLE DETALLE_ALQUILLER(
    NUM_ALQ INT NOT NULL,
    IDE_CLI CHAR(5) NOT NULL,
    MAT_AUT CHAR(10) NOT NULL,
    FOREIGN KEY(NUM_ALQ) REFERENCES ALQUILER,
    FOREIGN KEY(IDE_CLI) REFERENCES CLIENTE,
    FOREIGN KEY(MAT_AUT) REFERENCES AUTOMOVIL
)

ALTER TABLE CLIENTE
    ADD COR_CLI VARCHAR(30) NOT NULL

INSERT INTO AUTOMOVIL VALUES ('123','Rojo','DFSD')



--***********************************************
--  MODULO 4                   
--***********************************************


--***********************************************
--  CASO DESARROLLADO 1                   
--***********************************************

-- Registros de las talblas
    SELECT * FROM CLIENTE
    SELECT * FROM DISTRITO
    SELECT * FROM AUTOMOVIL
    SELECT * FROM DETALLE_ALQUILLER
    SELECT * FROM ALQUILER

-- Listar los colores permitidos
    SELECT DISTINCT COL_AUT AS 'COLORES PERMITIDOS'
    FROM AUTOMOVIL

-- Listar los alquileres de automóviles ordenados por la fecha de alquiler 
-- en forma descendente; y de forma ascendente por el monto de alquiler ante la 
-- posible coincidencia de la fecha de alquiler.

    SELECT *
    FROM ALQUILER A
    ORDER BY A.FEC_ALQ DESC, A.MON_ALQ

--Listar los 2 primeros registros de alquiler que cuenten con el menor valor en el monto de alquiler

    SELECT TOP 2 *
    FROM ALQUILER A
    ORDER BY A.MON_ALQ ASC

-- 

    SELECT A.NUM_ALQ AS 'NUMERO DE ALQUILER',
            A.FEC_ALQ AS 'FECHA ALQUILER',
            A.MON_ALQ AS 'MONTO ALQUILER'
    FROM ALQUILER A

-- CODIGO CLIENTE TELEFONO DNI

    SELECT C.IDE_CLI 'CODIGO',
            C.NOM_CLI+SPACE(1)+C.APE_CLI 'CLIENTE',
            C.TEL_CLI 'TELEFONO',
            C.DNI_CLI 'DNI'
    FROM CLIENTE C

-- CREAR UNA TABLA AUTOS_ROJOS 

    IF OBJECT_ID('AUTO_ROJO') IS NOT NULL 
        DROP TABLE AUTO_ROJO

    CREATE TABLE AUTO_ROJO()

    INSERT INTO AUTO_ROJO
    SELECT * 
    FROM AUTOMOVIL A
    WHERE A.COL_AUT = 'ROJO'

-- Autos de color negro

    SELECT *
    FROM AUTOMOVIL
    WHERE COL_AUT = 'NEGRO'

-- CLIENTE DEL DISTRO L04

    SELECT *
    FROM CLIENTE
    WHERE IDE_DIS = 'L04'

-- Clientes que el nombre empieza con M

    SELECT *
    FROM CLIENTE C
    WHERE C.NOM_CLI LIKE 'M%'

-- Rango de alquiler 100 - 150

    SELECT *
    FROM ALQUILER A
    WHERE A.MON_ALQ BETWEEN 100 AND 150

-- Autmoviles que no sean de color PLATA

    SELECT *
    FROM AUTOMOVIL A
    WHERE A.COL_AUT <> 'PLATA'

-- 
    SELECT C.IDE_CLI 'CODIGO',
            C.NOM_CLI+SPACE(1)+C.APE_CLI 'CLIENTE',
            D.DES_DIS 'DISTRITO',
            C.DNI_CLI 'DNI'
    FROM CLIENTE C
    INNER JOIN DISTRITO D
    ON C.IDE_DIS = D.IDE_DIS

-- 
    SELECT AL.NUM_ALQ 'ALQUILER',
            AL.FEC_ALQ 'FECHA',
            AU.MAT_AUT 'AUTOMOVIL',
            C.NOM_CLI+SPACE(1)+C.APE_CLI 'CLIENTE'
    FROM ALQUILER AL
    INNER JOIN DETALLE_ALQUILLER DAL
    ON AL.NUM_ALQ = DAL.NUM_ALQ
    INNER JOIN AUTOMOVIL AU
    ON DAL.MAT_AUT = AU.MAT_AUT
    INNER JOIN CLIENTE C
    ON DAL.IDE_CLI = C.IDE_CLI

-- Listar los registros de alquiler que aun no cuentan con detalle de alquiler

    SELECT *
    FROM ALQUILER AL
    LEFT JOIN DETALLE_ALQUILLER DAL
    ON AL.NUM_ALQ = DAL.NUM_ALQ
    WHERE DAL.MAT_AUT IS NULL

-- Listar a los cliente que aun no registran alquiler

    SELECT *
    FROM CLIENTE C
    LEFT JOIN DETALLE_ALQUILLER DAL
    ON C.IDE_CLI = DAL.IDE_CLI
    WHERE DAL.MAT_AUT IS NULL

-- Listar el total de clientes por distrito

    SELECT D.DES_DIS 'DISTRITO',
            COUNT(C.IDE_DIS) 'TOTAL DISTRITO'
    FROM DISTRITO D
    INNER JOIN CLIENTE C
    ON D.IDE_DIS = C.IDE_DIS
    GROUP BY C.IDE_DIS

-- Listar el total de automoviles por tipo de color

    SELECT COL_AUT 'COLOR',
            COUNT(*) 'TOTAL DE AUTOMOBILES'
    FROM AUTOMOVIL
    GROUP BY COL_AUT

-- Listar el monto acumulado por año desde la tabla alquiller

    SELECT YEAR(FEC_ALQ) 'AÑO ALQUILER',
            SUM(MON_AQL) 'TOTAL'
    FROM ALQUILER
    GROUP BY ROLLUP (YEAR(FEC_ALQ))

-- 

    SELECT C.IDE_CLI 'CODIGO',
            C.NOM_CLI+SPACE(1)+C.APE_CLI 'CLIENTE',
            (SELECT D.DES_DIS
            FROM DISTRITO D
            WHERE C.IDE_DIS = D.IDE_DIS) AS 'DISTRITO',
            C.DNI_CLI 'DNI'
    FROM CLIENTE C

-- 

    SELECT DAL.NUM_ALQ 'ALQUILER',
            (SELECT A.FEC_ALQ 
            FROM ALQUILER A
            WHERE A.NUM_ALQ = DAL.NUM_ALQ) AS 'FECHA',
            DAL.MAT_AUT 'AUTOMOVIL',
            (SELECT C.NOM_CLI+SPACE(1)+C.APE_CLI 'CLIENTE'
            FROM CLIENTE C
            WHERE C.IDE_CLI = DAL.IDE_CLI) AS 'FECHA'
    FROM DETALLE_ALQUILLER DAL 



--***********************************************
--  MODULO 5                   
--***********************************************


--***********************************************
--  CASO DESARROLLADO 1                   
--***********************************************


-- Determinar la infotmacion de un cliente

    DECLARE @NOMBRE_CLIENTE VARCHAR(50)
    DECLARE @ID_CLIENTE CHAR(5) = 'C001'

    SELECT @NOMBRE_CLIENTE = C.NOM_CLI + ' ' + C.APE_CLI
    FROM CLIENTE C 
    WHERE C.COD_CLI = @ID_CLIENTE

    PRINT(@NOMBRE_CLIENTE)

-- Determinar la infotmacion del detalle de alquiler 

    DECLARE @NUMERO_ALQUILER VARCHAR(100) 
    DECLARE @IDE_CLIENTE CHAR(5) 
    DECLARE @MAT_AUTO CHAR(10) 

    SELECT @NUMERO_ALQUILER = 
    FROM CLIENTE

-- Mostrar el nombre completo de un cliente por nombre

    DECLARE @NOMBRE_CLIENTE2 VARCHAR(50)
    DECLARE @ID_CLIENTE2 CHAR(5) = 'C001'

    SELECT @NOMBRE_CLIENTE2 = C.NOM_CLI + ' ' + C.APE_CLI
    FROM CLIENTE C 
    WHERE C.COD_CLI = @ID_CLIENTE2

    PRINT(@NOMBRE_CLIENTE)

-- Mostrar una liosta de automoviles de un determinado color

    DECLARE @COLOR_AUTO VARCHAR(30) = 'ROJO'

    SELECT *
    FROM AUTOMOVIL
    WHERE COL_AUT = @COLOR_AUTO

-- Que permita registar un nuevo altomovil caso contrario lo actualice

    DECLARE @MAT_AUT CHAR(10)
    DECLARE @COL_AUT VARCHAR(10)
    DECLARE @MOD_AUT VARCHAR(10)

    IF EXISTS (SELECT * FROM AUTOMOVIL WHERE MAT_AUT = @MAT_AUT)
        BEGIN
            UPDATE AUTOMOVIL 
            SET COL_AUT = @COL_AUT,
                MOD_AUT = @MOD_AUT
            WHERE MAT_AUT = @MAT_AUT
        END
    ELSE
        BEGIN
            INSERT INTO AUTOMOVIL VALUES(@MAT_AUT,@COL_AUT,@MOD_AUT)
        END

-- 

    SELECT A.*,
            CASE 
                WHEN A.MON_ALQ < 50 THEN 'BAJO'
                WHEN A.MON_ALQ >= 50 AND A.MON_ALQ <= 100 THEN 'MEDIO'
                WHEN A.MON_ALQ > 100 THEN 'ALTO'
            END AS 'CONDICION'
    FROM ALQUILER A