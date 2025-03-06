
/*
###############################################################################################################
########################################## CREACION SP ########################################################
###############################################################################################################
*/
create schema if not exists ods;

SET search_path TO ods;

/*
 * ######################## SP staging ---> ODS ########################
 * */
CREATE OR REPLACE PROCEDURE ods.migrar_stg_a_ods()
LANGUAGE plpgsql
AS $$
BEGIN

/*
#################################### SETEO SCHEMA Y FECHA CORRIDA #############################################
*/

 -- Seteo schema
SET search_path TO ods;

-- Se inserta Inicio de corrida de la ingesta en ODS
insert into ultima_fecha_ingesta (proceso, fecha_hora)
values( 'inicio_ods_ingesta', clock_timestamp() );

/*
########################################## CARGA TABLAS ODS ###################################################
*/
-- Clientes
WITH registros_eliminar AS (
    SELECT CAST(c.clacli AS INTEGER) AS clacli
    FROM stg.clientes c
    WHERE c._fecha_ingesta > CURRENT_DATE - INTERVAL '3 days'
)
DELETE FROM ods.ods_clientes dc
WHERE dc.cla_cli IN (SELECT clacli FROM registros_eliminar);

INSERT INTO ods.ods_clientes (
    cla_cli,
    codigo,
    nombre,
    provincia,
    postal,
    pais,
    fecha_alta,
    regimen_iva,
    consumidor
)
SELECT 
    CAST(clacli AS INTEGER), 
    CAST(codigo AS INTEGER),
    nullif(c.nombre, 'NaN'),
    nullif(c.provincia, 'NaN'),
    nullif(c.postal, 'NaN'),
    nullif(C.pais, 'NaN'),
    TO_DATE(NULLIF(falta, 'NaN'), 'DD/MM/YYYY'),
    CAST(NULLIF(regimeniva, 'NaN') AS INTEGER),
    CAST(NULLIF(consumidor , 'NaN')AS INTEGER)
FROM stg.clientes c
WHERE c._fecha_ingesta > CURRENT_DATE - INTERVAL '3 days';

-- ods_articulo

WITH registros_eliminar AS (
    SELECT CAST(claart AS INTEGER) AS claart
    FROM stg.articulo
    WHERE _fecha_ingesta > CURRENT_DATE - INTERVAL '3 days'
)
DELETE FROM ods.ods_articulo oa
WHERE oa.cla_art IN (SELECT claart FROM registros_eliminar);

INSERT INTO ods.ods_articulo (
    cla_art,
    codigo,
    nombre,
    ref_prov,
    pvp1,
    pvp2,
    pvp1_iva,
    pvp2_iva,
    t_iva,
    pr_ul_com,
    pmp,
    cla_fam,
    pvp_online,
    pvp_oferta,
    oferta
)
SELECT 
    CAST(claart AS INTEGER), 
    nullif(codigo, 'NaN'),
    nullif(nombre, 'NaN'),
    nullif(refprov, 'NaN'),
    CAST(NULLIF(pvp1, 'NaN') AS NUMERIC(10,2)), 
    CAST(NULLIF(pvp2, 'NaN') AS NUMERIC(10,2)), 
    CAST(NULLIF(pvp1iva, 'NaN') AS NUMERIC(10,2)), 
    CAST(NULLIF(pvp2iva, 'NaN') AS NUMERIC(10,2)), 
    CAST(NULLIF(tiva, 'NaN') AS INTEGER), 
    CAST(NULLIF(prulcom, 'NaN') AS NUMERIC(10,2)), 
    CAST(NULLIF(pmp, 'NaN') AS NUMERIC(10,2)), 
    CAST(NULLIF(clafam, 'NaN') AS INTEGER), 
    CAST(NULLIF(pvponline, 'NaN') AS NUMERIC(10,2)), 
    CAST(NULLIF(pvpoferta, 'NaN') AS NUMERIC(10,2)), 
    CAST(NULLIF(oferta, 'NaN') AS INTEGER)
