/******************************************************************************
 ******************** CREACION TABLAS STAGING **********************************
 *******************************************************************************/
create schema if not exists stg;

-- stg.  articulo definition

-- Drop table

DROP TABLE if exists stg.articulo;

CREATE table if not exists  stg.articulo (
	claart text NULL,
	codigo text NULL,
	nombre text NULL,
	refprov text NULL,
	ultven text NULL,
	clapro text NULL,
	pvp1 text NULL,
	pvp2 text NULL,
	pvp1iva text NULL,
	pvp2iva text NULL,
	tiva text NULL,
	prulcom text NULL,
	pmp text NULL,
	clafam text NULL,
	exmin text NULL,
	exmax text NULL,
	pedmin text NULL,
	tyc text NULL,
	clatal text NULL,
	lotes text NULL,
	caduca text NULL,
	escandallo text NULL,
	servicio text NULL,
	multilin text NULL,
	componente text NULL,
	clauni text NULL,
	descrip text NULL,
	fbitmap text NULL,
	pvp3 text NULL,
	pvp4 text NULL,
	pvp5 text NULL,
	pvp6 text NULL,
	pvp7 text NULL,
	pvp8 text NULL,
	pvp9 text NULL,
	pvp10 text NULL,
	pvp3iva text NULL,
	pvp4iva text NULL,
	pvp5iva text NULL,
	pvp6iva text NULL,
	pvp7iva text NULL,
	pvp8iva text NULL,
	pvp9iva text NULL,
	pvp10iva text NULL,
	sergar text NULL,
	garmonth text NULL,
	multiuni text NULL,
	clapv text NULL,
	ubica text NULL,
	baja text NULL,
	orden text NULL,
	favorito text NULL,
	impcocina text NULL,
	vtaonline text NULL,
	shortdesc text NULL,
	longdesc text NULL,
	imgonline1 text NULL,
	imgonline2 text NULL,
	imgonline3 text NULL,
	imgonline4 text NULL,
	posimg text NULL,
	artpack text NULL,
	pvponline text NULL,
	pvpoferta text NULL,
	oferta text NULL,
	video text NULL,
	palclave text NULL,
	clamarca text NULL,
	atrib1 text NULL,
	atrib2 text NULL,
	atrib3 text NULL,
	atrib4 text NULL,
	atrib5 text NULL,
	atrib6 text NULL,
	atrib7 text NULL,
	atrib8 text NULL,
	atrib9 text NULL,
	atrib10 text NULL,
	atrib11 text NULL,
	atrib12 text NULL,
	atrib13 text NULL,
	atrib14 text NULL,
	atrib15 text NULL,
	atrib16 text NULL,
	docsweb text NULL,
	nombreweb text NULL,
	oblmodif text NULL,
	tasa text NULL,
	tipocoste text NULL,
	porcent text NULL,
	desctasa text NULL,
	desglosar text NULL,
	clatasa text NULL,
	coniva text NULL,
	agrupatasa text NULL,
	claprinter text NULL,
	clamenuh text NULL,
	clagcocina text NULL,
	combinar text NULL,
	pvpivacom1 text NULL,
	pvpivacom2 text NULL,
	medidaref text NULL,
	cantref text NULL,
	noagrupar text NULL,
	claequiva text NULL,
	"_fecha_ingesta" timestamp DEFAULT CURRENT_TIMESTAMP NULL
);





-- stg.  familias definition

-- Drop table

DROP TABLE if exists stg.familias;

