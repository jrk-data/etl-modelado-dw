

-- #################  CREACION FUNCION PARA CAPTURAR TIPO DE INSERT Y EJECUTAR SP ######################

create schema if not exists ods;

SET search_path TO ods;

CREATE OR REPLACE FUNCTION ods.migrar_transformar_data()
RETURNS TRIGGER AS $$
BEGIN
    SET search_path TO ods;

    BEGIN
        IF NEW.proceso = 'fin_stg_ingesta' THEN
            RAISE NOTICE 'Ejecutando migrar_stg_a_ods()...';
            EXECUTE 'CALL ods.migrar_stg_a_ods()';
            RAISE NOTICE 'Finalizó migrar_stg_a_ods()';
        ELSIF NEW.proceso = 'fin_ods_ingesta' THEN
            RAISE NOTICE 'Ejecutando transformaciones_ods()...';
            EXECUTE 'CALL ods.transformaciones_ods()';
            RAISE NOTICE 'Finalizó transformaciones_ods()';
        ELSIF NEW.proceso = 'fin_ods_transformacion' THEN
            RAISE NOTICE 'Ejecutando migrar_ods_dw()...';
            EXECUTE 'CALL ods.migrar_ods_dw()';
            RAISE NOTICE 'Finalizó migrar_ods_dw()';
        END IF;

        RETURN NEW;

    EXCEPTION
        WHEN OTHERS THEN
            RAISE NOTICE 'Error en el trigger migrar_transformar_data(): %', SQLERRM;
            RETURN NEW;
    END;
END;
$$ LANGUAGE plpgsql;



-- ############## TRIGGER PARA DISPARAR FUNCION #############
create OR REPLACE TRIGGER trigger_ultima_fecha_ingesta
AFTER INSERT ON ods.ultima_fecha_ingesta
FOR EACH ROW
EXECUTE FUNCTION ods.migrar_transformar_data();