FROM stg.articulo
WHERE _fecha_ingesta > CURRENT_DATE - INTERVAL '3 days';

-- Eliminamos registros sin datos
delete FROM ods.ods_articulo a where codigo is null and nombre is null;


-- FAMILIA
WITH registros_eliminar AS (
    SELECT CAST(NULLIF(clafam , 'NaN') AS INTEGER) AS clafam
    FROM stg.familias
    WHERE _fecha_ingesta > CURRENT_DATE - INTERVAL '3 days'
)
DELETE FROM ods.ods_familia ofa
WHERE ofa.cla_fam IN (SELECT clafam FROM registros_eliminar);

INSERT INTO ods.ods_familia (
    cla_fam,
    nom_fam,
    cla_tal,
    cla_parent,
    pvp_online,
    pal_clave
)
SELECT 
    CAST(cast(NULLIF(clafam , 'NaN') as float) AS INTEGER), 
    nullif(nomfam,'NaN'), 
    CAST(cast(NULLIF(clatal, 'NaN') as float) AS INTEGER), 
    CAST(cast(NULLIF(claparent, 'NaN') as float) AS INTEGER), 
    CAST(NULLIF(pvponline, 'NaN') AS NUMERIC(10,2)), 
    nullif(palclave,'NaN')
FROM stg.familias
WHERE _fecha_ingesta > CURRENT_DATE - INTERVAL '3 days' 
and clafam != 'NaN'
ON CONFLICT (cla_fam)
DO nothing 
;


-- TICKET
WITH registros_eliminar AS (
    SELECT CAST(clatik AS INTEGER) AS clatik
    FROM stg.tickets
    WHERE _fecha_ingesta > CURRENT_DATE - INTERVAL '3 days'
)
DELETE FROM ods.ods_ticket ot
WHERE ot.cla_tik IN (SELECT clatik FROM registros_eliminar);

INSERT INTO ods.ods_ticket (
    cla_tik,
    cla_emp,
    cla_eje,
    cla_tpv,
    cla_cli,
    cod_cli,
    numero,
    total,
    pagado,
    cla_ven,
    cla_fac,
    prov_cli,
    pos_cli,
    entrega,
    cambio_dev,
    tarjeta,
    fecha_hora
)
SELECT 
    CAST(clatik AS INTEGER), 
    CAST(NULLIF(claemp, 'NaN') AS INTEGER), 
    CAST(NULLIF(claeje, 'NaN') AS INTEGER), 
    CAST(NULLIF(clatpv, 'NaN') AS INTEGER), 
    CAST(NULLIF(clacli, 'NaN') AS INTEGER), 
    CAST(NULLIF(codcli, 'NaN') AS INTEGER), 
    CAST(NULLIF(numero, 'NaN') AS INTEGER), 
    CAST(NULLIF(total, 'NaN') AS NUMERIC(10,2)), 
    CAST(NULLIF(pagado, 'NaN') AS NUMERIC(10,2)), 
    CAST(NULLIF(claven, 'NaN') AS INTEGER), 
    CAST(NULLIF(clafac, 'NaN') AS INTEGER), 
    NULLIF(provcli,'NaN'),
    NULLIF(poscli,'NaN'),
    CAST(NULLIF(entrega, 'NaN') AS NUMERIC(10,2)), 
    CAST(NULLIF(cambiodev, 'NaN') AS NUMERIC(10,2)), 
    cast(NULLIF(tarjeta,'NaN') AS NUMERIC(10,2)),
    TO_TIMESTAMP(NULLIF(fechahora, 'NaN'), 'DD/MM/YYYY HH24:MI')
FROM stg.tickets
WHERE _fecha_ingesta > CURRENT_DATE - INTERVAL '3 days'
ON CONFLICT (cla_tik)
DO nothing 
;