CREATE TABLE  IF NOT EXISTS stg.familias (
	clafam text NULL,
	nomfam text NULL,
	clatal text NULL,
	tyc text NULL,
	escandallo text NULL,
	componente text NULL,
	sergar text NULL,
	garmonth text NULL,
	multiuni text NULL,
	clauni text NULL,
	tactil text NULL,
	imagen text NULL,
	orden text NULL,
	favorito text NULL,
	impcocina text NULL,
	vtaonline text NULL,
	claparent text NULL,
	grupo text NULL,
	posimg text NULL,
	pvponline text NULL,
	palclave text NULL,
	imgweb text NULL,
	imgwebp text NULL,
	descr text NULL,
	ordenweb text NULL,
	atributos text NULL,
	pvpmin text NULL,
	claprinter text NULL,
	clagcocina text NULL,
	noagrupar text NULL,
	epigrafe text null,
	"_fecha_ingesta" timestamp DEFAULT CURRENT_TIMESTAMP NULL
);





-- stg.  clientes definition

-- Drop table

DROP TABLE if exists stg.clientes;

CREATE TABLE if not exists stg.clientes (
	clacli text NULL,
	codigo text NULL,
	nombre text NULL,
	direccion text NULL,
	localidad text NULL,
	provincia text NULL,
	postal text NULL,
	pais text NULL,
	notas2 text NULL,
	notas3 text NULL,
	falta text NULL,
	nomban text NULL,
	dirban text NULL,
	locban text NULL,
	provban text NULL,
	ofiban text NULL,
	enti text NULL,
	ofic text NULL,
	ncta text NULL,
	dc text NULL,
	pago1 text NULL,
	pago2 text NULL,
	pago3 text NULL,
	pago4 text NULL,
	dtopp text NULL,
	dtocial text NULL,
	nctacon text NULL,
	riesgo text NULL,
	regimeniva text NULL,
	dpago1 text NULL,
	dpago2 text NULL,
	contact1 text NULL,
	cargo1 text NULL,
	telcont1 text NULL,
	contact2 text NULL,
	cargo2 text NULL,
	telcont2 text NULL,
	contact3 text NULL,
	cargo3 text NULL,
	telcont3 text NULL,
	contact4 text NULL,
	cargo4 text NULL,
	telcont4 text NULL,
	notas text NULL,
	portes text NULL,
	portesdesd text NULL,
	agrupalb text NULL,
	noalb text NULL,
	claage text NULL,
	clafpa text NULL,
	clatip text NULL,
	clatra text NULL,
	clazon text NULL,
	clatar text NULL,
	nombrecom text NULL,
	ncodprov text NULL,
	iban text NULL,
	gpslat text NULL,
	gpslon text NULL,
	emailfe text NULL,
	consumidor text NULL,
	nomuser text NULL,
	"password" text NULL,
	bic text NULL,
	refunicto text NULL,
	fechacto text NULL,
	firstrcbo text NULL,
	admpubli text NULL,
	claadmon text NULL,
	novalestpv text NULL,
	altaonline text NULL,
	bajaonline text NULL,
	msg_online text NULL,
	emailconf text NULL,
	nomcnt text NULL,
	apellcnt text NULL,
	resetcount text NULL,
	resetdate text NULL,
	clapais text NULL,
	claun text NULL,
	nopubli text NULL,
	codregiva text NULL,
	ftipfacven text NULL,
	tipocif text NULL,
	codpais text NULL,
	tipocobro text NULL,
	aplitartpv text NULL,
	baja text NULL,
	"_fecha_ingesta" timestamp DEFAULT CURRENT_TIMESTAMP NULL
) ;



-- stg.  ticket definition

-- Drop table

DROP TABLE IF EXISTS stg.tickets_202301 CASCADE;

