--***********************************************
--  CREACION DE VARIABLE                   
--***********************************************

-- Los nombres de las varibales siempre deben empezar con @

    -- DECLARE @<NOMBRE_VARIABLE> TIPO         => se usa DECLARE para crea una variable
    -- SET  @<NOMBRE_VARIABLE> = <VALOR>       => SET para dar valor a la variable


--***********************************************
--  ACTUALIZAR DATOS CON UNIONES DE DATOS    PAG:109                   
--***********************************************

    -- se quiere poner 00000 a los telefonos de los proveedores que son del distrito de RIMAC

        -- UPDATE PROVEEDOR 
        --     SET TEL_PRV = '00000'
        --     WHERE COD_DIS = (SELECT COD_DIS FROM DISTRITO 
        --                     WHERE NOM_DIS = 'RIMAC')


        --Otra manera

            -- UPDATE PROVEEDOR
            -- SET TEL_PRV = '00000'
            --     FROM PROVEEDOR AS P 
            --     JOIN DISTRITO AS D ON P.COD_DIS = D.COD_DIS
            --     AND P.COD_DIS = (SELECT COD_DIS FROM DISTRITO WHERE NOM_DIS = 'RIMAC')