-- LOGICA TRANSFORMACION LINEA TICKET
WITH registros_eliminar AS (
    SELECT CAST(clatikl AS INTEGER) AS clatikl
    FROM stg.lineaticket
    WHERE _fecha_ingesta > CURRENT_DATE - INTERVAL '3 days'
)
DELETE FROM ods.ods_linea_ticket olt
WHERE olt.cla_tikl IN (SELECT clatikl FROM registros_eliminar);

INSERT INTO ods.ods_linea_ticket (
    cla_tikl,
    cla_tik,
    cla_art,
    cantidad,
    codigo,
    lin_desc,
    dto,
    iva,
    precio,
    precio_iva,
    vto_garant
)
SELECT 
    CAST(clatikl AS INTEGER), 
    CAST(NULLIF(clatik, 'NaN') AS INTEGER), 
    CAST(case when claart = 'NaN' or claart is null then '0' end AS INTEGER),  -- Se castea como 0 para asociarlo a los ods_articulos sin datos
    CAST(NULLIF(cantidad, 'NaN') AS NUMERIC(10,2)), 
    NULLIF(codigo,'NaN'),
    NULLIF(lindesc,'NaN'),
    CAST(NULLIF(dto, 'NaN') AS NUMERIC(5,2)), 
    CAST(NULLIF(iva, 'NaN') AS NUMERIC(5,2)), 
    CAST(NULLIF(precio, 'NaN') AS NUMERIC(10,2)), 
    CAST(NULLIF(precioiva, 'NaN') AS NUMERIC(10,2)), 
    vtogarant
FROM stg.lineaticket as src
WHERE src.claart is not null and src.claart != '0' and src.codigo is not null and src.lindesc is not null
and _fecha_ingesta > CURRENT_DATE - INTERVAL '3 days'
ON CONFLICT (cla_tikl)
DO nothing 
;

-- Se inserta final de corrida de la ingesta en ODS y guarda hora de finalización
insert into ultima_fecha_ingesta (proceso, fecha_hora)
values( 'fin_ods_ingesta', clock_timestamp() );


END;
$$;




/*
 * ###############################################################################################################
 * ######################## SP Transformaciones ODS ########################
 * */
CREATE OR REPLACE PROCEDURE ods.transformaciones_ods()
LANGUAGE plpgsql
AS $$
BEGIN

/*
#################################### SETEO SCHEMA Y FECHA CORRIDA #############################################
*/

 -- Seteo schema
SET search_path TO ods;

-- Se inserta Inicio de corrida de la ingesta en ODS
insert into ultima_fecha_ingesta (proceso, fecha_hora)
values( 'inicio_ods_transformacion', clock_timestamp() );

/*
########################################  TRANSFORMACIONES TABLAS #############################################
*/

-- ############### TABLA CLIENTES ###############

-- Lleno vacios de ids en la tabla
INSERT INTO ods.ods_clientes (cla_cli)
SELECT DISTINCT serie.id
FROM (
    SELECT c1.cla_cli + 1 AS id FROM ods.ods_clientes c1
    LEFT JOIN ods.ods_clientes c2 ON c1.cla_cli + 1 = c2.cla_cli
    WHERE c2.cla_cli IS NULL
) serie
WHERE NOT EXISTS (SELECT 1 FROM ods.ods_clientes c WHERE c.cla_cli = serie.id);

insert into ods.ods_clientes (cla_cli, nombre)
values(0, 'sin dato'); -- Para marcar a los clientes que no tenemos tickets y no sabemos procedencia (y no perder ese registro de ticket)


-- ############### TABLAS LINEA TICKETS Y ods_articuloS ###############


-- Elimino registros en donde no hay datos de clave ods_articulo ni código ni nombre
delete from ods.ods_linea_ticket where (cla_art is null or cla_art = '0') and codigo is null and lin_desc is  null;


-- Actualizar cla_art y codigo en una sola consulta
UPDATE ods.ods_linea_ticket lt
SET 
    cla_art = COALESCE(lt.cla_art, a.cla_art),
    codigo = COALESCE(lt.codigo, a.codigo)