CREATE table if not exists stg.tickets (
	clatik text NULL,
	claemp text NULL,
	claeje text NULL,
	clatpv text NULL,
	fecha text NULL,
	clacli text NULL,
	codcli text NULL,
	numero text NULL,
	total text NULL,
	pagado text NULL,
	claven text NULL,
	clatjt text NULL,
	contab text NULL,
	hora text NULL,
	claelem text NULL,
	abierto text NULL,
	clacie text NULL,
	"version" text NULL,
	encobro text NULL,
	clavenpda text NULL,
	clafac text NULL,
	dircli text NULL,
	loccli text NULL,
	provcli text NULL,
	poscli text NULL,
	emcli text NULL,
	seriefac text NULL,
	numfac text NULL,
	entrega text NULL,
	cambiodev text NULL,
	refpagotjt text NULL,
	comitjt text NULL,
	npedidotjt text NULL,
	clavaltpv text NULL,
	valesdto text NULL,
	itevales text NULL,
	tarjeta text NULL,
	fechahora text NULL,
	comensales text NULL,
	fechorafin text NULL,
	agrupapago text NULL,
	claliqtpv text NULL,
	preimpreso text NULL,
	iduserapp text NULL,
	estbai text null,
	"_fecha_ingesta" timestamp DEFAULT CURRENT_TIMESTAMP NULL
) ;

-- stg.  lineaticket definition

-- Drop table

DROP TABLE if exists stg.lineaticket;

CREATE TABLE  IF NOT EXISTS stg.lineaticket (
	clatikl text NULL,
	clatik text NULL,
	claart text NULL,
	cantidad text NULL,
	codigo text NULL,
	lindesc text NULL,
	dto text NULL,
	iva text NULL,
	precio text NULL,
	precioiva text NULL,
	tyc text NULL,
	tc1 text NULL,
	tc2 text NULL,
	tc3 text NULL,
	tc4 text NULL,
	tc5 text NULL,
	tc6 text NULL,
	tc7 text NULL,
	tc8 text NULL,
	tc9 text NULL,
	tc10 text NULL,
	tc11 text NULL,
	clacol text NULL,
	color text NULL,
	mtln text NULL,
	alkz text NULL,
	mtlnum text NULL,
	modificad text NULL,
	impreso text NULL,
	canant text NULL,
	canantc text NULL,
	yapagado text NULL,
	numserie text NULL,
	vtogarant text NULL,
	sergar text NULL,
	tasa text NULL,
	clatasa text NULL,
	clamenuh text NULL,
	idmenuh text NULL,
	clagcocina text NULL,
	precioiva2 text NULL,
	precio2 text NULL,
	combinado text NULL,
	claartcomb text NULL,
	pvpivacomb text NULL,
	pvpcomb text NULL,
	pesada text null,
	"_fecha_ingesta" timestamp DEFAULT CURRENT_TIMESTAMP NULL
) ;



/******************************************************************************
 ******************** CREACION TABLAS ODS *************************************
 *******************************************************************************/

-- Seleccionar schema
create schema if not exists ods;
SET search_path TO ods;


-- ods.articulo definition

-- Drop table

-- DROP TABLE ods.articulo;

create table if not exists ods.ods_articulo (
	cla_art int4 NOT NULL,
	codigo varchar(100) NULL,
	nombre varchar(255) NULL,
	ref_prov varchar(100) NULL,
	pvp1 numeric(10, 2) NULL,
	pvp2 numeric(10, 2) NULL,
	pvp1_iva numeric(10, 2) NULL,
	pvp2_iva numeric(10, 2) NULL,
	t_iva int4 NULL,
	pr_ul_com numeric(10, 2) NULL,
	pmp numeric(10, 2) NULL,
	cla_fam int4 NULL,
	pvp_online numeric(10, 2) NULL,
	pvp_oferta numeric(10, 2) NULL,
	oferta int4 NULL,
	"_fecha_ingesta" timestamp DEFAULT CURRENT_TIMESTAMP NULL
,	CONSTRAINT articulo_pkey PRIMARY KEY (cla_art)
);

COMMENT ON TABLE ods.ods_articulo IS 'Tabla que almacena la información de los artículos.';
COMMENT ON COLUMN ods.ods_articulo.cla_art IS 'Clave única del artículo.';
COMMENT ON COLUMN ods.ods_articulo.codigo IS 'Código del artículo.';
COMMENT ON COLUMN ods.ods_articulo.nombre IS 'Nombre del artículo.';
COMMENT ON COLUMN ods.ods_articulo.ref_prov IS 'Referencia del proveedor.';
COMMENT ON COLUMN ods.ods_articulo.pvp1 IS 'Precio de venta al público 1.';
COMMENT ON COLUMN ods.ods_articulo.pvp2 IS 'Precio de venta al público 2.';
COMMENT ON COLUMN ods.ods_articulo.pvp1_iva IS 'Precio de venta al público 1 con IVA.';
COMMENT ON COLUMN ods.ods_articulo.pvp2_iva IS 'Precio de venta al público 2 con IVA.';
COMMENT ON COLUMN ods.ods_articulo.t_iva IS 'Tipo de IVA aplicable al artículo.';
COMMENT ON COLUMN ods.ods_articulo.pr_ul_com IS 'Precio de la última compra.';
COMMENT ON COLUMN ods.ods_articulo.pmp IS 'Precio medio ponderado.';
COMMENT ON COLUMN ods.ods_articulo.cla_fam IS 'Clave de la familia a la que pertenece el artículo.';
COMMENT ON COLUMN ods.ods_articulo.pvp_online IS 'Precio de venta al público online.';
COMMENT ON COLUMN ods.ods_articulo.pvp_oferta IS 'Precio de venta al público en oferta.';
COMMENT ON COLUMN ods.ods_articulo.oferta IS 'Indicador de si el artículo está en oferta (1) o no (0).';
COMMENT ON COLUMN ods.ods_articulo."_fecha_ingesta" IS 'Fecha y hora de ingesta del registro.';

-- ods.clientes definition

-- Drop table

-- DROP TABLE ods.clientes;

create table if not exists ods.ods_clientes (
	cla_cli int4 NOT NULL,
	codigo int4 NULL,
	nombre varchar(255) NULL,
	provincia varchar(100) NULL,
	postal varchar(20) NULL,
	pais varchar(100) NULL,
	fecha_alta date NULL,
	regimen_iva int4 NULL,
	consumidor int4 NULL,
	"_fecha_ingesta" timestamp DEFAULT CURRENT_TIMESTAMP null,
	CONSTRAINT clientes_pkey PRIMARY KEY (cla_cli)
);

COMMENT ON TABLE ods.ods_clientes IS 'Tabla que almacena la información de los clientes.';
COMMENT ON COLUMN ods.ods_clientes.cla_cli IS 'Clave única del cliente.';
COMMENT ON COLUMN ods.ods_clientes.codigo IS 'Código del cliente.';
COMMENT ON COLUMN ods.ods_clientes.nombre IS 'Nombre del cliente.';
COMMENT ON COLUMN ods.ods_clientes.provincia IS 'Provincia del cliente.';
COMMENT ON COLUMN ods.ods_clientes.postal IS 'Código postal del cliente.';
COMMENT ON COLUMN ods.ods_clientes.pais IS 'País del cliente.';
COMMENT ON COLUMN ods.ods_clientes.fecha_alta IS 'Fecha de alta del cliente.';
COMMENT ON COLUMN ods.ods_clientes.regimen_iva IS 'Régimen de IVA del cliente.';
COMMENT ON COLUMN ods.ods_clientes.consumidor IS 'Indicador de si el cliente es consumidor final (1) o no (0).';
COMMENT ON COLUMN ods.ods_clientes."_fecha_ingesta" IS 'Fecha y hora de ingesta del registro.';

-- ods.familia definition

-- Drop table

-- DROP TABLE ods.familia;

create table if not exists ods.ods_familia (
	cla_fam int4 NOT NULL,
	nom_fam varchar(255) NULL,
	cla_tal int4 NULL,
	cla_parent int4 NULL,
	pvp_online numeric(10, 2) NULL,
	pal_clave text NULL,
	"_fecha_ingesta" timestamp DEFAULT CURRENT_TIMESTAMP null,
	CONSTRAINT familia_pkey PRIMARY KEY (cla_fam)
);