FROM ods.ods_articulo a
WHERE lt.lin_desc = a.nombre 
AND (lt.cla_art IS NULL OR lt.cla_art = 0);


-- Creo registros en la tabla ods_articulos a partir de la combinación Codigo y Descripcion en linea_ticket
WITH nuevos_articulos AS (
    -- Obtener los códigos y descripciones sin artículo asociado
    SELECT DISTINCT lt.codigo, lt.lin_desc 
    FROM ods.ods_linea_ticket lt 
    LEFT JOIN ods.ods_articulo a ON lt.cla_art = a.cla_art 
    WHERE a.cla_art IS NULL
), max_id AS (
    -- Obtener el máximo cla_art en ods_articulo
    SELECT COALESCE(MAX(cla_art), 0) AS ultimo_id FROM ods.ods_articulo
)
-- Insertar nuevos artículos con IDs consecutivos
INSERT INTO ods.ods_articulo (cla_art, codigo, nombre)
SELECT 
    max_id.ultimo_id + ROW_NUMBER() OVER () AS cla_art, -- Genera IDs consecutivos
    na.codigo,
    na.lin_desc -- Asigna la descripción como nombre del artículo
FROM nuevos_articulos na, max_id;

-- Ingesto las nuevas claves en linea_ticket
UPDATE ods.ods_linea_ticket lt
SET cla_art = a.cla_art
FROM ods.ods_articulo a
WHERE lt.lin_desc = a.nombre and COALESCE(lt.codigo, '1') = COALESCE(a.codigo, '1')
AND lt.cla_art IS NULL;

-- Deleteo los registros que sigan sin clave y sin nombre 
delete from ods.ods_linea_ticket where cla_art is null and lin_desc is null;



-- Infiero claves de tickets faltantes para no perder datos de ventas con tickets viejos

-- insertar tickets que estan en linea_ticket
with tickets_faltantes as (
select olt.cla_tik 
from ods.ods_linea_ticket olt 
left join ods.ods_ticket ot on olt.cla_tik = ot.cla_tik
where ot.cla_tik is null )
insert into ods.ods_ticket (cla_tik)
select cla_tik from tickets_faltantes
ON CONFLICT (cla_tik)
DO nothing 
;


-- creamos una ods.ods_familia para los que no tienen familia
insert into ods.ods_familia (cla_fam,nom_fam)
values (0,'sin familia')
ON CONFLICT (cla_fam)
DO NOTHING;



-- Se inserta final de corrida de la ingesta en ODS
insert into ultima_fecha_ingesta (proceso, fecha_hora)
values( 'fin_ods_transformacion', clock_timestamp() );


END;
$$;




/*
 * ###############################################################################################################
 * ######################## SP ods ---> dw ########################
 * */
CREATE OR REPLACE PROCEDURE  ods.migrar_ods_dw()
LANGUAGE plpgsql
AS $$
BEGIN

/*
#################################### SETEO SCHEMA Y FECHA CORRIDA #############################################
*/

 -- Seteo schema
SET search_path TO ods;

-- Se inserta Inicio de corrida de la ingesta en ODS
insert into ultima_fecha_ingesta (proceso, fecha_hora)
values( 'inicio_dw_ingesta', clock_timestamp() );

/*
########################################  INGESTA  TABLAS #############################################
*/


-- # LOGICA INSERT DW

/*
 * Primero nos fijamos si la linea de ods.ods_ticket traer un clatik que ya exista en ventas
 * Si se encuentra uno que ya existe entonces se eliminan los registros de la tabla venta con ese clatik y luego de ticke --> se procede a insertar en ods.ods_ticket y luego en ventas
 * */

drop  table if exists ods.temp_tickets_insertar;
create table ods.temp_tickets_insertar as (
select cla_tik from ods.ods_ticket t where _fecha_ingesta > current_timestamp - interval '3 days'
);


-- 1) Eliminamos registros de ventas
delete from dw.ventas where cla_tik in (select cla_tik from ods.temp_tickets_insertar);