COMMENT ON TABLE ods.ods_familia IS 'Tabla que almacena la información de las familias de artículos.';
COMMENT ON COLUMN ods.ods_familia.cla_fam IS 'Clave única de la familia.';
COMMENT ON COLUMN ods.ods_familia.nom_fam IS 'Nombre de la familia.';
COMMENT ON COLUMN ods.ods_familia.cla_tal IS 'Clave de la talla asociada a la familia.';
COMMENT ON COLUMN ods.ods_familia.cla_parent IS 'Clave de la familia padre (si existe).';
COMMENT ON COLUMN ods.ods_familia.pvp_online IS 'Precio de venta al público online.';
COMMENT ON COLUMN ods.ods_familia.pal_clave IS 'Palabras clave asociadas a la familia.';
COMMENT ON COLUMN ods.ods_familia."_fecha_ingesta" IS 'Fecha y hora de ingesta del registro.';



-- ods.linea_ticket definition

-- Drop table

-- DROP TABLE ods.linea_ticket;

create table if not exists ods.ods_linea_ticket (
	cla_tikl int4 NOT NULL,
	cla_tik int4 NULL,
	cla_art int4 NULL,
	cantidad numeric(10, 2) NULL,
	codigo varchar(50) NULL,
	lin_desc varchar(255) NULL,
	dto numeric(5, 2) NULL,
	iva numeric(5, 2) NULL,
	precio numeric(10, 2) NULL,
	precio_iva numeric(10, 2) NULL,
	vto_garant varchar(50) NULL,
	"_fecha_ingesta" timestamp DEFAULT CURRENT_TIMESTAMP null,
	CONSTRAINT linea_ticket_pkey PRIMARY KEY (cla_tikl)
);

COMMENT ON TABLE ods.ods_linea_ticket IS 'Tabla que almacena la información de las líneas de los tickets.';
COMMENT ON COLUMN ods.ods_linea_ticket.cla_tikl IS 'Clave única de la línea de ticket.';
COMMENT ON COLUMN ods.ods_linea_ticket.cla_tik IS 'Clave del ticket al que pertenece la línea.';
COMMENT ON COLUMN ods.ods_linea_ticket.cla_art IS 'Clave del artículo asociado a la línea.';
COMMENT ON COLUMN ods.ods_linea_ticket.cantidad IS 'Cantidad de artículos en la línea.';
COMMENT ON COLUMN ods.ods_linea_ticket.codigo IS 'Código del artículo en la línea.';
COMMENT ON COLUMN ods.ods_linea_ticket.lin_desc IS 'Descripción de la línea.';
COMMENT ON COLUMN ods.ods_linea_ticket.dto IS 'Descuento aplicado en la línea.';
COMMENT ON COLUMN ods.ods_linea_ticket.iva IS 'IVA aplicado en la línea.';
COMMENT ON COLUMN ods.ods_linea_ticket.precio IS 'Precio unitario del artículo en la línea.';
COMMENT ON COLUMN ods.ods_linea_ticket.precio_iva IS 'Precio unitario del artículo con IVA en la línea.';
COMMENT ON COLUMN ods.ods_linea_ticket.vto_garant IS 'Fecha de vencimiento de la garantía (si aplica).';
COMMENT ON COLUMN ods.ods_linea_ticket."_fecha_ingesta" IS 'Fecha y hora de ingesta del registro.';


-- ods.ticket definition

-- Drop table

-- DROP TABLE ods.ticket;

create table if not exists ods.ods_ticket (
	cla_tik int4 NOT NULL,
	cla_emp int4 NULL,
	cla_eje int4 NULL,
	cla_tpv int4 NULL,
	cla_cli int4 NULL,
	cod_cli int4 NULL,
	numero int4 NULL,
	total numeric(10, 2) NULL,
	pagado numeric(10, 2) NULL,
	cla_ven int4 NULL,
	cla_fac int4 NULL,
	prov_cli varchar(100) NULL,
	pos_cli varchar(20) NULL,
	entrega numeric(10, 2) NULL,
	cambio_dev numeric(10, 2) NULL,
	tarjeta numeric(10, 2) NULL,
	fecha_hora timestamp NULL,
	"_fecha_ingesta" timestamp DEFAULT CURRENT_TIMESTAMP null,
	CONSTRAINT ticket_pkey PRIMARY KEY (cla_tik)
);

COMMENT ON TABLE ods.ods_ticket IS 'Tabla que almacena la información de los tickets.';
COMMENT ON COLUMN ods.ods_ticket.cla_tik IS 'Clave única del ticket.';
COMMENT ON COLUMN ods.ods_ticket.cla_emp IS 'Clave de la empresa asociada al ticket.';
COMMENT ON COLUMN ods.ods_ticket.cla_eje IS 'Clave del ejercicio asociado al ticket.';
COMMENT ON COLUMN ods.ods_ticket.cla_tpv IS 'Clave del TPV (Terminal Punto de Venta) asociado al ticket.';
COMMENT ON COLUMN ods.ods_ticket.cla_cli IS 'Clave del cliente asociado al ticket.';
COMMENT ON COLUMN ods.ods_ticket.cod_cli IS 'Código del cliente asociado al ticket.';
COMMENT ON COLUMN ods.ods_ticket.numero IS 'Número del ticket.';
COMMENT ON COLUMN ods.ods_ticket.total IS 'Total del ticket.';
COMMENT ON COLUMN ods.ods_ticket.pagado IS 'Cantidad pagada en el ticket.';
COMMENT ON COLUMN ods.ods_ticket.cla_ven IS 'Clave del vendedor asociado al ticket.';
COMMENT ON COLUMN ods.ods_ticket.cla_fac IS 'Clave de la factura asociada al ticket (si existe).';
COMMENT ON COLUMN ods.ods_ticket.prov_cli IS 'Provincia del cliente asociado al ticket.';
COMMENT ON COLUMN ods.ods_ticket.pos_cli IS 'Código postal del cliente asociado al ticket.';
COMMENT ON COLUMN ods.ods_ticket.entrega IS 'Cantidad entregada en el ticket.';
COMMENT ON COLUMN ods.ods_ticket.cambio_dev IS 'Cambio o devolución en el ticket.';
COMMENT ON COLUMN ods.ods_ticket.tarjeta IS 'Cantidad pagada con tarjeta en el ticket.';
COMMENT ON COLUMN ods.ods_ticket.fecha_hora IS 'Fecha y hora del ticket.';
COMMENT ON COLUMN ods.ods_ticket."_fecha_ingesta" IS 'Fecha y hora de ingesta del registro.';

-- TABLA para guardar las ingestas que se realizan en las bbdd

-- DROP TABLE ods.ultima_fecha_ingesta;
CREATE TABLE ods.ultima_fecha_ingesta (
	proceso varchar(50) NULL,
	fecha_hora timestamp NULL
);



/******************************************************************************
 ******************** CREACION TABLAS DW *************************************
 *******************************************************************************/
create schema if not exists dw;
SET search_path TO dw;


-- 📌 DIMENSIÓN CLIENTES
DROP TABLE IF EXISTS dim_clientes;
CREATE TABLE IF NOT EXISTS dim_clientes (
    cla_cli      INTEGER PRIMARY KEY,  
    codigo       INTEGER,             
    nombre       VARCHAR(255),         
    provincia    VARCHAR(100),         
    postal       VARCHAR(20),          
    pais         VARCHAR(100),         
    fecha_alta   DATE,
    regimen_iva  INTEGER,              
    consumidor   BOOLEAN
);