-- 2) Eliminamos registros de tickets
delete from dw.dim_ticket dt where dt.cla_tik in(select cla_tik from ods.temp_tickets_insertar);

insert into dw.dim_ticket (
cla_tik,
cla_emp,
numero,
total,
pagado,
pago_tarjeta,
fecha_hora
) select
cla_tik,
cla_emp,
numero,
total,
pagado,
case when tarjeta = 0.0 then fALSE else true end as pago_tarjeta,
fecha_hora
from ods.ods_ticket ot  where _fecha_ingesta > current_timestamp - interval '3 days'
ON CONFLICT (cla_tik)
DO nothing 
;


-- INSERT FAMILIAS
INSERT INTO dw.dim_familias
(cla_fam, nom_fam, cla_tal, pal_clave)
SELECT src.cla_fam, src.nom_fam, src.cla_tal, src.pal_clave
FROM ods.ods_familia  AS src
where
src._fecha_ingesta > current_timestamp - interval '3 days'
ON CONFLICT (cla_fam)
DO nothing 
;




-- INSERT ods_articuloS

INSERT INTO dw.dim_articulos
(cla_art, codigo, nombre, ref_prov, pvp1, pvp2, pvp1_iva, pvp2_iva, t_iva, pr_ul_com, pmp, pvp_online, pvp_oferta, oferta, cla_fam)
SELECT 
src.cla_art, 
src.codigo, 
src.nombre, 
src.ref_prov, 
src.pvp1, 
src.pvp2, 
src.pvp1_iva, 
src.pvp2_iva, 
src.t_iva, 
src.pr_ul_com, 
src.pmp, 
src.pvp_online, 
src.pvp_oferta, 
case when src.oferta = 1 then true else false end , 
src.cla_fam
FROM 
ods.ods_articulo AS src 
where _fecha_ingesta > current_timestamp - interval '3 days'
ON CONFLICT (cla_art)
DO NOTHING;



-- ###### DIM_CLIENTES

INSERT INTO dw.dim_clientes
(cla_cli, codigo, nombre, provincia, postal, pais, fecha_alta, regimen_iva, consumidor)
SELECT src.cla_cli, src.codigo, src.nombre, src.provincia, src.postal, src.pais, src.fecha_alta, src.regimen_iva, case when src.consumidor = 1 then true else false end
FROM ods.ods_clientes  AS src
where _fecha_ingesta > current_timestamp - interval '3 days'
ON CONFLICT (cla_cli)
DO nothing;



-- insert ventas
INSERT INTO dw.ventas
(cla_tikl, 
fecha_hora, 
cla_tik, 
cla_cli, 
cla_art, 
cla_fam, 
cla_tpv, 
cla_ven, 
cantidad, 
precio, 
precio_iva, 
precio_total_articulos, 
precio_total_articulos_iva,
tarjeta)
select distinct
lt.cla_tikl, 
dt.fecha_hora, 
lt.cla_tik,
coalesce(dt.cla_cli, 0),
lt.cla_art ,
a.cla_fam ,
dt.cla_tpv ,
dt.cla_ven ,
lt.cantidad ,
lt.precio ,
lt.precio_iva ,
(lt.precio * lt.cantidad) as precio_total_articulos,
(lt.precio_iva * lt.cantidad) as precio_total_articulos_iva,
case when tarjeta = 0.0 then fALSE else true end as pago_tarjeta
from ods.ods_linea_ticket lt 
left join ods.ods_ticket dt on lt.cla_tik  = dt.cla_tik 
LEFT join ods.ods_articulo a on lt.cla_art = a.cla_art 
where 
lt._fecha_ingesta > current_timestamp - interval '3 days'
ON CONFLICT (cla_tikl, cla_tik, cla_art, cla_cli)
DO nothing;

drop  table if exists ods.temp_tickets_insertar;


-- Se inserta final de corrida de la ingesta en ODS
insert into ultima_fecha_ingesta (proceso, fecha_hora)
values( 'fin_dw_ingesta', clock_timestamp() );

END;
$$;