COMMENT ON TABLE dim_clientes IS 'Dimensión de clientes, almacena información de cada cliente registrado';
COMMENT ON COLUMN dim_clientes.cla_cli IS 'Clave única del cliente';
COMMENT ON COLUMN dim_clientes.codigo IS 'Código del cliente en el sistema';
COMMENT ON COLUMN dim_clientes.nombre IS 'Nombre completo del cliente';
COMMENT ON COLUMN dim_clientes.provincia IS 'Provincia del cliente';
COMMENT ON COLUMN dim_clientes.postal IS 'Código postal del cliente';
COMMENT ON COLUMN dim_clientes.pais IS 'País del cliente';
COMMENT ON COLUMN dim_clientes.fecha_alta IS 'Fecha de alta del cliente';
COMMENT ON COLUMN dim_clientes.regimen_iva IS 'Régimen de IVA del cliente';
COMMENT ON COLUMN dim_clientes.consumidor IS 'Indica si es consumidor final (TRUE/FALSE)';


-- 📌 DIMENSIÓN FAMILIAS
DROP TABLE IF EXISTS dim_familias;
CREATE TABLE IF NOT EXISTS dim_familias (
    cla_fam      INTEGER PRIMARY KEY,  
    nom_fam      VARCHAR(255),         
    cla_tal      INTEGER,              
    pal_clave    TEXT
);

COMMENT ON TABLE dim_familias IS 'Dimensión de familias de productos';
COMMENT ON COLUMN dim_familias.cla_fam IS 'Clave única de la familia';
COMMENT ON COLUMN dim_familias.nom_fam IS 'Nombre de la familia';
COMMENT ON COLUMN dim_familias.cla_tal IS 'Código de la talla asociada';
COMMENT ON COLUMN dim_familias.pal_clave IS 'Palabras clave relacionadas con la familia';


-- 📌 DIMENSIÓN ARTÍCULOS
DROP TABLE IF EXISTS dim_articulos;
CREATE TABLE IF NOT EXISTS dim_articulos (
    cla_art      INTEGER PRIMARY KEY,  
    codigo       VARCHAR(100),         
    nombre       VARCHAR(255),         
    ref_prov     VARCHAR(100),         
    pvp1         NUMERIC(10, 2),       
    pvp2         NUMERIC(10, 2),       
    pvp1_iva     NUMERIC(10, 2),       
    pvp2_iva     NUMERIC(10, 2),       
    t_iva        INTEGER,              
    pr_ul_com    NUMERIC(10, 2),       
    pmp          NUMERIC(10, 2),       
    pvp_online   NUMERIC(10, 2),       
    pvp_oferta   NUMERIC(10, 2),       
    oferta       BOOLEAN,              
    cla_fam      INTEGER REFERENCES dim_familias(cla_fam)
);

COMMENT ON TABLE dim_articulos IS 'Dimensión de artículos, almacena información de cada producto vendido';
COMMENT ON COLUMN dim_articulos.cla_art IS 'Clave única del artículo';
COMMENT ON COLUMN dim_articulos.codigo IS 'Código del artículo (EAN/UPC o interno)';
COMMENT ON COLUMN dim_articulos.nombre IS 'Nombre descriptivo del artículo';
COMMENT ON COLUMN dim_articulos.ref_prov IS 'Referencia del proveedor para el artículo';
COMMENT ON COLUMN dim_articulos.pvp1 IS 'Precio de venta al público 1';
COMMENT ON COLUMN dim_articulos.pvp2 IS 'Precio de venta al público 2';
COMMENT ON COLUMN dim_articulos.pvp1_iva IS 'Precio de venta al público 1 con IVA incluido';
COMMENT ON COLUMN dim_articulos.pvp2_iva IS 'Precio de venta al público 2 con IVA incluido';
COMMENT ON COLUMN dim_articulos.t_iva IS 'Tipo de IVA aplicado al artículo';
COMMENT ON COLUMN dim_articulos.pr_ul_com IS 'Precio de última compra';
COMMENT ON COLUMN dim_articulos.pmp IS 'Precio medio ponderado';
COMMENT ON COLUMN dim_articulos.pvp_online IS 'Precio de venta online';
COMMENT ON COLUMN dim_articulos.pvp_oferta IS 'Precio de oferta del artículo';
COMMENT ON COLUMN dim_articulos.oferta IS 'Indica si el artículo está en oferta (TRUE/FALSE)';
COMMENT ON COLUMN dim_articulos.cla_fam IS 'Clave de la familia a la que pertenece el artículo';




-- 📌 DIMENSIÓN TICKET
DROP TABLE IF EXISTS dim_ticket;
CREATE TABLE IF NOT EXISTS dim_ticket (
    cla_tik      INTEGER PRIMARY KEY,  
    cla_emp      INTEGER,         
    numero       INTEGER,         
    total        NUMERIC(10, 2),       
    pagado       NUMERIC(10, 2),       
    cla_tjt      INTEGER,
    serie_fac    VARCHAR(3),
    num_fac      INTEGER,
    pago_tarjeta BOOLEAN,
    fecha_hora   TIMESTAMP
);

COMMENT ON TABLE dim_ticket IS 'Dimensión de tickets, almacena información de cada transacción de venta';
COMMENT ON COLUMN dim_ticket.cla_tik IS 'Clave única del ticket';
COMMENT ON COLUMN dim_ticket.cla_emp IS 'Clave de la empresa asociada al ticket';
COMMENT ON COLUMN dim_ticket.numero IS 'Número del ticket';
COMMENT ON COLUMN dim_ticket.total IS 'Total de la venta';
COMMENT ON COLUMN dim_ticket.pagado IS 'Monto pagado por el cliente';
COMMENT ON COLUMN dim_ticket.cla_tjt IS 'Clave de la tarjeta utilizada en el pago';
COMMENT ON COLUMN dim_ticket.serie_fac IS 'Serie de la factura asociada al ticket';
COMMENT ON COLUMN dim_ticket.num_fac IS 'Número de la factura';
COMMENT ON COLUMN dim_ticket.pago_tarjeta IS 'Indica si el pago fue con tarjeta (TRUE/FALSE)';
COMMENT ON COLUMN dim_ticket.fecha_hora IS 'Fecha y hora de la transacción';



-- 📌 TABLA DE HECHOS: VENTAS
DROP TABLE IF EXISTS ventas;
CREATE TABLE IF NOT EXISTS ventas (
    cla_tikl          INTEGER,  
    fecha_hora        TIMESTAMP,  
    cla_tik          INTEGER,  
    cla_cli          INTEGER,  
    cla_art          INTEGER,  
    cla_fam          INTEGER,  
    cla_tpv          INTEGER,  
    cla_ven          INTEGER,  

    -- Métricas
    cantidad         NUMERIC(10, 2),  
    precio           NUMERIC(10, 2),  
    precio_iva       NUMERIC(10, 2),  
    precio_total_articulos NUMERIC(10, 2),
    precio_total_articulos_iva NUMERIC(10, 2),
    tarjeta          boolean,  
    
    PRIMARY KEY (cla_tikl, cla_tik, cla_art, cla_cli),


    CONSTRAINT fk_clientes FOREIGN KEY (cla_cli) REFERENCES dim_clientes(cla_cli),
    CONSTRAINT fk_articulo FOREIGN KEY (cla_art) REFERENCES dim_articulos(cla_art),
    CONSTRAINT fk_familia FOREIGN KEY (cla_fam) REFERENCES dim_familias(cla_fam),
    CONSTRAINT fk_ticket FOREIGN KEY (cla_tik) REFERENCES dim_ticket(cla_tik)
);

COMMENT ON TABLE ventas IS 'Tabla de hechos de ventas, almacena todas las transacciones';






