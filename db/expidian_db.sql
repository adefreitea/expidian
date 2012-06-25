--
-- PostgreSQL database dump
--

-- Dumped from database version 9.1.3
-- Dumped by pg_dump version 9.1.3
-- Started on 2012-05-17 07:14:18 VET

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 190 (class 3079 OID 11710)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2154 (class 0 OID 0)
-- Dependencies: 190
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- TOC entry 189 (class 3079 OID 16458)
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- TOC entry 2155 (class 0 OID 0)
-- Dependencies: 189
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


--
-- TOC entry 191 (class 3079 OID 16424)
-- Dependencies: 6
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- TOC entry 2156 (class 0 OID 0)
-- Dependencies: 191
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


SET search_path = public, pg_catalog;

--
-- TOC entry 236 (class 1255 OID 16467)
-- Dependencies: 6
-- Name: sha512(bytea); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION sha512(bytea) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
    SELECT encode(digest($1, 'sha512'), 'hex')
$_$;


SET default_tablespace = '';

SET default_with_oids = true;

--
-- TOC entry 188 (class 1259 OID 26180)
-- Dependencies: 2056 6
-- Name: bitacoras; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE bitacoras (
    id_bitacora integer NOT NULL,
    id_expidiente integer NOT NULL,
    bitacora text NOT NULL,
    fecha_registro date DEFAULT now() NOT NULL
);


--
-- TOC entry 187 (class 1259 OID 26178)
-- Dependencies: 188 6
-- Name: bitacoras_id_bitacora_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE bitacoras_id_bitacora_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2157 (class 0 OID 0)
-- Dependencies: 187
-- Name: bitacoras_id_bitacora_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE bitacoras_id_bitacora_seq OWNED BY bitacoras.id_bitacora;


--
-- TOC entry 2158 (class 0 OID 0)
-- Dependencies: 187
-- Name: bitacoras_id_bitacora_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('bitacoras_id_bitacora_seq', 1, false);


--
-- TOC entry 161 (class 1259 OID 21380)
-- Dependencies: 2035 6
-- Name: consultas; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE consultas (
    id_consulta integer NOT NULL,
    cedula_de_identidad character varying(15) NOT NULL,
    id_expediente integer NOT NULL,
    fecha_consulta date DEFAULT now() NOT NULL
);


--
-- TOC entry 162 (class 1259 OID 21383)
-- Dependencies: 6 161
-- Name: consultas_id_consulta_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE consultas_id_consulta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2159 (class 0 OID 0)
-- Dependencies: 162
-- Name: consultas_id_consulta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE consultas_id_consulta_seq OWNED BY consultas.id_consulta;


--
-- TOC entry 2160 (class 0 OID 0)
-- Dependencies: 162
-- Name: consultas_id_consulta_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('consultas_id_consulta_seq', 1, false);


--
-- TOC entry 163 (class 1259 OID 21385)
-- Dependencies: 2037 6
-- Name: control_movimientos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE control_movimientos (
    id_control_movimientos integer NOT NULL,
    id_expidiente integer NOT NULL,
    id_proceso integer NOT NULL,
    id_etapa integer NOT NULL,
    cod_expediente character varying(11) NOT NULL,
    id_abogado_coord integer,
    id_abogado_asign integer NOT NULL,
    fecha_movimiento date DEFAULT now() NOT NULL
);


--
-- TOC entry 164 (class 1259 OID 21388)
-- Dependencies: 6 163
-- Name: control_movimientos_id_control_movimientos_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE control_movimientos_id_control_movimientos_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2161 (class 0 OID 0)
-- Dependencies: 164
-- Name: control_movimientos_id_control_movimientos_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE control_movimientos_id_control_movimientos_seq OWNED BY control_movimientos.id_control_movimientos;


--
-- TOC entry 2162 (class 0 OID 0)
-- Dependencies: 164
-- Name: control_movimientos_id_control_movimientos_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('control_movimientos_id_control_movimientos_seq', 1, false);


--
-- TOC entry 165 (class 1259 OID 21390)
-- Dependencies: 6
-- Name: estados; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE estados (
    id_estado integer NOT NULL,
    estado character varying(60) NOT NULL,
    id_pais integer NOT NULL
);


--
-- TOC entry 166 (class 1259 OID 21393)
-- Dependencies: 165 6
-- Name: estados_id_estado_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE estados_id_estado_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2163 (class 0 OID 0)
-- Dependencies: 166
-- Name: estados_id_estado_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE estados_id_estado_seq OWNED BY estados.id_estado;


--
-- TOC entry 2164 (class 0 OID 0)
-- Dependencies: 166
-- Name: estados_id_estado_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('estados_id_estado_seq', 4292, true);


--
-- TOC entry 167 (class 1259 OID 21395)
-- Dependencies: 6
-- Name: etapas; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE etapas (
    id_etapa integer NOT NULL,
    etapa_abrev character varying(5) NOT NULL,
    etapa character varying(60) NOT NULL,
    nro_consecutivo_etapa integer NOT NULL,
    id_proceso integer NOT NULL
);


--
-- TOC entry 168 (class 1259 OID 21398)
-- Dependencies: 167 6
-- Name: etapas_id_etapa_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE etapas_id_etapa_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2165 (class 0 OID 0)
-- Dependencies: 168
-- Name: etapas_id_etapa_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE etapas_id_etapa_seq OWNED BY etapas.id_etapa;


--
-- TOC entry 2166 (class 0 OID 0)
-- Dependencies: 168
-- Name: etapas_id_etapa_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('etapas_id_etapa_seq', 1, false);


--
-- TOC entry 169 (class 1259 OID 21400)
-- Dependencies: 2041 2042 6
-- Name: expedientes; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE expedientes (
    id_expediente integer NOT NULL,
    id_organismo integer,
    hechos text,
    observaciones text,
    id_proceso_actual integer,
    id_etapa_actual integer,
    id_usuario_ini integer NOT NULL,
    sesssion_id character varying(255),
    confirm_inicial character varying(10) DEFAULT 'NO CONFIRMADO'::character varying,
    fecha_registro date DEFAULT now() NOT NULL,
    fecha_solic_invest date
);


--
-- TOC entry 170 (class 1259 OID 21406)
-- Dependencies: 169 6
-- Name: expedientes_id_expediente_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE expedientes_id_expediente_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2167 (class 0 OID 0)
-- Dependencies: 170
-- Name: expedientes_id_expediente_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE expedientes_id_expediente_seq OWNED BY expedientes.id_expediente;


--
-- TOC entry 2168 (class 0 OID 0)
-- Dependencies: 170
-- Name: expedientes_id_expediente_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('expedientes_id_expediente_seq', 1, false);


--
-- TOC entry 171 (class 1259 OID 21408)
-- Dependencies: 6
-- Name: interesados; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE interesados (
    id_interesado integer NOT NULL,
    id_expediente integer,
    cedula_de_identidad integer
);


--
-- TOC entry 172 (class 1259 OID 21411)
-- Dependencies: 6 171
-- Name: interesados_id_interesado_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE interesados_id_interesado_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2169 (class 0 OID 0)
-- Dependencies: 172
-- Name: interesados_id_interesado_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE interesados_id_interesado_seq OWNED BY interesados.id_interesado;


--
-- TOC entry 2170 (class 0 OID 0)
-- Dependencies: 172
-- Name: interesados_id_interesado_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('interesados_id_interesado_seq', 1, false);


--
-- TOC entry 173 (class 1259 OID 21413)
-- Dependencies: 2045 6
-- Name: logs_usuarios; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE logs_usuarios (
    id_log_usuario integer NOT NULL,
    id_usuario integer NOT NULL,
    log_usuario character varying(300) NOT NULL,
    estatus_final character varying(20),
    fecha_log timestamp without time zone DEFAULT now() NOT NULL
);


--
-- TOC entry 174 (class 1259 OID 21416)
-- Dependencies: 173 6
-- Name: logs_usuarios_id_log_usuario_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE logs_usuarios_id_log_usuario_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2171 (class 0 OID 0)
-- Dependencies: 174
-- Name: logs_usuarios_id_log_usuario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE logs_usuarios_id_log_usuario_seq OWNED BY logs_usuarios.id_log_usuario;


--
-- TOC entry 2172 (class 0 OID 0)
-- Dependencies: 174
-- Name: logs_usuarios_id_log_usuario_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('logs_usuarios_id_log_usuario_seq', 8, true);


--
-- TOC entry 175 (class 1259 OID 21426)
-- Dependencies: 6
-- Name: organismos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE organismos (
    id_organismo integer NOT NULL,
    rif character varying(12) NOT NULL,
    nombre_organismo character varying(60) NOT NULL,
    sector character varying(20) NOT NULL
);


--
-- TOC entry 176 (class 1259 OID 21429)
-- Dependencies: 175 6
-- Name: organismos_id_organismo_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE organismos_id_organismo_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2173 (class 0 OID 0)
-- Dependencies: 176
-- Name: organismos_id_organismo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE organismos_id_organismo_seq OWNED BY organismos.id_organismo;


--
-- TOC entry 2174 (class 0 OID 0)
-- Dependencies: 176
-- Name: organismos_id_organismo_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('organismos_id_organismo_seq', 1, false);


--
-- TOC entry 177 (class 1259 OID 21431)
-- Dependencies: 6
-- Name: paises; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE paises (
    id_pais integer NOT NULL,
    pais character varying(35) NOT NULL
);


--
-- TOC entry 178 (class 1259 OID 21434)
-- Dependencies: 6 177
-- Name: paises_id_pais_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE paises_id_pais_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2175 (class 0 OID 0)
-- Dependencies: 178
-- Name: paises_id_pais_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE paises_id_pais_seq OWNED BY paises.id_pais;


--
-- TOC entry 2176 (class 0 OID 0)
-- Dependencies: 178
-- Name: paises_id_pais_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('paises_id_pais_seq', 239, true);


--
-- TOC entry 179 (class 1259 OID 21436)
-- Dependencies: 6
-- Name: perfiles; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE perfiles (
    id_perfil integer NOT NULL,
    perfil character varying(50) NOT NULL,
    descripcion_perfil character varying(200) NOT NULL
);


--
-- TOC entry 180 (class 1259 OID 21439)
-- Dependencies: 179 6
-- Name: perfiles_id_perfil_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE perfiles_id_perfil_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2177 (class 0 OID 0)
-- Dependencies: 180
-- Name: perfiles_id_perfil_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE perfiles_id_perfil_seq OWNED BY perfiles.id_perfil;


--
-- TOC entry 2178 (class 0 OID 0)
-- Dependencies: 180
-- Name: perfiles_id_perfil_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('perfiles_id_perfil_seq', 3, true);


--
-- TOC entry 181 (class 1259 OID 21441)
-- Dependencies: 2050 6
-- Name: personas; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE personas (
    id_persona integer NOT NULL,
    nombre character varying(60) NOT NULL,
    apellido character varying(60) NOT NULL,
    nacionalidad character varying(1) DEFAULT 'V'::character varying,
    cedula_de_identidad numeric(15,0) NOT NULL,
    telefono1 numeric(11,0),
    telefono2 numeric(11,0),
    id_pais integer,
    id_estado integer,
    email character varying(255)
);


--
-- TOC entry 182 (class 1259 OID 21444)
-- Dependencies: 181 6
-- Name: personas_id_persona_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE personas_id_persona_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2179 (class 0 OID 0)
-- Dependencies: 182
-- Name: personas_id_persona_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE personas_id_persona_seq OWNED BY personas.id_persona;


--
-- TOC entry 2180 (class 0 OID 0)
-- Dependencies: 182
-- Name: personas_id_persona_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('personas_id_persona_seq', 2, true);


--
-- TOC entry 183 (class 1259 OID 21446)
-- Dependencies: 6
-- Name: procesos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE procesos (
    id_proceso integer NOT NULL,
    proceso_abrev character varying(5),
    proceso character varying(60),
    nro_consecutivo_proceso integer NOT NULL
);


--
-- TOC entry 184 (class 1259 OID 21449)
-- Dependencies: 6 183
-- Name: procesos_id_proceso_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE procesos_id_proceso_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2181 (class 0 OID 0)
-- Dependencies: 184
-- Name: procesos_id_proceso_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE procesos_id_proceso_seq OWNED BY procesos.id_proceso;


--
-- TOC entry 2182 (class 0 OID 0)
-- Dependencies: 184
-- Name: procesos_id_proceso_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('procesos_id_proceso_seq', 1, false);


--
-- TOC entry 185 (class 1259 OID 21451)
-- Dependencies: 2053 2054 6
-- Name: usuarios; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE usuarios (
    id_usuario integer NOT NULL,
    usuario character varying(15) NOT NULL,
    usuario_encrypt character varying(128) NOT NULL,
    clave character varying(128) NOT NULL,
    es_activo character varying(2) DEFAULT 'NO'::character varying NOT NULL,
    id_persona integer NOT NULL,
    id_perfil integer NOT NULL,
    fecha_registro date DEFAULT now() NOT NULL,
    fecha_ultimo_ingreso timestamp without time zone
);


--
-- TOC entry 186 (class 1259 OID 21456)
-- Dependencies: 185 6
-- Name: usuarios_id_usuario_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE usuarios_id_usuario_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2183 (class 0 OID 0)
-- Dependencies: 186
-- Name: usuarios_id_usuario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE usuarios_id_usuario_seq OWNED BY usuarios.id_usuario;


--
-- TOC entry 2184 (class 0 OID 0)
-- Dependencies: 186
-- Name: usuarios_id_usuario_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('usuarios_id_usuario_seq', 2, true);


--
-- TOC entry 2055 (class 2604 OID 26183)
-- Dependencies: 187 188 188
-- Name: id_bitacora; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY bitacoras ALTER COLUMN id_bitacora SET DEFAULT nextval('bitacoras_id_bitacora_seq'::regclass);


--
-- TOC entry 2034 (class 2604 OID 21458)
-- Dependencies: 162 161
-- Name: id_consulta; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY consultas ALTER COLUMN id_consulta SET DEFAULT nextval('consultas_id_consulta_seq'::regclass);


--
-- TOC entry 2036 (class 2604 OID 21459)
-- Dependencies: 164 163
-- Name: id_control_movimientos; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY control_movimientos ALTER COLUMN id_control_movimientos SET DEFAULT nextval('control_movimientos_id_control_movimientos_seq'::regclass);


--
-- TOC entry 2038 (class 2604 OID 21460)
-- Dependencies: 166 165
-- Name: id_estado; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY estados ALTER COLUMN id_estado SET DEFAULT nextval('estados_id_estado_seq'::regclass);


--
-- TOC entry 2039 (class 2604 OID 21461)
-- Dependencies: 168 167
-- Name: id_etapa; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY etapas ALTER COLUMN id_etapa SET DEFAULT nextval('etapas_id_etapa_seq'::regclass);


--
-- TOC entry 2040 (class 2604 OID 21462)
-- Dependencies: 170 169
-- Name: id_expediente; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY expedientes ALTER COLUMN id_expediente SET DEFAULT nextval('expedientes_id_expediente_seq'::regclass);


--
-- TOC entry 2043 (class 2604 OID 21463)
-- Dependencies: 172 171
-- Name: id_interesado; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY interesados ALTER COLUMN id_interesado SET DEFAULT nextval('interesados_id_interesado_seq'::regclass);


--
-- TOC entry 2044 (class 2604 OID 21464)
-- Dependencies: 174 173
-- Name: id_log_usuario; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY logs_usuarios ALTER COLUMN id_log_usuario SET DEFAULT nextval('logs_usuarios_id_log_usuario_seq'::regclass);


--
-- TOC entry 2046 (class 2604 OID 21466)
-- Dependencies: 176 175
-- Name: id_organismo; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY organismos ALTER COLUMN id_organismo SET DEFAULT nextval('organismos_id_organismo_seq'::regclass);


--
-- TOC entry 2047 (class 2604 OID 21467)
-- Dependencies: 178 177
-- Name: id_pais; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY paises ALTER COLUMN id_pais SET DEFAULT nextval('paises_id_pais_seq'::regclass);


--
-- TOC entry 2048 (class 2604 OID 21468)
-- Dependencies: 180 179
-- Name: id_perfil; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY perfiles ALTER COLUMN id_perfil SET DEFAULT nextval('perfiles_id_perfil_seq'::regclass);


--
-- TOC entry 2049 (class 2604 OID 21469)
-- Dependencies: 182 181
-- Name: id_persona; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY personas ALTER COLUMN id_persona SET DEFAULT nextval('personas_id_persona_seq'::regclass);


--
-- TOC entry 2051 (class 2604 OID 21470)
-- Dependencies: 184 183
-- Name: id_proceso; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY procesos ALTER COLUMN id_proceso SET DEFAULT nextval('procesos_id_proceso_seq'::regclass);


--
-- TOC entry 2052 (class 2604 OID 21471)
-- Dependencies: 186 185
-- Name: id_usuario; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY usuarios ALTER COLUMN id_usuario SET DEFAULT nextval('usuarios_id_usuario_seq'::regclass);


--
-- TOC entry 2148 (class 0 OID 26180)
-- Dependencies: 188
-- Data for Name: bitacoras; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2135 (class 0 OID 21380)
-- Dependencies: 161
-- Data for Name: consultas; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2136 (class 0 OID 21385)
-- Dependencies: 163
-- Data for Name: control_movimientos; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2137 (class 0 OID 21390)
-- Dependencies: 165
-- Data for Name: estados; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO estados VALUES (1, 'Badakhshan', 1);
INSERT INTO estados VALUES (2, 'Badghis', 1);
INSERT INTO estados VALUES (3, 'Baghlan', 1);
INSERT INTO estados VALUES (4, 'Balkh', 1);
INSERT INTO estados VALUES (5, 'Bamian', 1);
INSERT INTO estados VALUES (6, 'Farah', 1);
INSERT INTO estados VALUES (7, 'Faryab', 1);
INSERT INTO estados VALUES (8, 'Ghazni', 1);
INSERT INTO estados VALUES (9, 'Ghowr', 1);
INSERT INTO estados VALUES (10, 'Helmand', 1);
INSERT INTO estados VALUES (11, 'Herat', 1);
INSERT INTO estados VALUES (12, 'Jowzjan', 1);
INSERT INTO estados VALUES (13, 'Kabol', 1);
INSERT INTO estados VALUES (14, 'Kandahar', 1);
INSERT INTO estados VALUES (15, 'Kapisa', 1);
INSERT INTO estados VALUES (16, 'Khowst', 1);
INSERT INTO estados VALUES (17, 'Konar', 1);
INSERT INTO estados VALUES (18, 'Konar', 1);
INSERT INTO estados VALUES (19, 'Kondoz', 1);
INSERT INTO estados VALUES (20, 'Laghman', 1);
INSERT INTO estados VALUES (21, 'Laghman', 1);
INSERT INTO estados VALUES (22, 'Lowgar', 1);
INSERT INTO estados VALUES (23, 'Nangarhar', 1);
INSERT INTO estados VALUES (24, 'Nimruz', 1);
INSERT INTO estados VALUES (25, 'Nurestan', 1);
INSERT INTO estados VALUES (26, 'Oruzgan', 1);
INSERT INTO estados VALUES (27, 'Paktia', 1);
INSERT INTO estados VALUES (28, 'Paktia', 1);
INSERT INTO estados VALUES (29, 'Paktika', 1);
INSERT INTO estados VALUES (30, 'Parvan', 1);
INSERT INTO estados VALUES (31, 'Samangan', 1);
INSERT INTO estados VALUES (32, 'Sar-e Pol', 1);
INSERT INTO estados VALUES (33, 'Takhar', 1);
INSERT INTO estados VALUES (34, 'Vardak', 1);
INSERT INTO estados VALUES (35, 'Zabol', 1);
INSERT INTO estados VALUES (36, 'Berat', 2);
INSERT INTO estados VALUES (37, 'Diber', 2);
INSERT INTO estados VALUES (38, 'Durres', 2);
INSERT INTO estados VALUES (39, 'Elbasan', 2);
INSERT INTO estados VALUES (40, 'Fier', 2);
INSERT INTO estados VALUES (41, 'Gjirokaster', 2);
INSERT INTO estados VALUES (42, 'Korce', 2);
INSERT INTO estados VALUES (43, 'Kukes', 2);
INSERT INTO estados VALUES (44, 'Lezhe', 2);
INSERT INTO estados VALUES (45, 'Shkoder', 2);
INSERT INTO estados VALUES (46, 'Tirane', 2);
INSERT INTO estados VALUES (47, 'Vlore', 2);
INSERT INTO estados VALUES (48, 'Baden-Wberg Bayern', 3);
INSERT INTO estados VALUES (49, 'Berlin', 3);
INSERT INTO estados VALUES (50, 'Brandenburg', 3);
INSERT INTO estados VALUES (51, 'Bremen', 3);
INSERT INTO estados VALUES (52, 'Hamburg', 3);
INSERT INTO estados VALUES (53, 'Hessen', 3);
INSERT INTO estados VALUES (54, 'Mecklenburg-Vorpommern', 3);
INSERT INTO estados VALUES (55, 'Niedersachsen', 3);
INSERT INTO estados VALUES (56, 'Nordrhein-Westfalen', 3);
INSERT INTO estados VALUES (57, 'Rheinland-Pfalz', 3);
INSERT INTO estados VALUES (58, 'Saarland', 3);
INSERT INTO estados VALUES (59, 'Sachsen', 3);
INSERT INTO estados VALUES (60, 'Sachsen-Anhalt', 3);
INSERT INTO estados VALUES (61, 'Schleswig-Holstein', 3);
INSERT INTO estados VALUES (62, 'Thuringen', 3);
INSERT INTO estados VALUES (63, 'American Samoa (General)', 4);
INSERT INTO estados VALUES (64, 'Andorra la Vella', 5);
INSERT INTO estados VALUES (65, 'Canillo', 5);
INSERT INTO estados VALUES (66, 'Encamp', 5);
INSERT INTO estados VALUES (67, 'Escaldes-Engordany', 5);
INSERT INTO estados VALUES (68, 'La Massana', 5);
INSERT INTO estados VALUES (69, 'Ordino', 5);
INSERT INTO estados VALUES (70, 'Sant Julia de Loria', 5);
INSERT INTO estados VALUES (71, 'Barbuda', 5);
INSERT INTO estados VALUES (72, 'Saint George', 5);
INSERT INTO estados VALUES (73, 'Saint John', 5);
INSERT INTO estados VALUES (74, 'Saint Mary', 5);
INSERT INTO estados VALUES (75, 'Saint Paul', 5);
INSERT INTO estados VALUES (76, 'Saint Peter', 5);
INSERT INTO estados VALUES (77, 'Saint Philip', 5);
INSERT INTO estados VALUES (78, 'Bengo', 6);
INSERT INTO estados VALUES (79, 'Benguela', 6);
INSERT INTO estados VALUES (80, 'Bie', 6);
INSERT INTO estados VALUES (81, 'Cabinda', 6);
INSERT INTO estados VALUES (82, 'Cuando Cubango', 6);
INSERT INTO estados VALUES (83, 'Cuanza Norte', 6);
INSERT INTO estados VALUES (84, 'Cuanza Sul', 6);
INSERT INTO estados VALUES (85, 'Cunene', 6);
INSERT INTO estados VALUES (86, 'Huambo', 6);
INSERT INTO estados VALUES (87, 'Huila', 6);
INSERT INTO estados VALUES (88, 'Luanda', 6);
INSERT INTO estados VALUES (89, 'Luanda Province', 6);
INSERT INTO estados VALUES (90, 'Lunda Norte', 6);
INSERT INTO estados VALUES (91, 'Lunda Sul', 6);
INSERT INTO estados VALUES (92, 'Malanje', 6);
INSERT INTO estados VALUES (93, 'Moxico', 6);
INSERT INTO estados VALUES (94, 'Uige', 6);
INSERT INTO estados VALUES (95, 'Zaire', 6);
INSERT INTO estados VALUES (96, 'Anguilla (General)', 7);
INSERT INTO estados VALUES (97, 'Barbuda', 8);
INSERT INTO estados VALUES (98, 'Saint George', 8);
INSERT INTO estados VALUES (99, 'Saint John', 8);
INSERT INTO estados VALUES (100, 'Saint Mary', 8);
INSERT INTO estados VALUES (101, 'Saint Paul', 8);
INSERT INTO estados VALUES (102, 'Saint Peter', 8);
INSERT INTO estados VALUES (103, 'Saint Philip', 8);
INSERT INTO estados VALUES (104, 'Netherlands Antilles (General)', 9);
INSERT INTO estados VALUES (105, 'Antarctica (General)', 10);
INSERT INTO estados VALUES (106, 'Al Bahah', 11);
INSERT INTO estados VALUES (107, 'Al Hudud ash Shamaliyah', 11);
INSERT INTO estados VALUES (108, 'Al Jawf', 11);
INSERT INTO estados VALUES (109, 'Al Jawf', 11);
INSERT INTO estados VALUES (110, 'Al Madinah', 11);
INSERT INTO estados VALUES (111, 'Al Qasim', 11);
INSERT INTO estados VALUES (112, 'Al Qurayyat', 11);
INSERT INTO estados VALUES (113, 'Ar Riyad', 11);
INSERT INTO estados VALUES (114, 'Ash Sharqiyah', 11);
INSERT INTO estados VALUES (115, 'Hail', 11);
INSERT INTO estados VALUES (116, 'Jizan', 11);
INSERT INTO estados VALUES (117, 'Makkah', 11);
INSERT INTO estados VALUES (118, 'Najran', 11);
INSERT INTO estados VALUES (119, 'Tabuk', 11);
INSERT INTO estados VALUES (120, 'Adrar', 12);
INSERT INTO estados VALUES (121, 'Ain Defla', 12);
INSERT INTO estados VALUES (122, 'Ain Temouchent', 12);
INSERT INTO estados VALUES (123, 'Alger', 12);
INSERT INTO estados VALUES (124, 'Annaba', 12);
INSERT INTO estados VALUES (125, 'Batna', 12);
INSERT INTO estados VALUES (126, 'Bechar', 12);
INSERT INTO estados VALUES (127, 'Bejaia', 12);
INSERT INTO estados VALUES (128, 'Biskra', 12);
INSERT INTO estados VALUES (129, 'Blida', 12);
INSERT INTO estados VALUES (130, 'Bordj Bou Arreridj', 12);
INSERT INTO estados VALUES (131, 'Bouira', 12);
INSERT INTO estados VALUES (132, 'Boumerdes', 12);
INSERT INTO estados VALUES (133, 'Chlef', 12);
INSERT INTO estados VALUES (134, 'Constantine', 12);
INSERT INTO estados VALUES (135, 'Djelfa', 12);
INSERT INTO estados VALUES (136, 'El Bayadh', 12);
INSERT INTO estados VALUES (137, 'El Oued', 12);
INSERT INTO estados VALUES (138, 'El Tarf', 12);
INSERT INTO estados VALUES (139, 'Ghardaia', 12);
INSERT INTO estados VALUES (140, 'Guelma', 12);
INSERT INTO estados VALUES (141, 'Illizi', 12);
INSERT INTO estados VALUES (142, 'Jijel', 12);
INSERT INTO estados VALUES (143, 'Khenchela', 12);
INSERT INTO estados VALUES (144, 'Laghouat', 12);
INSERT INTO estados VALUES (145, 'Msila', 12);
INSERT INTO estados VALUES (146, 'Mascara', 12);
INSERT INTO estados VALUES (147, 'Medea', 12);
INSERT INTO estados VALUES (148, 'Mila', 12);
INSERT INTO estados VALUES (149, 'Mostaganem', 12);
INSERT INTO estados VALUES (150, 'Naama', 12);
INSERT INTO estados VALUES (151, 'Oran', 12);
INSERT INTO estados VALUES (152, 'Ouargla', 12);
INSERT INTO estados VALUES (153, 'Oum el Bouaghi', 12);
INSERT INTO estados VALUES (154, 'Relizane', 12);
INSERT INTO estados VALUES (155, 'Saida', 12);
INSERT INTO estados VALUES (156, 'Setif', 12);
INSERT INTO estados VALUES (157, 'Sidi Bel Abbes', 12);
INSERT INTO estados VALUES (158, 'Skikda', 12);
INSERT INTO estados VALUES (159, 'Souk Ahras', 12);
INSERT INTO estados VALUES (160, 'Tamanghasset', 12);
INSERT INTO estados VALUES (161, 'Tebessa', 12);
INSERT INTO estados VALUES (162, 'Tiaret', 12);
INSERT INTO estados VALUES (163, 'Tindouf', 12);
INSERT INTO estados VALUES (164, 'Tipaza', 12);
INSERT INTO estados VALUES (165, 'Tissemsilt', 12);
INSERT INTO estados VALUES (166, 'Tizi Ouzou', 12);
INSERT INTO estados VALUES (167, 'Tlemcen', 12);
INSERT INTO estados VALUES (168, 'Buenos Aires', 13);
INSERT INTO estados VALUES (169, 'Catamarca', 13);
INSERT INTO estados VALUES (170, 'Chaco', 13);
INSERT INTO estados VALUES (171, 'Chubut', 13);
INSERT INTO estados VALUES (172, 'Cordoba', 13);
INSERT INTO estados VALUES (173, 'Corrientes', 13);
INSERT INTO estados VALUES (174, 'Distrito Federal', 13);
INSERT INTO estados VALUES (175, 'Entre Rios', 13);
INSERT INTO estados VALUES (176, 'Formosa', 13);
INSERT INTO estados VALUES (177, 'Jujuy', 13);
INSERT INTO estados VALUES (178, 'La Pampa', 13);
INSERT INTO estados VALUES (179, 'La Rioja', 13);
INSERT INTO estados VALUES (180, 'Mendoza', 13);
INSERT INTO estados VALUES (181, 'Misiones', 13);
INSERT INTO estados VALUES (182, 'Neuquen', 13);
INSERT INTO estados VALUES (183, 'Rio Negro', 13);
INSERT INTO estados VALUES (184, 'Salta', 13);
INSERT INTO estados VALUES (185, 'San Juan', 13);
INSERT INTO estados VALUES (186, 'San Luis', 13);
INSERT INTO estados VALUES (187, 'Santa Cruz', 13);
INSERT INTO estados VALUES (188, 'Santa Fe', 13);
INSERT INTO estados VALUES (189, 'Santiago del Estero', 13);
INSERT INTO estados VALUES (190, 'Tierra del Fuego', 13);
INSERT INTO estados VALUES (191, 'Tucuman', 13);
INSERT INTO estados VALUES (192, 'Aragatsotn', 14);
INSERT INTO estados VALUES (193, 'Ararat', 14);
INSERT INTO estados VALUES (194, 'Armavir', 14);
INSERT INTO estados VALUES (195, 'Gegharkunik', 14);
INSERT INTO estados VALUES (196, 'Kotayk', 14);
INSERT INTO estados VALUES (197, 'Lorri', 14);
INSERT INTO estados VALUES (198, 'Shirak', 14);
INSERT INTO estados VALUES (199, 'Syunik', 14);
INSERT INTO estados VALUES (200, 'Tavush', 14);
INSERT INTO estados VALUES (201, 'Vayots Dzor', 14);
INSERT INTO estados VALUES (202, 'Yerevan', 14);
INSERT INTO estados VALUES (203, 'Aruba (General)', 15);
INSERT INTO estados VALUES (205, 'Australian Capital Territory', 17);
INSERT INTO estados VALUES (206, 'New South Wales', 17);
INSERT INTO estados VALUES (207, 'Northern Territory', 17);
INSERT INTO estados VALUES (208, 'Queensland', 17);
INSERT INTO estados VALUES (209, 'South Australia', 17);
INSERT INTO estados VALUES (210, 'Tasmania', 17);
INSERT INTO estados VALUES (211, 'Victoria', 17);
INSERT INTO estados VALUES (212, 'Western Australia', 17);
INSERT INTO estados VALUES (213, 'Burgenland', 18);
INSERT INTO estados VALUES (214, 'Karnten', 18);
INSERT INTO estados VALUES (215, 'Niederosterreich', 18);
INSERT INTO estados VALUES (216, 'Oberosterreich', 18);
INSERT INTO estados VALUES (217, 'Salzburg', 18);
INSERT INTO estados VALUES (218, 'Steiermark', 18);
INSERT INTO estados VALUES (219, 'Tirol', 18);
INSERT INTO estados VALUES (220, 'Vorarlberg', 18);
INSERT INTO estados VALUES (221, 'Wien', 18);
INSERT INTO estados VALUES (222, 'Abseron', 19);
INSERT INTO estados VALUES (223, 'Agcabadi', 19);
INSERT INTO estados VALUES (224, 'Agdam', 19);
INSERT INTO estados VALUES (225, 'Agdas', 19);
INSERT INTO estados VALUES (226, 'Agstafa', 19);
INSERT INTO estados VALUES (227, 'Agsu', 19);
INSERT INTO estados VALUES (228, 'Ali Bayramli', 19);
INSERT INTO estados VALUES (229, 'Astara', 19);
INSERT INTO estados VALUES (230, 'Baki', 19);
INSERT INTO estados VALUES (231, 'Balakan', 19);
INSERT INTO estados VALUES (232, 'Barda', 19);
INSERT INTO estados VALUES (233, 'Beylaqan', 19);
INSERT INTO estados VALUES (234, 'Bilasuvar', 19);
INSERT INTO estados VALUES (235, 'Cabrayil', 19);
INSERT INTO estados VALUES (236, 'Calilabad', 19);
INSERT INTO estados VALUES (237, 'Daskasan', 19);
INSERT INTO estados VALUES (238, 'Davaci', 19);
INSERT INTO estados VALUES (239, 'Fuzuli', 19);
INSERT INTO estados VALUES (240, 'Gadabay', 19);
INSERT INTO estados VALUES (241, 'Ganca', 19);
INSERT INTO estados VALUES (242, 'Goranboy', 19);
INSERT INTO estados VALUES (243, 'Goycay', 19);
INSERT INTO estados VALUES (244, 'Haciqabul', 19);
INSERT INTO estados VALUES (245, 'Imisli', 19);
INSERT INTO estados VALUES (246, 'Ismayilli', 19);
INSERT INTO estados VALUES (247, 'Kalbacar', 19);
INSERT INTO estados VALUES (248, 'Kurdamir', 19);
INSERT INTO estados VALUES (249, 'Lacin', 19);
INSERT INTO estados VALUES (250, 'Lankaran', 19);
INSERT INTO estados VALUES (251, 'Lankaran', 19);
INSERT INTO estados VALUES (252, 'Lerik', 19);
INSERT INTO estados VALUES (253, 'Masalli', 19);
INSERT INTO estados VALUES (254, 'Mingacevir', 19);
INSERT INTO estados VALUES (255, 'Naftalan', 19);
INSERT INTO estados VALUES (256, 'Naxcivan', 19);
INSERT INTO estados VALUES (257, 'Neftcala', 19);
INSERT INTO estados VALUES (258, 'Oguz', 19);
INSERT INTO estados VALUES (259, 'Qabala', 19);
INSERT INTO estados VALUES (260, 'Qax', 19);
INSERT INTO estados VALUES (261, 'Qazax', 19);
INSERT INTO estados VALUES (262, 'Qobustan', 19);
INSERT INTO estados VALUES (263, 'Quba', 19);
INSERT INTO estados VALUES (264, 'Qubadli', 19);
INSERT INTO estados VALUES (265, 'Qusar', 19);
INSERT INTO estados VALUES (266, 'Saatli', 19);
INSERT INTO estados VALUES (267, 'Sabirabad', 19);
INSERT INTO estados VALUES (268, 'Saki', 19);
INSERT INTO estados VALUES (269, 'Saki', 19);
INSERT INTO estados VALUES (270, 'Salyan', 19);
INSERT INTO estados VALUES (271, 'Samaxi', 19);
INSERT INTO estados VALUES (272, 'Samkir', 19);
INSERT INTO estados VALUES (273, 'Samux', 19);
INSERT INTO estados VALUES (274, 'Siyazan', 19);
INSERT INTO estados VALUES (275, 'Sumqayit', 19);
INSERT INTO estados VALUES (276, 'Susa', 19);
INSERT INTO estados VALUES (277, 'Susa', 19);
INSERT INTO estados VALUES (278, 'Tartar', 19);
INSERT INTO estados VALUES (279, 'Tovuz', 19);
INSERT INTO estados VALUES (280, 'Ucar', 19);
INSERT INTO estados VALUES (281, 'Xacmaz', 19);
INSERT INTO estados VALUES (282, 'Xankandi', 19);
INSERT INTO estados VALUES (283, 'Xanlar', 19);
INSERT INTO estados VALUES (284, 'Xizi', 19);
INSERT INTO estados VALUES (285, 'Xocali', 19);
INSERT INTO estados VALUES (286, 'Xocavand', 19);
INSERT INTO estados VALUES (287, 'Yardimli', 19);
INSERT INTO estados VALUES (288, 'Yevlax', 19);
INSERT INTO estados VALUES (289, 'Yevlax', 19);
INSERT INTO estados VALUES (290, 'Zangilan', 19);
INSERT INTO estados VALUES (291, 'Zaqatala', 19);
INSERT INTO estados VALUES (292, 'Zardab', 19);
INSERT INTO estados VALUES (293, 'Acklins and Crooked Islands', 20);
INSERT INTO estados VALUES (294, 'Bimini', 20);
INSERT INTO estados VALUES (295, 'Cat Island', 20);
INSERT INTO estados VALUES (296, 'Exuma', 20);
INSERT INTO estados VALUES (297, 'Freeport', 20);
INSERT INTO estados VALUES (298, 'Fresh Creek', 20);
INSERT INTO estados VALUES (299, 'Governors Harbour', 20);
INSERT INTO estados VALUES (300, 'Green Turtle Cay', 20);
INSERT INTO estados VALUES (301, 'Harbour Island', 20);
INSERT INTO estados VALUES (302, 'High Rock', 20);
INSERT INTO estados VALUES (303, 'Inagua', 20);
INSERT INTO estados VALUES (304, 'Kemps Bay', 20);
INSERT INTO estados VALUES (305, 'Long Island', 20);
INSERT INTO estados VALUES (306, 'Marsh Harbour', 20);
INSERT INTO estados VALUES (307, 'Mayaguana', 20);
INSERT INTO estados VALUES (308, 'New Providence', 20);
INSERT INTO estados VALUES (309, 'Nichollstown and Berry Islands', 20);
INSERT INTO estados VALUES (310, 'Ragged Island', 20);
INSERT INTO estados VALUES (311, 'Rock Sound', 20);
INSERT INTO estados VALUES (312, 'San Salvador and Rum Cay', 20);
INSERT INTO estados VALUES (313, 'Sandy Point', 20);
INSERT INTO estados VALUES (314, 'Al Hadd', 21);
INSERT INTO estados VALUES (315, 'Al Manamah', 21);
INSERT INTO estados VALUES (316, 'Al Mintaqah al Gharbiyah', 21);
INSERT INTO estados VALUES (317, 'Al Mintaqah al Wusta', 21);
INSERT INTO estados VALUES (318, 'Al Mintaqah ash Shamaliyah', 21);
INSERT INTO estados VALUES (319, 'Al Muharraq', 21);
INSERT INTO estados VALUES (320, 'Ar Rifa', 21);
INSERT INTO estados VALUES (321, 'Jidd Hafs', 21);
INSERT INTO estados VALUES (322, 'Madinat', 21);
INSERT INTO estados VALUES (323, 'Madinat Hamad', 21);
INSERT INTO estados VALUES (324, 'Mintaqat Juzur Hawar', 21);
INSERT INTO estados VALUES (325, 'Sitrah', 21);
INSERT INTO estados VALUES (326, 'Bagerhat', 22);
INSERT INTO estados VALUES (327, 'Bandarban', 22);
INSERT INTO estados VALUES (328, 'Barguna', 22);
INSERT INTO estados VALUES (329, 'Barisal', 22);
INSERT INTO estados VALUES (330, 'Barisal Division', 22);
INSERT INTO estados VALUES (331, 'Bhola', 22);
INSERT INTO estados VALUES (332, 'Bogra', 22);
INSERT INTO estados VALUES (333, 'Brahmanbaria', 22);
INSERT INTO estados VALUES (334, 'Chandpur', 22);
INSERT INTO estados VALUES (335, 'Chapai Nawabganj', 22);
INSERT INTO estados VALUES (336, 'Chattagram', 22);
INSERT INTO estados VALUES (337, 'Chuadanga', 22);
INSERT INTO estados VALUES (338, 'Comilla', 22);
INSERT INTO estados VALUES (339, 'Coxs Bazar', 22);
INSERT INTO estados VALUES (340, 'Dhaka', 22);
INSERT INTO estados VALUES (341, 'Dhaka Division', 22);
INSERT INTO estados VALUES (342, 'Dinajpur', 22);
INSERT INTO estados VALUES (343, 'Faridpur', 22);
INSERT INTO estados VALUES (344, 'Feni', 22);
INSERT INTO estados VALUES (345, 'Gaibandha', 22);
INSERT INTO estados VALUES (346, 'Gazipur', 22);
INSERT INTO estados VALUES (347, 'Gopalganj', 22);
INSERT INTO estados VALUES (348, 'Habiganj', 22);
INSERT INTO estados VALUES (349, 'Jaipurhat', 22);
INSERT INTO estados VALUES (350, 'Jamalpur', 22);
INSERT INTO estados VALUES (351, 'Jessore', 22);
INSERT INTO estados VALUES (352, 'Jhalakati', 22);
INSERT INTO estados VALUES (353, 'Jhenaidah', 22);
INSERT INTO estados VALUES (354, 'Khagrachari', 22);
INSERT INTO estados VALUES (355, 'Khulna', 22);
INSERT INTO estados VALUES (356, 'Khulna Division', 22);
INSERT INTO estados VALUES (357, 'Kishorganj', 22);
INSERT INTO estados VALUES (358, 'Kurigram', 22);
INSERT INTO estados VALUES (359, 'Kushtia', 22);
INSERT INTO estados VALUES (360, 'Laksmipur', 22);
INSERT INTO estados VALUES (361, 'Lalmonirhat', 22);
INSERT INTO estados VALUES (362, 'Madaripur', 22);
INSERT INTO estados VALUES (363, 'Magura', 22);
INSERT INTO estados VALUES (364, 'Manikganj', 22);
INSERT INTO estados VALUES (365, 'Meherpur', 22);
INSERT INTO estados VALUES (366, 'Moulavibazar', 22);
INSERT INTO estados VALUES (367, 'Munshiganj', 22);
INSERT INTO estados VALUES (368, 'Mymensingh', 22);
INSERT INTO estados VALUES (369, 'Naogaon', 22);
INSERT INTO estados VALUES (370, 'Narail', 22);
INSERT INTO estados VALUES (371, 'Narayanganj', 22);
INSERT INTO estados VALUES (372, 'Narsingdi', 22);
INSERT INTO estados VALUES (373, 'Nator', 22);
INSERT INTO estados VALUES (374, 'Netrakona', 22);
INSERT INTO estados VALUES (375, 'Nilphamari', 22);
INSERT INTO estados VALUES (376, 'Noakhali', 22);
INSERT INTO estados VALUES (377, 'Pabna', 22);
INSERT INTO estados VALUES (378, 'Panchagar', 22);
INSERT INTO estados VALUES (379, 'Parbattya Chattagram', 22);
INSERT INTO estados VALUES (380, 'Patuakhali', 22);
INSERT INTO estados VALUES (381, 'Pirojpur', 22);
INSERT INTO estados VALUES (382, 'Rajbari', 22);
INSERT INTO estados VALUES (383, 'Rajshahi', 22);
INSERT INTO estados VALUES (384, 'Rangpur', 22);
INSERT INTO estados VALUES (385, 'Rajshahi Division', 22);
INSERT INTO estados VALUES (386, 'Satkhira', 22);
INSERT INTO estados VALUES (387, 'Shariyatpur', 22);
INSERT INTO estados VALUES (388, 'Sherpur', 22);
INSERT INTO estados VALUES (389, 'Sirajganj', 22);
INSERT INTO estados VALUES (390, 'Sunamganj', 22);
INSERT INTO estados VALUES (391, 'Sylhet', 22);
INSERT INTO estados VALUES (392, 'Sylhet Division', 22);
INSERT INTO estados VALUES (393, 'Tangail', 22);
INSERT INTO estados VALUES (394, 'Thakurgaon', 22);
INSERT INTO estados VALUES (395, 'Christ Church', 23);
INSERT INTO estados VALUES (396, 'Saint Andrew', 23);
INSERT INTO estados VALUES (397, 'Saint George', 23);
INSERT INTO estados VALUES (398, 'Saint James', 23);
INSERT INTO estados VALUES (399, 'Saint John', 23);
INSERT INTO estados VALUES (400, 'Saint Joseph', 23);
INSERT INTO estados VALUES (401, 'Saint Lucy', 23);
INSERT INTO estados VALUES (402, 'Saint Michael', 23);
INSERT INTO estados VALUES (403, 'Saint Peter', 23);
INSERT INTO estados VALUES (404, 'Saint Philip', 23);
INSERT INTO estados VALUES (405, 'Saint Thomas', 23);
INSERT INTO estados VALUES (406, 'Belize', 24);
INSERT INTO estados VALUES (407, 'Cayo', 24);
INSERT INTO estados VALUES (408, 'Corozal', 24);
INSERT INTO estados VALUES (409, 'Orange Walk', 24);
INSERT INTO estados VALUES (410, 'Stann Creek', 24);
INSERT INTO estados VALUES (411, 'Toledo', 24);
INSERT INTO estados VALUES (412, 'Atakora', 25);
INSERT INTO estados VALUES (413, 'Atlantique', 25);
INSERT INTO estados VALUES (414, 'Borgou', 25);
INSERT INTO estados VALUES (415, 'Littoral Department', 25);
INSERT INTO estados VALUES (416, 'Mono', 25);
INSERT INTO estados VALUES (417, 'Oueme', 25);
INSERT INTO estados VALUES (418, 'Zou', 25);
INSERT INTO estados VALUES (419, 'Devonshire', 26);
INSERT INTO estados VALUES (420, 'Hamilton', 26);
INSERT INTO estados VALUES (421, 'Hamilton', 26);
INSERT INTO estados VALUES (422, 'Paget', 26);
INSERT INTO estados VALUES (423, 'Pembroke', 26);
INSERT INTO estados VALUES (424, 'Saint George', 26);
INSERT INTO estados VALUES (425, 'Saint Georges', 26);
INSERT INTO estados VALUES (426, 'Sandys', 26);
INSERT INTO estados VALUES (427, 'Smiths', 26);
INSERT INTO estados VALUES (428, 'Southampton', 26);
INSERT INTO estados VALUES (429, 'Warwick', 26);
INSERT INTO estados VALUES (430, 'Brestskaya Voblasts', 27);
INSERT INTO estados VALUES (431, 'Homyel skaya Voblasts', 27);
INSERT INTO estados VALUES (432, 'Hrodzyenskaya Voblasts', 27);
INSERT INTO estados VALUES (433, 'Mahilyowskaya Voblasts', 27);
INSERT INTO estados VALUES (434, 'Minsk', 27);
INSERT INTO estados VALUES (435, 'Minskaya Voblasts', 27);
INSERT INTO estados VALUES (436, 'Vitsyebskaya Voblasts', 27);
INSERT INTO estados VALUES (437, 'Chuquisaca', 28);
INSERT INTO estados VALUES (438, 'Cochabamba', 28);
INSERT INTO estados VALUES (439, 'El Beni', 28);
INSERT INTO estados VALUES (440, 'La Paz', 28);
INSERT INTO estados VALUES (441, 'Oruro', 28);
INSERT INTO estados VALUES (442, 'Pando', 28);
INSERT INTO estados VALUES (443, 'Potosi', 28);
INSERT INTO estados VALUES (444, 'Santa Cruz', 28);
INSERT INTO estados VALUES (445, 'Tarija', 28);
INSERT INTO estados VALUES (446, 'Bosanska Dubica', 29);
INSERT INTO estados VALUES (447, 'Federation of Bosnia and Herzegovina', 29);
INSERT INTO estados VALUES (448, 'Republika Srpska', 29);
INSERT INTO estados VALUES (449, 'Central', 30);
INSERT INTO estados VALUES (450, 'Chobe', 30);
INSERT INTO estados VALUES (451, 'Ghanzi', 30);
INSERT INTO estados VALUES (452, 'Kgalagadi', 30);
INSERT INTO estados VALUES (453, 'Kgatleng', 30);
INSERT INTO estados VALUES (454, 'Kweneng', 30);
INSERT INTO estados VALUES (455, 'Ngamiland', 30);
INSERT INTO estados VALUES (456, 'North-East', 30);
INSERT INTO estados VALUES (457, 'South-East', 30);
INSERT INTO estados VALUES (458, 'Southern', 30);
INSERT INTO estados VALUES (459, 'Bouvet Island (General)', 31);
INSERT INTO estados VALUES (460, 'Acre', 32);
INSERT INTO estados VALUES (461, 'Alagoas', 32);
INSERT INTO estados VALUES (462, 'Amapa', 32);
INSERT INTO estados VALUES (463, 'Amazonas', 32);
INSERT INTO estados VALUES (464, 'Bahia', 32);
INSERT INTO estados VALUES (465, 'Ceara', 32);
INSERT INTO estados VALUES (466, 'Distrito Federal', 32);
INSERT INTO estados VALUES (467, 'Espirito Santo', 32);
INSERT INTO estados VALUES (468, 'Goias', 32);
INSERT INTO estados VALUES (469, 'Maranhao', 32);
INSERT INTO estados VALUES (470, 'Mato Grosso', 32);
INSERT INTO estados VALUES (471, 'Mato Grosso do Sul', 32);
INSERT INTO estados VALUES (472, 'Minas Gerais', 32);
INSERT INTO estados VALUES (473, 'Para', 32);
INSERT INTO estados VALUES (474, 'Paraiba', 32);
INSERT INTO estados VALUES (475, 'Parana', 32);
INSERT INTO estados VALUES (476, 'Pernambuco', 32);
INSERT INTO estados VALUES (477, 'Piaui', 32);
INSERT INTO estados VALUES (478, 'Rio Grande do Norte', 32);
INSERT INTO estados VALUES (479, 'Rio Grande do Sul', 32);
INSERT INTO estados VALUES (480, 'Rio de Janeiro', 32);
INSERT INTO estados VALUES (481, 'Rondonia', 32);
INSERT INTO estados VALUES (482, 'Roraima', 32);
INSERT INTO estados VALUES (483, 'Santa Catarina', 32);
INSERT INTO estados VALUES (484, 'Sao Paulo', 32);
INSERT INTO estados VALUES (485, 'Sergipe', 32);
INSERT INTO estados VALUES (486, 'Tocantins', 32);
INSERT INTO estados VALUES (487, 'British Indian Ocean Territory (General)', 33);
INSERT INTO estados VALUES (488, 'Alibori', 34);
INSERT INTO estados VALUES (489, 'Belait', 34);
INSERT INTO estados VALUES (490, 'Brunei and Muara', 34);
INSERT INTO estados VALUES (491, 'Collines', 34);
INSERT INTO estados VALUES (492, 'Donga', 34);
INSERT INTO estados VALUES (493, 'Kouffo', 34);
INSERT INTO estados VALUES (494, 'Littoral', 34);
INSERT INTO estados VALUES (495, 'Oueme', 34);
INSERT INTO estados VALUES (496, 'Plateau', 34);
INSERT INTO estados VALUES (497, 'Temburong', 34);
INSERT INTO estados VALUES (498, 'Tutong', 34);
INSERT INTO estados VALUES (499, 'Zou', 34);
INSERT INTO estados VALUES (500, 'Blagoevgrad', 35);
INSERT INTO estados VALUES (501, 'Burgas', 35);
INSERT INTO estados VALUES (502, 'Dobrich', 35);
INSERT INTO estados VALUES (503, 'Gabrovo', 35);
INSERT INTO estados VALUES (504, 'Grad Sofiya', 35);
INSERT INTO estados VALUES (505, 'Khaskovo', 35);
INSERT INTO estados VALUES (506, 'Kurdzhali', 35);
INSERT INTO estados VALUES (507, 'Kyustendil', 35);
INSERT INTO estados VALUES (508, 'Lovech', 35);
INSERT INTO estados VALUES (509, 'Mikhaylovgrad', 35);
INSERT INTO estados VALUES (510, 'Montana', 35);
INSERT INTO estados VALUES (511, 'Pazardzhik', 35);
INSERT INTO estados VALUES (512, 'Pernik', 35);
INSERT INTO estados VALUES (513, 'Pleven', 35);
INSERT INTO estados VALUES (514, 'Plovdiv', 35);
INSERT INTO estados VALUES (515, 'Razgrad', 35);
INSERT INTO estados VALUES (516, 'Ruse', 35);
INSERT INTO estados VALUES (517, 'Shumen', 35);
INSERT INTO estados VALUES (518, 'Silistra', 35);
INSERT INTO estados VALUES (519, 'Sliven', 35);
INSERT INTO estados VALUES (520, 'Smolyan', 35);
INSERT INTO estados VALUES (521, 'Sofiya', 35);
INSERT INTO estados VALUES (522, 'Stara Zagora', 35);
INSERT INTO estados VALUES (523, 'Turgovishte', 35);
INSERT INTO estados VALUES (524, 'Varna', 35);
INSERT INTO estados VALUES (525, 'Veliko Turnovo', 35);
INSERT INTO estados VALUES (526, 'Vidin', 35);
INSERT INTO estados VALUES (527, 'Vratsa', 35);
INSERT INTO estados VALUES (528, 'Yambol', 35);
INSERT INTO estados VALUES (529, 'Bale', 36);
INSERT INTO estados VALUES (530, 'Bam', 36);
INSERT INTO estados VALUES (531, 'Banwa', 36);
INSERT INTO estados VALUES (532, 'Bazega', 36);
INSERT INTO estados VALUES (533, 'Bougouriba', 36);
INSERT INTO estados VALUES (534, 'Boulgou', 36);
INSERT INTO estados VALUES (535, 'Boulkiemde', 36);
INSERT INTO estados VALUES (536, 'Ganzourgou', 36);
INSERT INTO estados VALUES (537, 'Gnagna', 36);
INSERT INTO estados VALUES (538, 'Gourma', 36);
INSERT INTO estados VALUES (539, 'Houet', 36);
INSERT INTO estados VALUES (540, 'Ioba', 36);
INSERT INTO estados VALUES (541, 'Kadiogo', 36);
INSERT INTO estados VALUES (542, 'Kenedougou', 36);
INSERT INTO estados VALUES (543, 'Komoe', 36);
INSERT INTO estados VALUES (544, 'Komondjari', 36);
INSERT INTO estados VALUES (545, 'Kompienga', 36);
INSERT INTO estados VALUES (546, 'Kossi', 36);
INSERT INTO estados VALUES (547, 'Koulpelogo', 36);
INSERT INTO estados VALUES (548, 'Kouritenga', 36);
INSERT INTO estados VALUES (549, 'Kourweogo', 36);
INSERT INTO estados VALUES (550, 'Leraba', 36);
INSERT INTO estados VALUES (551, 'Loroum', 36);
INSERT INTO estados VALUES (552, 'Mouhoun', 36);
INSERT INTO estados VALUES (553, 'Namentenga', 36);
INSERT INTO estados VALUES (554, 'Naouri', 36);
INSERT INTO estados VALUES (555, 'Nayala', 36);
INSERT INTO estados VALUES (556, 'Noumbiel', 36);
INSERT INTO estados VALUES (557, 'Oubritenga', 36);
INSERT INTO estados VALUES (558, 'Oudalan', 36);
INSERT INTO estados VALUES (559, 'Passore', 36);
INSERT INTO estados VALUES (560, 'Poni', 36);
INSERT INTO estados VALUES (561, 'Sanguie', 36);
INSERT INTO estados VALUES (562, 'Sanmatenga', 36);
INSERT INTO estados VALUES (563, 'Seno', 36);
INSERT INTO estados VALUES (564, 'Sissili', 36);
INSERT INTO estados VALUES (565, 'Soum', 36);
INSERT INTO estados VALUES (566, 'Sourou', 36);
INSERT INTO estados VALUES (567, 'Tapoa', 36);
INSERT INTO estados VALUES (568, 'Tuy', 36);
INSERT INTO estados VALUES (569, 'Yagha', 36);
INSERT INTO estados VALUES (570, 'Yatenga', 36);
INSERT INTO estados VALUES (571, 'Ziro', 36);
INSERT INTO estados VALUES (572, 'Zondoma', 36);
INSERT INTO estados VALUES (573, 'Zoundweogo', 36);
INSERT INTO estados VALUES (574, 'Bubanza', 37);
INSERT INTO estados VALUES (575, 'Bujumbura', 37);
INSERT INTO estados VALUES (576, 'Bururi', 37);
INSERT INTO estados VALUES (577, 'Cankuzo', 37);
INSERT INTO estados VALUES (578, 'Cibitoke', 37);
INSERT INTO estados VALUES (579, 'Gitega', 37);
INSERT INTO estados VALUES (580, 'Karuzi', 37);
INSERT INTO estados VALUES (581, 'Kayanza', 37);
INSERT INTO estados VALUES (582, 'Kirundo', 37);
INSERT INTO estados VALUES (583, 'Makamba', 37);
INSERT INTO estados VALUES (584, 'Muramvya', 37);
INSERT INTO estados VALUES (585, 'Muyinga', 37);
INSERT INTO estados VALUES (586, 'Mwaro', 37);
INSERT INTO estados VALUES (587, 'Ngozi', 37);
INSERT INTO estados VALUES (588, 'Rutana', 37);
INSERT INTO estados VALUES (589, 'Ruyigi', 37);
INSERT INTO estados VALUES (590, 'Bumthang', 38);
INSERT INTO estados VALUES (591, 'Chhukha', 38);
INSERT INTO estados VALUES (592, 'Chirang', 38);
INSERT INTO estados VALUES (593, 'Daga', 38);
INSERT INTO estados VALUES (594, 'Geylegphug', 38);
INSERT INTO estados VALUES (595, 'Ha', 38);
INSERT INTO estados VALUES (596, 'Lhuntshi', 38);
INSERT INTO estados VALUES (597, 'Mongar', 38);
INSERT INTO estados VALUES (598, 'Paro', 38);
INSERT INTO estados VALUES (599, 'Pemagatsel', 38);
INSERT INTO estados VALUES (600, 'Punakha', 38);
INSERT INTO estados VALUES (601, 'Samchi', 38);
INSERT INTO estados VALUES (602, 'Samdrup', 38);
INSERT INTO estados VALUES (603, 'Shemgang', 38);
INSERT INTO estados VALUES (604, 'Tashigang', 38);
INSERT INTO estados VALUES (605, 'Thimphu', 38);
INSERT INTO estados VALUES (606, 'Tongsa', 38);
INSERT INTO estados VALUES (607, 'Wangdi Phodrang', 38);
INSERT INTO estados VALUES (608, 'Antwerpen', 39);
INSERT INTO estados VALUES (609, 'Brabant', 39);
INSERT INTO estados VALUES (610, 'Brabant Wallon', 39);
INSERT INTO estados VALUES (611, 'Brussels Hoofdstedelijk Gewest', 39);
INSERT INTO estados VALUES (612, 'Hainaut', 39);
INSERT INTO estados VALUES (613, 'Liege', 39);
INSERT INTO estados VALUES (614, 'Limburg', 39);
INSERT INTO estados VALUES (615, 'Luxembourg', 39);
INSERT INTO estados VALUES (616, 'Namur', 39);
INSERT INTO estados VALUES (617, 'Oost-Vlaanderen', 39);
INSERT INTO estados VALUES (618, 'Vlaams-Brabant', 39);
INSERT INTO estados VALUES (619, 'West-Vlaanderen', 39);
INSERT INTO estados VALUES (620, 'Boa Vista', 40);
INSERT INTO estados VALUES (621, 'Brava', 40);
INSERT INTO estados VALUES (622, 'Maio', 40);
INSERT INTO estados VALUES (623, 'Mosteiros', 40);
INSERT INTO estados VALUES (624, 'Paul', 40);
INSERT INTO estados VALUES (625, 'Praia', 40);
INSERT INTO estados VALUES (626, 'Ribeira Grande', 40);
INSERT INTO estados VALUES (627, 'Sal', 40);
INSERT INTO estados VALUES (628, 'Santa Catarina', 40);
INSERT INTO estados VALUES (629, 'Santa Cruz', 40);
INSERT INTO estados VALUES (630, 'Sao Domingos', 40);
INSERT INTO estados VALUES (631, 'Sao Filipe', 40);
INSERT INTO estados VALUES (632, 'Sao Miguel', 40);
INSERT INTO estados VALUES (633, 'Sao Nicolau', 40);
INSERT INTO estados VALUES (634, 'Sao Vicente', 40);
INSERT INTO estados VALUES (635, 'Tarrafal', 40);
INSERT INTO estados VALUES (636, 'Batdambang', 41);
INSERT INTO estados VALUES (637, 'Kampong Cham', 41);
INSERT INTO estados VALUES (638, 'Kampong Chhnang', 41);
INSERT INTO estados VALUES (639, 'Kampong Spoe', 41);
INSERT INTO estados VALUES (640, 'Kampong Thum', 41);
INSERT INTO estados VALUES (641, 'Kampot', 41);
INSERT INTO estados VALUES (642, 'Kandal', 41);
INSERT INTO estados VALUES (643, 'Kaoh Kong', 41);
INSERT INTO estados VALUES (644, 'Kracheh', 41);
INSERT INTO estados VALUES (645, 'Mondol Kiri', 41);
INSERT INTO estados VALUES (646, 'Pailin', 41);
INSERT INTO estados VALUES (647, 'Phnum Penh', 41);
INSERT INTO estados VALUES (648, 'Pouthisat', 41);
INSERT INTO estados VALUES (649, 'Preah Vihear', 41);
INSERT INTO estados VALUES (650, 'Prey Veng', 41);
INSERT INTO estados VALUES (651, 'Rotanokiri', 41);
INSERT INTO estados VALUES (652, 'Siemreab-Otdar Meanchey', 41);
INSERT INTO estados VALUES (653, 'Stoeng Treng', 41);
INSERT INTO estados VALUES (654, 'Svay Rieng', 41);
INSERT INTO estados VALUES (655, 'Takev', 41);
INSERT INTO estados VALUES (656, 'Adamaoua', 42);
INSERT INTO estados VALUES (657, 'Centre', 42);
INSERT INTO estados VALUES (658, 'Est', 42);
INSERT INTO estados VALUES (659, 'Extreme-Nord', 42);
INSERT INTO estados VALUES (660, 'Littoral', 42);
INSERT INTO estados VALUES (661, 'Nord', 42);
INSERT INTO estados VALUES (662, 'Nord-Ouest', 42);
INSERT INTO estados VALUES (663, 'Ouest', 42);
INSERT INTO estados VALUES (664, 'Sud', 42);
INSERT INTO estados VALUES (665, 'Sud-Ouest', 42);
INSERT INTO estados VALUES (666, 'Alberta', 44);
INSERT INTO estados VALUES (667, 'British Columbia', 44);
INSERT INTO estados VALUES (668, 'Manitoba', 44);
INSERT INTO estados VALUES (669, 'New Brunswick', 44);
INSERT INTO estados VALUES (670, 'Newfoundland', 44);
INSERT INTO estados VALUES (671, 'Northwest Territories', 44);
INSERT INTO estados VALUES (672, 'Nova Scotia', 44);
INSERT INTO estados VALUES (673, 'Nunavut', 44);
INSERT INTO estados VALUES (674, 'Ontario', 44);
INSERT INTO estados VALUES (675, 'Prince Edward Island', 44);
INSERT INTO estados VALUES (676, 'Quebec', 44);
INSERT INTO estados VALUES (677, 'Saskatchewan', 44);
INSERT INTO estados VALUES (678, 'Yukon Territory', 44);
INSERT INTO estados VALUES (679, 'Batha', 45);
INSERT INTO estados VALUES (680, 'Biltine', 45);
INSERT INTO estados VALUES (681, 'Borkou-Ennedi-Tibesti', 45);
INSERT INTO estados VALUES (682, 'Chari-Baguirmi', 45);
INSERT INTO estados VALUES (683, 'Guera', 45);
INSERT INTO estados VALUES (684, 'Kanem', 45);
INSERT INTO estados VALUES (685, 'Lac', 45);
INSERT INTO estados VALUES (686, 'Logone Occidental', 45);
INSERT INTO estados VALUES (687, 'Logone Oriental', 45);
INSERT INTO estados VALUES (688, 'Mayo-Kebbi', 45);
INSERT INTO estados VALUES (689, 'Moyen-Chari', 45);
INSERT INTO estados VALUES (690, 'Ouaddai', 45);
INSERT INTO estados VALUES (691, 'Salamat', 45);
INSERT INTO estados VALUES (692, 'Tandjile', 45);
INSERT INTO estados VALUES (693, 'Aisen del General Carlos Ibanez del Campo', 46);
INSERT INTO estados VALUES (694, 'Antofagasta', 46);
INSERT INTO estados VALUES (695, 'Araucania', 46);
INSERT INTO estados VALUES (696, 'Atacama', 46);
INSERT INTO estados VALUES (697, 'Bio-Bio', 46);
INSERT INTO estados VALUES (698, 'Coquimbo', 46);
INSERT INTO estados VALUES (699, 'Libertador General Bernardo OHiggins', 46);
INSERT INTO estados VALUES (700, 'Los Lagos', 46);
INSERT INTO estados VALUES (701, 'Magallanes y de la Antartica Chilena', 46);
INSERT INTO estados VALUES (702, 'Maule', 46);
INSERT INTO estados VALUES (703, 'Region Metropolitana', 46);
INSERT INTO estados VALUES (704, 'Tarapaca', 46);
INSERT INTO estados VALUES (705, 'Valparaiso', 46);
INSERT INTO estados VALUES (706, 'Anhui', 47);
INSERT INTO estados VALUES (707, 'Beijing', 47);
INSERT INTO estados VALUES (708, 'Chongqing', 47);
INSERT INTO estados VALUES (709, 'Fujian', 47);
INSERT INTO estados VALUES (710, 'Gansu', 47);
INSERT INTO estados VALUES (711, 'Guangdong', 47);
INSERT INTO estados VALUES (712, 'Guangxi', 47);
INSERT INTO estados VALUES (713, 'Guizhou', 47);
INSERT INTO estados VALUES (714, 'Hainan', 47);
INSERT INTO estados VALUES (715, 'Hebei', 47);
INSERT INTO estados VALUES (716, 'Heilongjiang', 47);
INSERT INTO estados VALUES (717, 'Henan', 47);
INSERT INTO estados VALUES (718, 'Hubei', 47);
INSERT INTO estados VALUES (719, 'Hunan', 47);
INSERT INTO estados VALUES (720, 'Jiangsu', 47);
INSERT INTO estados VALUES (721, 'Jiangxi', 47);
INSERT INTO estados VALUES (722, 'Jilin', 47);
INSERT INTO estados VALUES (723, 'Liaoning', 47);
INSERT INTO estados VALUES (724, 'Nei Mongol', 47);
INSERT INTO estados VALUES (725, 'Ningxia', 47);
INSERT INTO estados VALUES (726, 'Qinghai', 47);
INSERT INTO estados VALUES (727, 'Shaanxi', 47);
INSERT INTO estados VALUES (728, 'Shandong', 47);
INSERT INTO estados VALUES (729, 'Shanghai', 47);
INSERT INTO estados VALUES (730, 'Shanxi', 47);
INSERT INTO estados VALUES (731, 'Sichuan', 47);
INSERT INTO estados VALUES (732, 'Tianjin', 47);
INSERT INTO estados VALUES (733, 'Xinjiang', 47);
INSERT INTO estados VALUES (734, 'Xizang', 47);
INSERT INTO estados VALUES (735, 'Yunnan', 47);
INSERT INTO estados VALUES (736, 'Zhejiang', 47);
INSERT INTO estados VALUES (737, 'Famagusta', 48);
INSERT INTO estados VALUES (738, 'Kyrenia', 48);
INSERT INTO estados VALUES (739, 'Larnaca', 48);
INSERT INTO estados VALUES (740, 'Limassol', 48);
INSERT INTO estados VALUES (741, 'Nicosia', 48);
INSERT INTO estados VALUES (742, 'Paphos', 48);
INSERT INTO estados VALUES (743, 'Amazonas', 49);
INSERT INTO estados VALUES (744, 'Antioquia', 49);
INSERT INTO estados VALUES (745, 'Arauca', 49);
INSERT INTO estados VALUES (746, 'Atlantico', 49);
INSERT INTO estados VALUES (747, 'Bolivar', 49);
INSERT INTO estados VALUES (748, 'Bolivar Department', 49);
INSERT INTO estados VALUES (749, 'Boyaca', 49);
INSERT INTO estados VALUES (750, 'Boyaca Department', 49);
INSERT INTO estados VALUES (751, 'Caldas', 49);
INSERT INTO estados VALUES (752, 'Caldas Department', 49);
INSERT INTO estados VALUES (753, 'Caqueta', 49);
INSERT INTO estados VALUES (754, 'Casanare', 49);
INSERT INTO estados VALUES (755, 'Cauca', 49);
INSERT INTO estados VALUES (756, 'Cesar', 49);
INSERT INTO estados VALUES (757, 'Choco', 49);
INSERT INTO estados VALUES (758, 'Cordoba', 49);
INSERT INTO estados VALUES (759, 'Cundinamarca', 49);
INSERT INTO estados VALUES (760, 'Distrito Especial', 49);
INSERT INTO estados VALUES (761, 'Guainia', 49);
INSERT INTO estados VALUES (762, 'Guaviare', 49);
INSERT INTO estados VALUES (763, 'Huila', 49);
INSERT INTO estados VALUES (764, 'La Guajira', 49);
INSERT INTO estados VALUES (765, 'Magdalena', 49);
INSERT INTO estados VALUES (766, 'Magdalena Department', 49);
INSERT INTO estados VALUES (767, 'Meta', 49);
INSERT INTO estados VALUES (768, 'Narino', 49);
INSERT INTO estados VALUES (769, 'Norte de Santander', 49);
INSERT INTO estados VALUES (770, 'Putumayo', 49);
INSERT INTO estados VALUES (771, 'Quindio', 49);
INSERT INTO estados VALUES (772, 'Risaralda', 49);
INSERT INTO estados VALUES (773, 'San Andres y Providencia', 49);
INSERT INTO estados VALUES (774, 'Santander', 49);
INSERT INTO estados VALUES (775, 'Sucre', 49);
INSERT INTO estados VALUES (776, 'Tolima', 49);
INSERT INTO estados VALUES (777, 'Valle del Cauca', 49);
INSERT INTO estados VALUES (778, 'Vaupes', 49);
INSERT INTO estados VALUES (779, 'Vichada', 49);
INSERT INTO estados VALUES (780, 'Anjouan', 50);
INSERT INTO estados VALUES (781, 'Grande Comore', 50);
INSERT INTO estados VALUES (782, 'Moheli', 50);
INSERT INTO estados VALUES (783, 'Bouenza', 51);
INSERT INTO estados VALUES (784, 'Brazzaville', 51);
INSERT INTO estados VALUES (785, 'Cuvette', 51);
INSERT INTO estados VALUES (786, 'Kouilou', 51);
INSERT INTO estados VALUES (787, 'Lekoumou', 51);
INSERT INTO estados VALUES (788, 'Likouala', 51);
INSERT INTO estados VALUES (789, 'Niari', 51);
INSERT INTO estados VALUES (790, 'Plateaux', 51);
INSERT INTO estados VALUES (791, 'Pool', 51);
INSERT INTO estados VALUES (792, 'Sangha', 51);
INSERT INTO estados VALUES (793, 'Chagang-do', 52);
INSERT INTO estados VALUES (794, 'Hamgyong-bukto', 52);
INSERT INTO estados VALUES (795, 'Hamgyong-namdo', 52);
INSERT INTO estados VALUES (796, 'Hwanghae-bukto', 52);
INSERT INTO estados VALUES (797, 'Hwanghae-namdo', 52);
INSERT INTO estados VALUES (798, 'Kaesong-si', 52);
INSERT INTO estados VALUES (799, 'Kangwon-do', 52);
INSERT INTO estados VALUES (800, 'Najin Sonbong-si', 52);
INSERT INTO estados VALUES (801, 'Nampo-si', 52);
INSERT INTO estados VALUES (802, 'P yongan-bukto', 52);
INSERT INTO estados VALUES (803, 'P yongan-namdo', 52);
INSERT INTO estados VALUES (804, 'P yongyang-si', 52);
INSERT INTO estados VALUES (805, 'Yanggang-do', 52);
INSERT INTO estados VALUES (806, 'Ch ungch ong-bukto', 53);
INSERT INTO estados VALUES (807, 'Ch ungch ong-namdo', 53);
INSERT INTO estados VALUES (808, 'Cheju-do', 53);
INSERT INTO estados VALUES (809, 'Cholla-bukto', 53);
INSERT INTO estados VALUES (810, 'Cholla-namdo', 53);
INSERT INTO estados VALUES (811, 'Inch on-jikhalsi', 53);
INSERT INTO estados VALUES (812, 'Kangwon-do', 53);
INSERT INTO estados VALUES (813, 'Kwangju-jikhalsi', 53);
INSERT INTO estados VALUES (814, 'Kyonggi-do', 53);
INSERT INTO estados VALUES (815, 'Kyongsang-bukto', 53);
INSERT INTO estados VALUES (816, 'Kyongsang-namdo', 53);
INSERT INTO estados VALUES (817, 'Pusan-jikhalsi', 53);
INSERT INTO estados VALUES (818, 'Seoul-tukpyolsi', 53);
INSERT INTO estados VALUES (819, 'Taegu-jikhalsi', 53);
INSERT INTO estados VALUES (820, 'Taejon-jikhalsi', 53);
INSERT INTO estados VALUES (821, 'Ulsan-gwangyoksi', 53);
INSERT INTO estados VALUES (822, 'Alajuela', 54);
INSERT INTO estados VALUES (823, 'Cartago', 54);
INSERT INTO estados VALUES (824, 'Guanacaste', 54);
INSERT INTO estados VALUES (825, 'Heredia', 54);
INSERT INTO estados VALUES (826, 'Limon', 54);
INSERT INTO estados VALUES (827, 'Puntarenas', 54);
INSERT INTO estados VALUES (828, 'San Jose', 54);
INSERT INTO estados VALUES (829, 'Abengourou', 55);
INSERT INTO estados VALUES (830, 'Abidjan', 55);
INSERT INTO estados VALUES (831, 'Aboisso', 55);
INSERT INTO estados VALUES (832, 'Adiake', 55);
INSERT INTO estados VALUES (833, 'Adzope', 55);
INSERT INTO estados VALUES (834, 'Agboville', 55);
INSERT INTO estados VALUES (835, 'Alepe', 55);
INSERT INTO estados VALUES (836, 'Bangolo', 55);
INSERT INTO estados VALUES (837, 'Beoumi', 55);
INSERT INTO estados VALUES (838, 'Biankouma', 55);
INSERT INTO estados VALUES (839, 'Bocanda', 55);
INSERT INTO estados VALUES (840, 'Bondoukou', 55);
INSERT INTO estados VALUES (841, 'Bongouanou', 55);
INSERT INTO estados VALUES (842, 'Bouafle', 55);
INSERT INTO estados VALUES (843, 'Bouake', 55);
INSERT INTO estados VALUES (844, 'Bouna', 55);
INSERT INTO estados VALUES (845, 'Boundiali', 55);
INSERT INTO estados VALUES (846, 'Dabakala', 55);
INSERT INTO estados VALUES (847, 'Dabou', 55);
INSERT INTO estados VALUES (848, 'Daloa', 55);
INSERT INTO estados VALUES (849, 'Danane', 55);
INSERT INTO estados VALUES (850, 'Daoukro', 55);
INSERT INTO estados VALUES (851, 'Dimbokro', 55);
INSERT INTO estados VALUES (852, 'Divo', 55);
INSERT INTO estados VALUES (853, 'Duekoue', 55);
INSERT INTO estados VALUES (854, 'Ferkessedougou', 55);
INSERT INTO estados VALUES (855, 'Gagnoa', 55);
INSERT INTO estados VALUES (856, 'Grand-Bassam', 55);
INSERT INTO estados VALUES (857, 'Grand-Lahou', 55);
INSERT INTO estados VALUES (858, 'Guiglo', 55);
INSERT INTO estados VALUES (859, 'Haut-Sassandra Region', 55);
INSERT INTO estados VALUES (860, 'Issia', 55);
INSERT INTO estados VALUES (861, 'Jacqueville', 55);
INSERT INTO estados VALUES (862, 'Katiola', 55);
INSERT INTO estados VALUES (863, 'Korhogo', 55);
INSERT INTO estados VALUES (864, 'Lagunes Region', 55);
INSERT INTO estados VALUES (865, 'Lakota', 55);
INSERT INTO estados VALUES (866, 'Man', 55);
INSERT INTO estados VALUES (867, 'Mankono', 55);
INSERT INTO estados VALUES (868, 'Mbahiakro', 55);
INSERT INTO estados VALUES (869, 'Odienne', 55);
INSERT INTO estados VALUES (870, 'Oume', 55);
INSERT INTO estados VALUES (871, 'Sakassou', 55);
INSERT INTO estados VALUES (872, 'San Pedro', 55);
INSERT INTO estados VALUES (873, 'Sassandra', 55);
INSERT INTO estados VALUES (874, 'Seguela', 55);
INSERT INTO estados VALUES (875, 'Sinfra', 55);
INSERT INTO estados VALUES (876, 'Soubre', 55);
INSERT INTO estados VALUES (877, 'Tabou', 55);
INSERT INTO estados VALUES (878, 'Tanda', 55);
INSERT INTO estados VALUES (879, 'Tiassale', 55);
INSERT INTO estados VALUES (880, 'Tiebissou', 55);
INSERT INTO estados VALUES (881, 'Tingrela', 55);
INSERT INTO estados VALUES (882, 'Touba', 55);
INSERT INTO estados VALUES (883, 'Toulepleu', 55);
INSERT INTO estados VALUES (884, 'Toumodi', 55);
INSERT INTO estados VALUES (885, 'Vavoua', 55);
INSERT INTO estados VALUES (886, 'Yamoussoukro', 55);
INSERT INTO estados VALUES (887, 'Zuenoula', 55);
INSERT INTO estados VALUES (888, 'Bjelovarsko-Bilogorska', 56);
INSERT INTO estados VALUES (889, 'Brodsko-Posavska', 56);
INSERT INTO estados VALUES (890, 'Dubrovacko-Neretvanska', 56);
INSERT INTO estados VALUES (891, 'Grad Zagreb', 56);
INSERT INTO estados VALUES (892, 'Istarska', 56);
INSERT INTO estados VALUES (893, 'Karlovacka', 56);
INSERT INTO estados VALUES (894, 'Koprivnicko-Krizevacka', 56);
INSERT INTO estados VALUES (895, 'Krapinsko-Zagorska', 56);
INSERT INTO estados VALUES (896, 'Licko-Senjska', 56);
INSERT INTO estados VALUES (897, 'Medimurska', 56);
INSERT INTO estados VALUES (898, 'Osjecko-Baranjska', 56);
INSERT INTO estados VALUES (899, 'Pozesko-Slavonska', 56);
INSERT INTO estados VALUES (900, 'Primorsko-Goranska', 56);
INSERT INTO estados VALUES (901, 'Sibensko-Kninska', 56);
INSERT INTO estados VALUES (902, 'Sisacko-Moslavacka', 56);
INSERT INTO estados VALUES (903, 'Splitsko-Dalmatinska', 56);
INSERT INTO estados VALUES (904, 'Varazdinska', 56);
INSERT INTO estados VALUES (905, 'Viroviticko-Podravska', 56);
INSERT INTO estados VALUES (906, 'Vukovarsko-Srijemska', 56);
INSERT INTO estados VALUES (907, 'Zadarska', 56);
INSERT INTO estados VALUES (908, 'Zagrebacka', 56);
INSERT INTO estados VALUES (909, 'Camaguey', 57);
INSERT INTO estados VALUES (910, 'Ciego de Avila', 57);
INSERT INTO estados VALUES (911, 'Cienfuegos', 57);
INSERT INTO estados VALUES (912, 'Ciudad de la Habana', 57);
INSERT INTO estados VALUES (913, 'Granma', 57);
INSERT INTO estados VALUES (914, 'Guantanamo', 57);
INSERT INTO estados VALUES (915, 'Holguin', 57);
INSERT INTO estados VALUES (916, 'Isla de la Juventud', 57);
INSERT INTO estados VALUES (917, 'La Habana', 57);
INSERT INTO estados VALUES (918, 'Las Tunas', 57);
INSERT INTO estados VALUES (919, 'Matanzas', 57);
INSERT INTO estados VALUES (920, 'Pinar del Rio', 57);
INSERT INTO estados VALUES (921, 'Sancti Spiritus', 57);
INSERT INTO estados VALUES (922, 'Santiago de Cuba', 57);
INSERT INTO estados VALUES (923, 'Villa Clara', 57);
INSERT INTO estados VALUES (924, 'Arhus', 58);
INSERT INTO estados VALUES (925, 'Bornholm', 58);
INSERT INTO estados VALUES (926, 'Frederiksborg', 58);
INSERT INTO estados VALUES (927, 'Fyn', 58);
INSERT INTO estados VALUES (928, 'Kobenhavn', 58);
INSERT INTO estados VALUES (929, 'Nordjylland', 58);
INSERT INTO estados VALUES (930, 'Ribe', 58);
INSERT INTO estados VALUES (931, 'Ringkobing', 58);
INSERT INTO estados VALUES (932, 'Roskilde', 58);
INSERT INTO estados VALUES (933, 'Sonderjylland', 58);
INSERT INTO estados VALUES (934, 'Staden Kobenhavn', 58);
INSERT INTO estados VALUES (935, 'Storstrom', 58);
INSERT INTO estados VALUES (936, 'Vejle', 58);
INSERT INTO estados VALUES (937, 'Vestsjalland', 58);
INSERT INTO estados VALUES (938, 'Viborg', 58);
INSERT INTO estados VALUES (939, 'Dikhil', 59);
INSERT INTO estados VALUES (940, 'Djibouti', 59);
INSERT INTO estados VALUES (941, 'Obock', 59);
INSERT INTO estados VALUES (942, 'Tadjoura', 59);
INSERT INTO estados VALUES (943, 'Saint Andrew', 60);
INSERT INTO estados VALUES (944, 'Saint David', 60);
INSERT INTO estados VALUES (945, 'Saint George', 60);
INSERT INTO estados VALUES (946, 'Saint John', 60);
INSERT INTO estados VALUES (947, 'Saint Joseph', 60);
INSERT INTO estados VALUES (948, 'Saint Luke', 60);
INSERT INTO estados VALUES (949, 'Saint Mark', 60);
INSERT INTO estados VALUES (950, 'Saint Patrick', 60);
INSERT INTO estados VALUES (951, 'Saint Paul', 60);
INSERT INTO estados VALUES (952, 'Saint Peter', 60);
INSERT INTO estados VALUES (953, 'East Timor (General)', 61);
INSERT INTO estados VALUES (954, 'Azuay', 62);
INSERT INTO estados VALUES (955, 'Bolivar', 62);
INSERT INTO estados VALUES (956, 'Canar', 62);
INSERT INTO estados VALUES (957, 'Carchi', 62);
INSERT INTO estados VALUES (958, 'Chimborazo', 62);
INSERT INTO estados VALUES (959, 'Cotopaxi', 62);
INSERT INTO estados VALUES (960, 'El Oro', 62);
INSERT INTO estados VALUES (961, 'Esmeraldas', 62);
INSERT INTO estados VALUES (962, 'Galapagos', 62);
INSERT INTO estados VALUES (963, 'Guayas', 62);
INSERT INTO estados VALUES (964, 'Imbabura', 62);
INSERT INTO estados VALUES (965, 'Loja', 62);
INSERT INTO estados VALUES (966, 'Los Rios', 62);
INSERT INTO estados VALUES (967, 'Manabi', 62);
INSERT INTO estados VALUES (968, 'Morona-Santiago', 62);
INSERT INTO estados VALUES (969, 'Napo', 62);
INSERT INTO estados VALUES (970, 'Orellana', 62);
INSERT INTO estados VALUES (971, 'Pastaza', 62);
INSERT INTO estados VALUES (972, 'Pichincha', 62);
INSERT INTO estados VALUES (973, 'Sucumbios', 62);
INSERT INTO estados VALUES (974, 'Tungurahua', 62);
INSERT INTO estados VALUES (975, 'Zamora-Chinchipe', 62);
INSERT INTO estados VALUES (976, 'Ad Daqahliyah', 63);
INSERT INTO estados VALUES (977, 'Al Bahr al Ahmar', 63);
INSERT INTO estados VALUES (978, 'Al Buhayrah', 63);
INSERT INTO estados VALUES (979, 'Al Fayyum', 63);
INSERT INTO estados VALUES (980, 'Al Gharbiyah', 63);
INSERT INTO estados VALUES (981, 'Al Iskandariyah', 63);
INSERT INTO estados VALUES (982, 'Al Isma iliyah', 63);
INSERT INTO estados VALUES (983, 'Al Jizah', 63);
INSERT INTO estados VALUES (984, 'Al Minufiyah', 63);
INSERT INTO estados VALUES (985, 'Al Minya', 63);
INSERT INTO estados VALUES (986, 'Al Qahirah', 63);
INSERT INTO estados VALUES (987, 'Al Qalyubiyah', 63);
INSERT INTO estados VALUES (988, 'Al Wadi al Jadid', 63);
INSERT INTO estados VALUES (989, 'As Suways', 63);
INSERT INTO estados VALUES (990, 'Ash Sharqiyah', 63);
INSERT INTO estados VALUES (991, 'Aswan', 63);
INSERT INTO estados VALUES (992, 'Asyut', 63);
INSERT INTO estados VALUES (993, 'Bani Suwayf', 63);
INSERT INTO estados VALUES (994, 'Bur Said', 63);
INSERT INTO estados VALUES (995, 'Dumyat', 63);
INSERT INTO estados VALUES (996, 'Janub Sina', 63);
INSERT INTO estados VALUES (997, 'Kafr ash Shaykh', 63);
INSERT INTO estados VALUES (998, 'Matruh', 63);
INSERT INTO estados VALUES (999, 'Qina', 63);
INSERT INTO estados VALUES (1000, 'Shamal Sina', 63);
INSERT INTO estados VALUES (1001, 'Suhaj', 63);
INSERT INTO estados VALUES (1002, 'Ahuachapan', 64);
INSERT INTO estados VALUES (1003, 'Cabanas', 64);
INSERT INTO estados VALUES (1004, 'Chalatenango', 64);
INSERT INTO estados VALUES (1005, 'Cuscatlan', 64);
INSERT INTO estados VALUES (1006, 'La Libertad', 64);
INSERT INTO estados VALUES (1007, 'La Paz', 64);
INSERT INTO estados VALUES (1008, 'La Union', 64);
INSERT INTO estados VALUES (1009, 'Morazan', 64);
INSERT INTO estados VALUES (1010, 'San Miguel', 64);
INSERT INTO estados VALUES (1011, 'San Salvador', 64);
INSERT INTO estados VALUES (1012, 'San Vicente', 64);
INSERT INTO estados VALUES (1013, 'Santa Ana', 64);
INSERT INTO estados VALUES (1014, 'Sonsonate', 64);
INSERT INTO estados VALUES (1015, 'Usulutan', 64);
INSERT INTO estados VALUES (1016, 'Holy See (Vatican City State) (General)', 65);
INSERT INTO estados VALUES (1017, 'Abu Dhabi', 66);
INSERT INTO estados VALUES (1018, 'Ajman', 66);
INSERT INTO estados VALUES (1019, 'Dubai', 66);
INSERT INTO estados VALUES (1020, 'Fujairah', 66);
INSERT INTO estados VALUES (1021, 'Ras Al Khaimah', 66);
INSERT INTO estados VALUES (1022, 'Sharjah', 66);
INSERT INTO estados VALUES (1023, 'Umm Al Quwain', 66);
INSERT INTO estados VALUES (1024, 'Eritrea (General)', 67);
INSERT INTO estados VALUES (1025, 'Banska Bystrica', 68);
INSERT INTO estados VALUES (1026, 'Bratislava', 68);
INSERT INTO estados VALUES (1027, 'Kosice', 68);
INSERT INTO estados VALUES (1028, 'Nitra', 68);
INSERT INTO estados VALUES (1029, 'Presov', 68);
INSERT INTO estados VALUES (1030, 'Trencin', 68);
INSERT INTO estados VALUES (1031, 'Trnava', 68);
INSERT INTO estados VALUES (1032, 'Zilina', 68);
INSERT INTO estados VALUES (1033, 'Ajdovscina', 69);
INSERT INTO estados VALUES (1034, 'Beltinci', 69);
INSERT INTO estados VALUES (1035, 'Bled', 69);
INSERT INTO estados VALUES (1036, 'Bohinj', 69);
INSERT INTO estados VALUES (1037, 'Borovnica', 69);
INSERT INTO estados VALUES (1038, 'Bovec', 69);
INSERT INTO estados VALUES (1039, 'Brda', 69);
INSERT INTO estados VALUES (1040, 'Brezice', 69);
INSERT INTO estados VALUES (1041, 'Brezovica', 69);
INSERT INTO estados VALUES (1042, 'Celje', 69);
INSERT INTO estados VALUES (1043, 'Cerklje na Gorenjskem', 69);
INSERT INTO estados VALUES (1044, 'Cerknica', 69);
INSERT INTO estados VALUES (1045, 'Cerkno', 69);
INSERT INTO estados VALUES (1046, 'Crensovci', 69);
INSERT INTO estados VALUES (1047, 'Crna na Koroskem', 69);
INSERT INTO estados VALUES (1048, 'Crnomelj', 69);
INSERT INTO estados VALUES (1049, 'Divaca', 69);
INSERT INTO estados VALUES (1050, 'Dobrepolje', 69);
INSERT INTO estados VALUES (1051, 'Dobrova-Horjul-Polhov Gradec', 69);
INSERT INTO estados VALUES (1052, 'Dol pri Ljubljani', 69);
INSERT INTO estados VALUES (1053, 'Domzale', 69);
INSERT INTO estados VALUES (1054, 'Dornava', 69);
INSERT INTO estados VALUES (1055, 'Dravograd', 69);
INSERT INTO estados VALUES (1056, 'Duplek', 69);
INSERT INTO estados VALUES (1057, 'Gorenja Vas-Poljane', 69);
INSERT INTO estados VALUES (1058, 'Gorisnica', 69);
INSERT INTO estados VALUES (1059, 'Gornja Radgona', 69);
INSERT INTO estados VALUES (1060, 'Gornji Grad', 69);
INSERT INTO estados VALUES (1061, 'Gornji Petrovci', 69);
INSERT INTO estados VALUES (1062, 'Grosuplje', 69);
INSERT INTO estados VALUES (1063, 'Hrastnik', 69);
INSERT INTO estados VALUES (1064, 'Hrpelje-Kozina', 69);
INSERT INTO estados VALUES (1065, 'Idrija', 69);
INSERT INTO estados VALUES (1066, 'Ig', 69);
INSERT INTO estados VALUES (1067, 'Ilirska Bistrica', 69);
INSERT INTO estados VALUES (1068, 'Ivancna Gorica', 69);
INSERT INTO estados VALUES (1069, 'Izola-Isola', 69);
INSERT INTO estados VALUES (1070, 'Jesenice', 69);
INSERT INTO estados VALUES (1071, 'Jursinci', 69);
INSERT INTO estados VALUES (1072, 'Kamnik', 69);
INSERT INTO estados VALUES (1073, 'Kanal', 69);
INSERT INTO estados VALUES (1074, 'Kidricevo', 69);
INSERT INTO estados VALUES (1075, 'Kobarid', 69);
INSERT INTO estados VALUES (1076, 'Kobilje', 69);
INSERT INTO estados VALUES (1077, 'Kocevje', 69);
INSERT INTO estados VALUES (1078, 'Komen', 69);
INSERT INTO estados VALUES (1079, 'Koper-Capodistria', 69);
INSERT INTO estados VALUES (1080, 'Kozje', 69);
INSERT INTO estados VALUES (1081, 'Kranj', 69);
INSERT INTO estados VALUES (1082, 'Kranjska Gora', 69);
INSERT INTO estados VALUES (1083, 'Krsko', 69);
INSERT INTO estados VALUES (1084, 'Kungota', 69);
INSERT INTO estados VALUES (1085, 'Kuzma', 69);
INSERT INTO estados VALUES (1086, 'Lasko', 69);
INSERT INTO estados VALUES (1087, 'Lenart', 69);
INSERT INTO estados VALUES (1088, 'Litija', 69);
INSERT INTO estados VALUES (1089, 'Ljubljana', 69);
INSERT INTO estados VALUES (1090, 'Ljubno', 69);
INSERT INTO estados VALUES (1091, 'Ljutomer', 69);
INSERT INTO estados VALUES (1092, 'Logatec', 69);
INSERT INTO estados VALUES (1093, 'Loska Dolina', 69);
INSERT INTO estados VALUES (1094, 'Loski Potok', 69);
INSERT INTO estados VALUES (1095, 'Luce', 69);
INSERT INTO estados VALUES (1096, 'Lukovica', 69);
INSERT INTO estados VALUES (1097, 'Majsperk', 69);
INSERT INTO estados VALUES (1098, 'Maribor', 69);
INSERT INTO estados VALUES (1099, 'Medvode', 69);
INSERT INTO estados VALUES (1100, 'Menges', 69);
INSERT INTO estados VALUES (1101, 'Metlika', 69);
INSERT INTO estados VALUES (1102, 'Mezica', 69);
INSERT INTO estados VALUES (1103, 'Miren-Kostanjevica', 69);
INSERT INTO estados VALUES (1104, 'Mislinja', 69);
INSERT INTO estados VALUES (1105, 'Moravce', 69);
INSERT INTO estados VALUES (1106, 'Moravske Toplice', 69);
INSERT INTO estados VALUES (1107, 'Mozirje', 69);
INSERT INTO estados VALUES (1108, 'Murska Sobota', 69);
INSERT INTO estados VALUES (1109, 'Muta', 69);
INSERT INTO estados VALUES (1110, 'Naklo', 69);
INSERT INTO estados VALUES (1111, 'Nazarje', 69);
INSERT INTO estados VALUES (1112, 'Nova Gorica', 69);
INSERT INTO estados VALUES (1113, 'Novo Mesto', 69);
INSERT INTO estados VALUES (1114, 'Odranci', 69);
INSERT INTO estados VALUES (1115, 'Ormoz', 69);
INSERT INTO estados VALUES (1116, 'Osilnica', 69);
INSERT INTO estados VALUES (1117, 'Pesnica', 69);
INSERT INTO estados VALUES (1118, 'Piran', 69);
INSERT INTO estados VALUES (1119, 'Pivka', 69);
INSERT INTO estados VALUES (1120, 'Podcetrtek', 69);
INSERT INTO estados VALUES (1121, 'Postojna', 69);
INSERT INTO estados VALUES (1122, 'Preddvor', 69);
INSERT INTO estados VALUES (1123, 'Ptuj', 69);
INSERT INTO estados VALUES (1124, 'Puconci', 69);
INSERT INTO estados VALUES (1125, 'Racam', 69);
INSERT INTO estados VALUES (1126, 'Radece', 69);
INSERT INTO estados VALUES (1127, 'Radenci', 69);
INSERT INTO estados VALUES (1128, 'Radlje ob Dravi', 69);
INSERT INTO estados VALUES (1129, 'Radovljica', 69);
INSERT INTO estados VALUES (1130, 'Ribnica', 69);
INSERT INTO estados VALUES (1131, 'Rogaska Slatina', 69);
INSERT INTO estados VALUES (1132, 'Rogasovci', 69);
INSERT INTO estados VALUES (1133, 'Rogatec', 69);
INSERT INTO estados VALUES (1134, 'Ruse', 69);
INSERT INTO estados VALUES (1135, 'Semic', 69);
INSERT INTO estados VALUES (1136, 'Sencur', 69);
INSERT INTO estados VALUES (1137, 'Sentilj', 69);
INSERT INTO estados VALUES (1138, 'Sentjernej', 69);
INSERT INTO estados VALUES (1139, 'Sentjur pri Celju', 69);
INSERT INTO estados VALUES (1140, 'Sevnica', 69);
INSERT INTO estados VALUES (1141, 'Sezana', 69);
INSERT INTO estados VALUES (1142, 'Skocjan', 69);
INSERT INTO estados VALUES (1143, 'Skofja Loka', 69);
INSERT INTO estados VALUES (1144, 'Skofljica', 69);
INSERT INTO estados VALUES (1145, 'Slovenj Gradec', 69);
INSERT INTO estados VALUES (1146, 'Slovenska Bistrica', 69);
INSERT INTO estados VALUES (1147, 'Slovenske Konjice', 69);
INSERT INTO estados VALUES (1148, 'Smarje pri Jelsah', 69);
INSERT INTO estados VALUES (1149, 'Smartno ob Paki', 69);
INSERT INTO estados VALUES (1150, 'Sostanj', 69);
INSERT INTO estados VALUES (1151, 'Starse', 69);
INSERT INTO estados VALUES (1152, 'Store', 69);
INSERT INTO estados VALUES (1153, 'Sveti Jurij', 69);
INSERT INTO estados VALUES (1154, 'Tolmin', 69);
INSERT INTO estados VALUES (1155, 'Trbovlje', 69);
INSERT INTO estados VALUES (1156, 'Trebnje', 69);
INSERT INTO estados VALUES (1157, 'Trzic', 69);
INSERT INTO estados VALUES (1158, 'Turnisce', 69);
INSERT INTO estados VALUES (1159, 'Velenje', 69);
INSERT INTO estados VALUES (1160, 'Velike Lasce', 69);
INSERT INTO estados VALUES (1161, 'Videm', 69);
INSERT INTO estados VALUES (1162, 'Vipava', 69);
INSERT INTO estados VALUES (1163, 'Vitanje', 69);
INSERT INTO estados VALUES (1164, 'Vodice', 69);
INSERT INTO estados VALUES (1165, 'Vojnik', 69);
INSERT INTO estados VALUES (1166, 'Vrhnika', 69);
INSERT INTO estados VALUES (1167, 'Vuzenica', 69);
INSERT INTO estados VALUES (1168, 'Zagorje ob Savi', 69);
INSERT INTO estados VALUES (1169, 'Zalec', 69);
INSERT INTO estados VALUES (1170, 'Zavrc', 69);
INSERT INTO estados VALUES (1171, 'Zelezniki', 69);
INSERT INTO estados VALUES (1172, 'Ziri', 69);
INSERT INTO estados VALUES (1173, 'Zrece', 69);
INSERT INTO estados VALUES (1174, 'Andalucia', 70);
INSERT INTO estados VALUES (1175, 'Aragon', 70);
INSERT INTO estados VALUES (1176, 'Asturias', 70);
INSERT INTO estados VALUES (1177, 'Canarias', 70);
INSERT INTO estados VALUES (1178, 'Cantabria', 70);
INSERT INTO estados VALUES (1179, 'Castilla y Leon', 70);
INSERT INTO estados VALUES (1180, 'Castilla-La Mancha', 70);
INSERT INTO estados VALUES (1181, 'Cataluña', 70);
INSERT INTO estados VALUES (1182, 'Comunidad Valenciana', 70);
INSERT INTO estados VALUES (1183, 'Extremadura', 70);
INSERT INTO estados VALUES (1184, 'Galicia', 70);
INSERT INTO estados VALUES (1185, 'Islas Baleares', 70);
INSERT INTO estados VALUES (1186, 'La Rioja', 70);
INSERT INTO estados VALUES (1187, 'Madrid', 70);
INSERT INTO estados VALUES (1188, 'Murcia', 70);
INSERT INTO estados VALUES (1189, 'Navarra', 70);
INSERT INTO estados VALUES (1190, 'Pais Vasco', 70);
INSERT INTO estados VALUES (1191, 'Alabama', 71);
INSERT INTO estados VALUES (1192, 'Alaska', 71);
INSERT INTO estados VALUES (1193, 'American Samoa', 71);
INSERT INTO estados VALUES (1194, 'Arizona', 71);
INSERT INTO estados VALUES (1195, 'Arkansas', 71);
INSERT INTO estados VALUES (1196, 'California', 71);
INSERT INTO estados VALUES (1197, 'Colorado', 71);
INSERT INTO estados VALUES (1198, 'Connecticut', 71);
INSERT INTO estados VALUES (1199, 'Delaware', 71);
INSERT INTO estados VALUES (1200, 'District of Columbia', 71);
INSERT INTO estados VALUES (1201, 'Federated States of Micronesia', 71);
INSERT INTO estados VALUES (1202, 'Florida', 71);
INSERT INTO estados VALUES (1203, 'Georgia', 71);
INSERT INTO estados VALUES (1204, 'Guam', 71);
INSERT INTO estados VALUES (1205, 'Hawaii', 71);
INSERT INTO estados VALUES (1206, 'Idaho', 71);
INSERT INTO estados VALUES (1207, 'Illinois', 71);
INSERT INTO estados VALUES (1208, 'Indiana', 71);
INSERT INTO estados VALUES (1209, 'Iowa', 71);
INSERT INTO estados VALUES (1210, 'Kansas', 71);
INSERT INTO estados VALUES (1211, 'Kentucky', 71);
INSERT INTO estados VALUES (1212, 'Louisiana', 71);
INSERT INTO estados VALUES (1213, 'Maine', 71);
INSERT INTO estados VALUES (1214, 'Marshall Islands', 71);
INSERT INTO estados VALUES (1215, 'Maryland', 71);
INSERT INTO estados VALUES (1216, 'Massachusetts', 71);
INSERT INTO estados VALUES (1217, 'Michigan', 71);
INSERT INTO estados VALUES (1218, 'Minnesota', 71);
INSERT INTO estados VALUES (1219, 'Mississippi', 71);
INSERT INTO estados VALUES (1220, 'Missouri', 71);
INSERT INTO estados VALUES (1221, 'Montana', 71);
INSERT INTO estados VALUES (1222, 'Nebraska', 71);
INSERT INTO estados VALUES (1223, 'Nevada', 71);
INSERT INTO estados VALUES (1224, 'New Hampshire', 71);
INSERT INTO estados VALUES (1225, 'New Jersey', 71);
INSERT INTO estados VALUES (1226, 'New Mexico', 71);
INSERT INTO estados VALUES (1227, 'New York', 71);
INSERT INTO estados VALUES (1228, 'North Carolina', 71);
INSERT INTO estados VALUES (1229, 'North Dakota', 71);
INSERT INTO estados VALUES (1230, 'Northern Mariana Islands', 71);
INSERT INTO estados VALUES (1231, 'Ohio', 71);
INSERT INTO estados VALUES (1232, 'Oklahoma', 71);
INSERT INTO estados VALUES (1233, 'Oregon', 71);
INSERT INTO estados VALUES (1234, 'Palau', 71);
INSERT INTO estados VALUES (1235, 'Pennsylvania', 71);
INSERT INTO estados VALUES (1236, 'Puerto Rico', 71);
INSERT INTO estados VALUES (1237, 'Rhode Island', 71);
INSERT INTO estados VALUES (1238, 'South Carolina', 71);
INSERT INTO estados VALUES (1239, 'South Dakota', 71);
INSERT INTO estados VALUES (1240, 'Tennessee', 71);
INSERT INTO estados VALUES (1241, 'Texas', 71);
INSERT INTO estados VALUES (1242, 'Utah', 71);
INSERT INTO estados VALUES (1243, 'Vermont', 71);
INSERT INTO estados VALUES (1244, 'Virgin Islands', 71);
INSERT INTO estados VALUES (1245, 'Virginia', 71);
INSERT INTO estados VALUES (1246, 'Washington', 71);
INSERT INTO estados VALUES (1247, 'West Virginia', 71);
INSERT INTO estados VALUES (1248, 'Wisconsin', 71);
INSERT INTO estados VALUES (1249, 'Wyoming', 71);
INSERT INTO estados VALUES (1250, 'Harjumaa', 72);
INSERT INTO estados VALUES (1251, 'Hiiumaa', 72);
INSERT INTO estados VALUES (1252, 'Ida-Virumaa', 72);
INSERT INTO estados VALUES (1253, 'Jarvamaa', 72);
INSERT INTO estados VALUES (1254, 'Jogevamaa', 72);
INSERT INTO estados VALUES (1255, 'Kohtla-Jarve', 72);
INSERT INTO estados VALUES (1256, 'Laane-Virumaa', 72);
INSERT INTO estados VALUES (1257, 'Laanemaa', 72);
INSERT INTO estados VALUES (1258, 'Narva', 72);
INSERT INTO estados VALUES (1259, 'Parnu', 72);
INSERT INTO estados VALUES (1260, 'Parnumaa', 72);
INSERT INTO estados VALUES (1261, 'Polvamaa', 72);
INSERT INTO estados VALUES (1262, 'Raplamaa', 72);
INSERT INTO estados VALUES (1263, 'Saaremaa', 72);
INSERT INTO estados VALUES (1264, 'Sillamae', 72);
INSERT INTO estados VALUES (1265, 'Tallinn', 72);
INSERT INTO estados VALUES (1266, 'Tartu', 72);
INSERT INTO estados VALUES (1267, 'Tartumaa', 72);
INSERT INTO estados VALUES (1268, 'Valgamaa', 72);
INSERT INTO estados VALUES (1269, 'Viljandimaa', 72);
INSERT INTO estados VALUES (1270, 'Vorumaa', 72);
INSERT INTO estados VALUES (1271, 'Addis Abeba', 73);
INSERT INTO estados VALUES (1272, 'Adis Abeba', 73);
INSERT INTO estados VALUES (1273, 'Afar', 73);
INSERT INTO estados VALUES (1274, 'Afar', 73);
INSERT INTO estados VALUES (1275, 'Amara', 73);
INSERT INTO estados VALUES (1276, 'Amhara', 73);
INSERT INTO estados VALUES (1277, 'Benishangul', 73);
INSERT INTO estados VALUES (1278, 'Binshangul Gumuz', 73);
INSERT INTO estados VALUES (1279, 'Dire Dawa', 73);
INSERT INTO estados VALUES (1280, 'Gambela Hizboch', 73);
INSERT INTO estados VALUES (1281, 'Gambella', 73);
INSERT INTO estados VALUES (1282, 'Hareri Hizb', 73);
INSERT INTO estados VALUES (1283, 'Oromiya', 73);
INSERT INTO estados VALUES (1284, 'Somali', 73);
INSERT INTO estados VALUES (1285, 'Southern', 73);
INSERT INTO estados VALUES (1286, 'Sumale', 73);
INSERT INTO estados VALUES (1287, 'Tigray', 73);
INSERT INTO estados VALUES (1288, 'Tigray', 73);
INSERT INTO estados VALUES (1289, 'YeDebub Biheroch Bihereseboch na Hizboch', 73);
INSERT INTO estados VALUES (1290, 'Central', 74);
INSERT INTO estados VALUES (1291, 'Eastern', 74);
INSERT INTO estados VALUES (1292, 'Northern', 74);
INSERT INTO estados VALUES (1293, 'Rotuma', 74);
INSERT INTO estados VALUES (1294, 'Western', 74);
INSERT INTO estados VALUES (1295, 'Abra', 75);
INSERT INTO estados VALUES (1296, 'Agusan del Norte', 75);
INSERT INTO estados VALUES (1297, 'Agusan del Sur', 75);
INSERT INTO estados VALUES (1298, 'Aklan', 75);
INSERT INTO estados VALUES (1299, 'Albay', 75);
INSERT INTO estados VALUES (1300, 'Angeles', 75);
INSERT INTO estados VALUES (1301, 'Antique', 75);
INSERT INTO estados VALUES (1302, 'Aurora', 75);
INSERT INTO estados VALUES (1303, 'Bacolod', 75);
INSERT INTO estados VALUES (1304, 'Bago', 75);
INSERT INTO estados VALUES (1305, 'Baguio', 75);
INSERT INTO estados VALUES (1306, 'Bais', 75);
INSERT INTO estados VALUES (1307, 'Basilan', 75);
INSERT INTO estados VALUES (1308, 'Basilan City', 75);
INSERT INTO estados VALUES (1309, 'Bataan', 75);
INSERT INTO estados VALUES (1310, 'Batanes', 75);
INSERT INTO estados VALUES (1311, 'Batangas', 75);
INSERT INTO estados VALUES (1312, 'Batangas City', 75);
INSERT INTO estados VALUES (1313, 'Benguet', 75);
INSERT INTO estados VALUES (1314, 'Bohol', 75);
INSERT INTO estados VALUES (1315, 'Bukidnon', 75);
INSERT INTO estados VALUES (1316, 'Bulacan', 75);
INSERT INTO estados VALUES (1317, 'Butuan', 75);
INSERT INTO estados VALUES (1318, 'Cabanatuan', 75);
INSERT INTO estados VALUES (1319, 'Cadiz', 75);
INSERT INTO estados VALUES (1320, 'Cagayan', 75);
INSERT INTO estados VALUES (1321, 'Cagayan de Oro', 75);
INSERT INTO estados VALUES (1322, 'Calbayog', 75);
INSERT INTO estados VALUES (1323, 'Caloocan', 75);
INSERT INTO estados VALUES (1324, 'Camarines Norte', 75);
INSERT INTO estados VALUES (1325, 'Camarines Sur', 75);
INSERT INTO estados VALUES (1326, 'Camiguin', 75);
INSERT INTO estados VALUES (1327, 'Canlaon', 75);
INSERT INTO estados VALUES (1328, 'Capiz', 75);
INSERT INTO estados VALUES (1329, 'Catanduanes', 75);
INSERT INTO estados VALUES (1330, 'Cavite', 75);
INSERT INTO estados VALUES (1331, 'Cavite City', 75);
INSERT INTO estados VALUES (1332, 'Cebu', 75);
INSERT INTO estados VALUES (1333, 'Cebu City', 75);
INSERT INTO estados VALUES (1334, 'Cotabato', 75);
INSERT INTO estados VALUES (1335, 'Dagupan', 75);
INSERT INTO estados VALUES (1336, 'Danao', 75);
INSERT INTO estados VALUES (1337, 'Dapitan', 75);
INSERT INTO estados VALUES (1338, 'Davao', 75);
INSERT INTO estados VALUES (1339, 'Davao City', 75);
INSERT INTO estados VALUES (1340, 'Davao Oriental', 75);
INSERT INTO estados VALUES (1341, 'Davao del Sur', 75);
INSERT INTO estados VALUES (1342, 'Dipolog', 75);
INSERT INTO estados VALUES (1343, 'Dumaguete', 75);
INSERT INTO estados VALUES (1344, 'Eastern Samar', 75);
INSERT INTO estados VALUES (1345, 'General Santos', 75);
INSERT INTO estados VALUES (1346, 'Gingoog', 75);
INSERT INTO estados VALUES (1347, 'Ifugao', 75);
INSERT INTO estados VALUES (1348, 'Iligan', 75);
INSERT INTO estados VALUES (1349, 'Ilocos Norte', 75);
INSERT INTO estados VALUES (1350, 'Ilocos Sur', 75);
INSERT INTO estados VALUES (1351, 'Iloilo', 75);
INSERT INTO estados VALUES (1352, 'Iloilo City', 75);
INSERT INTO estados VALUES (1353, 'Iriga', 75);
INSERT INTO estados VALUES (1354, 'Isabela', 75);
INSERT INTO estados VALUES (1355, 'Kalinga-Apayao', 75);
INSERT INTO estados VALUES (1356, 'La Carlota', 75);
INSERT INTO estados VALUES (1357, 'La Union', 75);
INSERT INTO estados VALUES (1358, 'Laguna', 75);
INSERT INTO estados VALUES (1359, 'Lanao del Norte', 75);
INSERT INTO estados VALUES (1360, 'Lanao del Sur', 75);
INSERT INTO estados VALUES (1361, 'Laoag', 75);
INSERT INTO estados VALUES (1362, 'Lapu-Lapu', 75);
INSERT INTO estados VALUES (1363, 'Legaspi', 75);
INSERT INTO estados VALUES (1364, 'Leyte', 75);
INSERT INTO estados VALUES (1365, 'Lipa', 75);
INSERT INTO estados VALUES (1366, 'Lucena', 75);
INSERT INTO estados VALUES (1367, 'Maguindanao', 75);
INSERT INTO estados VALUES (1368, 'Mandaue', 75);
INSERT INTO estados VALUES (1369, 'Manila', 75);
INSERT INTO estados VALUES (1370, 'Marawi', 75);
INSERT INTO estados VALUES (1371, 'Marinduque', 75);
INSERT INTO estados VALUES (1372, 'Masbate', 75);
INSERT INTO estados VALUES (1373, 'Mindoro Occidental', 75);
INSERT INTO estados VALUES (1374, 'Mindoro Oriental', 75);
INSERT INTO estados VALUES (1375, 'Misamis Occidental', 75);
INSERT INTO estados VALUES (1376, 'Misamis Oriental', 75);
INSERT INTO estados VALUES (1377, 'Mountain', 75);
INSERT INTO estados VALUES (1378, 'Naga', 75);
INSERT INTO estados VALUES (1379, 'Negros Occidental', 75);
INSERT INTO estados VALUES (1380, 'Negros Oriental', 75);
INSERT INTO estados VALUES (1381, 'North Cotabato', 75);
INSERT INTO estados VALUES (1382, 'Northern Samar', 75);
INSERT INTO estados VALUES (1383, 'Nueva Ecija', 75);
INSERT INTO estados VALUES (1384, 'Nueva Vizcaya', 75);
INSERT INTO estados VALUES (1385, 'Olongapo', 75);
INSERT INTO estados VALUES (1386, 'Ormoc', 75);
INSERT INTO estados VALUES (1387, 'Oroquieta', 75);
INSERT INTO estados VALUES (1388, 'Ozamis', 75);
INSERT INTO estados VALUES (1389, 'Pagadian', 75);
INSERT INTO estados VALUES (1390, 'Palawan', 75);
INSERT INTO estados VALUES (1391, 'Palayan', 75);
INSERT INTO estados VALUES (1392, 'Pampanga', 75);
INSERT INTO estados VALUES (1393, 'Pangasinan', 75);
INSERT INTO estados VALUES (1394, 'Pasay', 75);
INSERT INTO estados VALUES (1395, 'Puerto Princesa', 75);
INSERT INTO estados VALUES (1396, 'Quezon', 75);
INSERT INTO estados VALUES (1397, 'Quezon City', 75);
INSERT INTO estados VALUES (1398, 'Quirino', 75);
INSERT INTO estados VALUES (1399, 'Rizal', 75);
INSERT INTO estados VALUES (1400, 'Romblon', 75);
INSERT INTO estados VALUES (1401, 'Roxas', 75);
INSERT INTO estados VALUES (1402, 'Samar', 75);
INSERT INTO estados VALUES (1403, 'San Carlos', 75);
INSERT INTO estados VALUES (1404, 'San Carlos', 75);
INSERT INTO estados VALUES (1405, 'San Jose', 75);
INSERT INTO estados VALUES (1406, 'San Pablo', 75);
INSERT INTO estados VALUES (1407, 'Silay', 75);
INSERT INTO estados VALUES (1408, 'Siquijor', 75);
INSERT INTO estados VALUES (1409, 'Sorsogon', 75);
INSERT INTO estados VALUES (1410, 'South Cotabato', 75);
INSERT INTO estados VALUES (1411, 'Southern Leyte', 75);
INSERT INTO estados VALUES (1412, 'Sultan Kudarat', 75);
INSERT INTO estados VALUES (1413, 'Sulu', 75);
INSERT INTO estados VALUES (1414, 'Surigao', 75);
INSERT INTO estados VALUES (1415, 'Surigao del Norte', 75);
INSERT INTO estados VALUES (1416, 'Surigao del Sur', 75);
INSERT INTO estados VALUES (1417, 'Tacloban', 75);
INSERT INTO estados VALUES (1418, 'Tagaytay', 75);
INSERT INTO estados VALUES (1419, 'Tagbilaran', 75);
INSERT INTO estados VALUES (1420, 'Tangub', 75);
INSERT INTO estados VALUES (1421, 'Tarlac', 75);
INSERT INTO estados VALUES (1422, 'Tawitawi', 75);
INSERT INTO estados VALUES (1423, 'Toledo', 75);
INSERT INTO estados VALUES (1424, 'Trece Martires', 75);
INSERT INTO estados VALUES (1425, 'Zambales', 75);
INSERT INTO estados VALUES (1426, 'Zamboanga', 75);
INSERT INTO estados VALUES (1427, 'Zamboanga del Norte', 75);
INSERT INTO estados VALUES (1428, 'Zamboanga del Sur', 75);
INSERT INTO estados VALUES (1429, 'Eastern Finland', 76);
INSERT INTO estados VALUES (1430, 'Lapland', 76);
INSERT INTO estados VALUES (1431, 'Oulu', 76);
INSERT INTO estados VALUES (1432, 'Southern Finland', 76);
INSERT INTO estados VALUES (1433, 'Western Finland', 76);
INSERT INTO estados VALUES (1434, 'Alsace', 77);
INSERT INTO estados VALUES (1435, 'Aquitaine', 77);
INSERT INTO estados VALUES (1436, 'Auvergne', 77);
INSERT INTO estados VALUES (1437, 'Basse-Normandie', 77);
INSERT INTO estados VALUES (1438, 'Bourgogne', 77);
INSERT INTO estados VALUES (1439, 'Bretagne', 77);
INSERT INTO estados VALUES (1440, 'Centre', 77);
INSERT INTO estados VALUES (1441, 'Champagne-Ardenne', 77);
INSERT INTO estados VALUES (1442, 'Corse', 77);
INSERT INTO estados VALUES (1443, 'Franche-Comte', 77);
INSERT INTO estados VALUES (1444, 'Haute-Normandie', 77);
INSERT INTO estados VALUES (1445, 'Ile-de-France', 77);
INSERT INTO estados VALUES (1446, 'Languedoc-Roussillon', 77);
INSERT INTO estados VALUES (1447, 'Limousin', 77);
INSERT INTO estados VALUES (1448, 'Lorraine', 77);
INSERT INTO estados VALUES (1449, 'Midi-Pyrenees', 77);
INSERT INTO estados VALUES (1450, 'Nord-Pas-de-Calais', 77);
INSERT INTO estados VALUES (1451, 'Pays de la Loire', 77);
INSERT INTO estados VALUES (1452, 'Picardie', 77);
INSERT INTO estados VALUES (1453, 'Poitou-Charentes', 77);
INSERT INTO estados VALUES (1454, 'Provence-Alpes-Cote d Azur', 77);
INSERT INTO estados VALUES (1455, 'Rhone-Alpes', 77);
INSERT INTO estados VALUES (1456, 'Guyane Departement', 78);
INSERT INTO estados VALUES (1457, 'Polynesie Fran?aise Territoire', 79);
INSERT INTO estados VALUES (1458, 'French Southern Territories (General)', 80);
INSERT INTO estados VALUES (1459, 'Estuaire', 81);
INSERT INTO estados VALUES (1460, 'Haut-Ogooue', 81);
INSERT INTO estados VALUES (1461, 'Moyen-Ogooue', 81);
INSERT INTO estados VALUES (1462, 'Ngounie', 81);
INSERT INTO estados VALUES (1463, 'Nyanga', 81);
INSERT INTO estados VALUES (1464, 'Ogooue-Ivindo', 81);
INSERT INTO estados VALUES (1465, 'Ogooue-Lolo', 81);
INSERT INTO estados VALUES (1466, 'Ogooue-Maritime', 81);
INSERT INTO estados VALUES (1467, 'Woleu-Ntem', 81);
INSERT INTO estados VALUES (1468, 'Banjul', 82);
INSERT INTO estados VALUES (1469, 'Lower River', 82);
INSERT INTO estados VALUES (1470, 'MacCarthy Island', 82);
INSERT INTO estados VALUES (1471, 'North Bank', 82);
INSERT INTO estados VALUES (1472, 'Upper River', 82);
INSERT INTO estados VALUES (1473, 'Western', 82);
INSERT INTO estados VALUES (1474, 'Abashis Raioni', 83);
INSERT INTO estados VALUES (1475, 'Abkhazia', 83);
INSERT INTO estados VALUES (1476, 'Adigenis Raioni', 83);
INSERT INTO estados VALUES (1477, 'Ajaria', 83);
INSERT INTO estados VALUES (1478, 'Akhalgoris Raioni', 83);
INSERT INTO estados VALUES (1479, 'Akhalk alakis Raioni', 83);
INSERT INTO estados VALUES (1480, 'Akhalts ikhis Raioni', 83);
INSERT INTO estados VALUES (1481, 'Akhmetis Raioni', 83);
INSERT INTO estados VALUES (1482, 'Ambrolauris Raioni', 83);
INSERT INTO estados VALUES (1483, 'Aspindzis Raioni', 83);
INSERT INTO estados VALUES (1484, 'Baghdat is Raioni', 83);
INSERT INTO estados VALUES (1485, 'Bolnisis Raioni', 83);
INSERT INTO estados VALUES (1486, 'Borjomis Raioni', 83);
INSERT INTO estados VALUES (1487, 'Ch khorotsqus Raioni', 83);
INSERT INTO estados VALUES (1488, 'Ch okhatauris Raioni', 83);
INSERT INTO estados VALUES (1489, 'Chiat ura', 83);
INSERT INTO estados VALUES (1490, 'Dedop listsqaros Raioni', 83);
INSERT INTO estados VALUES (1491, 'Dmanisis Raioni', 83);
INSERT INTO estados VALUES (1492, 'Dushet is Raioni', 83);
INSERT INTO estados VALUES (1493, 'Gardabanis Raioni', 83);
INSERT INTO estados VALUES (1494, 'Gori', 83);
INSERT INTO estados VALUES (1495, 'Goris Raioni', 83);
INSERT INTO estados VALUES (1496, 'Gurjaanis Raioni', 83);
INSERT INTO estados VALUES (1497, 'Javis Raioni', 83);
INSERT INTO estados VALUES (1498, 'K arelis Raioni', 83);
INSERT INTO estados VALUES (1499, 'K ut aisi', 83);
INSERT INTO estados VALUES (1500, 'Kaspis Raioni', 83);
INSERT INTO estados VALUES (1501, 'Kharagaulis Raioni', 83);
INSERT INTO estados VALUES (1502, 'Khashuris Raioni', 83);
INSERT INTO estados VALUES (1503, 'Khobis Raioni', 83);
INSERT INTO estados VALUES (1504, 'Khonis Raioni', 83);
INSERT INTO estados VALUES (1505, 'Lagodekhis Raioni', 83);
INSERT INTO estados VALUES (1506, 'Lanch khut is Raioni', 83);
INSERT INTO estados VALUES (1507, 'Lentekhis Raioni', 83);
INSERT INTO estados VALUES (1508, 'Marneulis Raioni', 83);
INSERT INTO estados VALUES (1509, 'Martvilis Raioni', 83);
INSERT INTO estados VALUES (1510, 'Mestiis Raioni', 83);
INSERT INTO estados VALUES (1511, 'Mts khet is Raioni', 83);
INSERT INTO estados VALUES (1512, 'Ninotsmindis Raioni', 83);
INSERT INTO estados VALUES (1513, 'Onis Raioni', 83);
INSERT INTO estados VALUES (1514, 'Ozurget is Raioni', 83);
INSERT INTO estados VALUES (1515, 'P ot i', 83);
INSERT INTO estados VALUES (1516, 'Qazbegis Raioni', 83);
INSERT INTO estados VALUES (1517, 'Qvarlis Raioni', 83);
INSERT INTO estados VALUES (1518, 'Rust avi', 83);
INSERT INTO estados VALUES (1519, 'Sach kheris Raioni', 83);
INSERT INTO estados VALUES (1520, 'Sagarejos Raioni', 83);
INSERT INTO estados VALUES (1521, 'Samtrediis Raioni', 83);
INSERT INTO estados VALUES (1522, 'Senakis Raioni', 83);
INSERT INTO estados VALUES (1523, 'Sighnaghis Raioni', 83);
INSERT INTO estados VALUES (1524, 'T bilisi', 83);
INSERT INTO estados VALUES (1525, 'T elavis Raioni', 83);
INSERT INTO estados VALUES (1526, 'T erjolis Raioni', 83);
INSERT INTO estados VALUES (1527, 'T et ritsqaros Raioni', 83);
INSERT INTO estados VALUES (1528, 'T ianet is Raioni', 83);
INSERT INTO estados VALUES (1529, 'Tqibuli', 83);
INSERT INTO estados VALUES (1530, 'Ts ageris Raioni', 83);
INSERT INTO estados VALUES (1531, 'Tsalenjikhis Raioni', 83);
INSERT INTO estados VALUES (1532, 'Tsalkis Raioni', 83);
INSERT INTO estados VALUES (1533, 'Tsqaltubo', 83);
INSERT INTO estados VALUES (1534, 'Vanis Raioni', 83);
INSERT INTO estados VALUES (1535, 'Zestap onis Raioni', 83);
INSERT INTO estados VALUES (1536, 'Zugdidi', 83);
INSERT INTO estados VALUES (1537, 'Zugdidis Raioni', 83);
INSERT INTO estados VALUES (1538, 'Ashanti', 84);
INSERT INTO estados VALUES (1539, 'Brong-Ahafo', 84);
INSERT INTO estados VALUES (1540, 'Central', 84);
INSERT INTO estados VALUES (1541, 'Eastern', 84);
INSERT INTO estados VALUES (1542, 'Greater Accra', 84);
INSERT INTO estados VALUES (1543, 'Northern', 84);
INSERT INTO estados VALUES (1544, 'Upper East', 84);
INSERT INTO estados VALUES (1545, 'Upper West', 84);
INSERT INTO estados VALUES (1546, 'Volta', 84);
INSERT INTO estados VALUES (1547, 'Western', 84);
INSERT INTO estados VALUES (1548, 'Gibraltar (General)', 85);
INSERT INTO estados VALUES (1549, 'Saint Andrew', 86);
INSERT INTO estados VALUES (1550, 'Saint David', 86);
INSERT INTO estados VALUES (1551, 'Saint George', 86);
INSERT INTO estados VALUES (1552, 'Saint John', 86);
INSERT INTO estados VALUES (1553, 'Saint Mark', 86);
INSERT INTO estados VALUES (1554, 'Saint Patrick', 86);
INSERT INTO estados VALUES (1555, 'Aitolia kai Akarnania', 87);
INSERT INTO estados VALUES (1556, 'Akhaia', 87);
INSERT INTO estados VALUES (1557, 'Argolis', 87);
INSERT INTO estados VALUES (1558, 'Arkadhia', 87);
INSERT INTO estados VALUES (1559, 'Arta', 87);
INSERT INTO estados VALUES (1560, 'Attiki', 87);
INSERT INTO estados VALUES (1561, 'Dhodhekanisos', 87);
INSERT INTO estados VALUES (1562, 'Drama', 87);
INSERT INTO estados VALUES (1563, 'Evritania', 87);
INSERT INTO estados VALUES (1564, 'Evros', 87);
INSERT INTO estados VALUES (1565, 'Evvoia', 87);
INSERT INTO estados VALUES (1566, 'Florina', 87);
INSERT INTO estados VALUES (1567, 'Fokis', 87);
INSERT INTO estados VALUES (1568, 'Fthiotis', 87);
INSERT INTO estados VALUES (1569, 'Grevena', 87);
INSERT INTO estados VALUES (1570, 'Ilia', 87);
INSERT INTO estados VALUES (1571, 'Imathia', 87);
INSERT INTO estados VALUES (1572, 'Ioannina', 87);
INSERT INTO estados VALUES (1573, 'Iraklion', 87);
INSERT INTO estados VALUES (1574, 'Kardhitsa', 87);
INSERT INTO estados VALUES (1575, 'Kastoria', 87);
INSERT INTO estados VALUES (1576, 'Kavala', 87);
INSERT INTO estados VALUES (1577, 'Kefallinia', 87);
INSERT INTO estados VALUES (1578, 'Kerkira', 87);
INSERT INTO estados VALUES (1579, 'Khalkidhiki', 87);
INSERT INTO estados VALUES (1580, 'Khania', 87);
INSERT INTO estados VALUES (1581, 'Khios', 87);
INSERT INTO estados VALUES (1582, 'Kikladhes', 87);
INSERT INTO estados VALUES (1583, 'Kilkis', 87);
INSERT INTO estados VALUES (1584, 'Korinthia', 87);
INSERT INTO estados VALUES (1585, 'Kozani', 87);
INSERT INTO estados VALUES (1586, 'Lakonia', 87);
INSERT INTO estados VALUES (1587, 'Larisa', 87);
INSERT INTO estados VALUES (1588, 'Lasithi', 87);
INSERT INTO estados VALUES (1589, 'Lesvos', 87);
INSERT INTO estados VALUES (1590, 'Levkas', 87);
INSERT INTO estados VALUES (1591, 'Magnisia', 87);
INSERT INTO estados VALUES (1592, 'Messinia', 87);
INSERT INTO estados VALUES (1593, 'Pella', 87);
INSERT INTO estados VALUES (1594, 'Pieria', 87);
INSERT INTO estados VALUES (1595, 'Preveza', 87);
INSERT INTO estados VALUES (1596, 'Rethimni', 87);
INSERT INTO estados VALUES (1597, 'Rodhopi', 87);
INSERT INTO estados VALUES (1598, 'Samos', 87);
INSERT INTO estados VALUES (1599, 'Serrai', 87);
INSERT INTO estados VALUES (1600, 'Thesprotia', 87);
INSERT INTO estados VALUES (1601, 'Thessaloniki', 87);
INSERT INTO estados VALUES (1602, 'Trikala', 87);
INSERT INTO estados VALUES (1603, 'Voiotia', 87);
INSERT INTO estados VALUES (1604, 'Xanthi', 87);
INSERT INTO estados VALUES (1605, 'Zakinthos', 87);
INSERT INTO estados VALUES (1606, 'Nordgronland', 88);
INSERT INTO estados VALUES (1607, 'Ostgronland', 88);
INSERT INTO estados VALUES (1608, 'Vestgronland', 88);
INSERT INTO estados VALUES (1609, 'Guadeloupe Departement', 89);
INSERT INTO estados VALUES (1610, 'Guam (General)', 90);
INSERT INTO estados VALUES (1611, 'Alta Verapaz', 91);
INSERT INTO estados VALUES (1612, 'Baja Verapaz', 91);
INSERT INTO estados VALUES (1613, 'Chimaltenango', 91);
INSERT INTO estados VALUES (1614, 'Chiquimula', 91);
INSERT INTO estados VALUES (1615, 'El Progreso', 91);
INSERT INTO estados VALUES (1616, 'Escuintla', 91);
INSERT INTO estados VALUES (1617, 'Guatemala', 91);
INSERT INTO estados VALUES (1618, 'Huehuetenango', 91);
INSERT INTO estados VALUES (1619, 'Izabal', 91);
INSERT INTO estados VALUES (1620, 'Jalapa', 91);
INSERT INTO estados VALUES (1621, 'Jutiapa', 91);
INSERT INTO estados VALUES (1622, 'Peten', 91);
INSERT INTO estados VALUES (1623, 'Quetzaltenango', 91);
INSERT INTO estados VALUES (1624, 'Quiche', 91);
INSERT INTO estados VALUES (1625, 'Retalhuleu', 91);
INSERT INTO estados VALUES (1626, 'Sacatepequez', 91);
INSERT INTO estados VALUES (1627, 'San Marcos', 91);
INSERT INTO estados VALUES (1628, 'Santa Rosa', 91);
INSERT INTO estados VALUES (1629, 'Solola', 91);
INSERT INTO estados VALUES (1630, 'Suchitepequez', 91);
INSERT INTO estados VALUES (1631, 'Totonicapan', 91);
INSERT INTO estados VALUES (1632, 'Zacapa', 91);
INSERT INTO estados VALUES (1633, 'Beyla', 92);
INSERT INTO estados VALUES (1634, 'Boffa', 92);
INSERT INTO estados VALUES (1635, 'Boke', 92);
INSERT INTO estados VALUES (1636, 'Conakry', 92);
INSERT INTO estados VALUES (1637, 'Coyah', 92);
INSERT INTO estados VALUES (1638, 'Dabola', 92);
INSERT INTO estados VALUES (1639, 'Dalaba', 92);
INSERT INTO estados VALUES (1640, 'Dinguiraye', 92);
INSERT INTO estados VALUES (1641, 'Dubreka', 92);
INSERT INTO estados VALUES (1642, 'Faranah', 92);
INSERT INTO estados VALUES (1643, 'Forecariah', 92);
INSERT INTO estados VALUES (1644, 'Fria', 92);
INSERT INTO estados VALUES (1645, 'Gaoual', 92);
INSERT INTO estados VALUES (1646, 'Gueckedou', 92);
INSERT INTO estados VALUES (1647, 'Kankan', 92);
INSERT INTO estados VALUES (1648, 'Kerouane', 92);
INSERT INTO estados VALUES (1649, 'Kindia', 92);
INSERT INTO estados VALUES (1650, 'Kissidougou', 92);
INSERT INTO estados VALUES (1651, 'Koubia', 92);
INSERT INTO estados VALUES (1652, 'Koundara', 92);
INSERT INTO estados VALUES (1653, 'Kouroussa', 92);
INSERT INTO estados VALUES (1654, 'Labe', 92);
INSERT INTO estados VALUES (1655, 'Lelouma', 92);
INSERT INTO estados VALUES (1656, 'Lola', 92);
INSERT INTO estados VALUES (1657, 'Macenta', 92);
INSERT INTO estados VALUES (1658, 'Mali', 92);
INSERT INTO estados VALUES (1659, 'Mamou', 92);
INSERT INTO estados VALUES (1660, 'Mandiana', 92);
INSERT INTO estados VALUES (1661, 'Nzerekore', 92);
INSERT INTO estados VALUES (1662, 'Pita', 92);
INSERT INTO estados VALUES (1663, 'Siguiri', 92);
INSERT INTO estados VALUES (1664, 'Telimele', 92);
INSERT INTO estados VALUES (1665, 'Tougue', 92);
INSERT INTO estados VALUES (1666, 'Yomou', 92);
INSERT INTO estados VALUES (1667, 'Annobon', 93);
INSERT INTO estados VALUES (1668, 'Bioko Norte', 93);
INSERT INTO estados VALUES (1669, 'Bioko Sur', 93);
INSERT INTO estados VALUES (1670, 'Centro Sur', 93);
INSERT INTO estados VALUES (1671, 'Kie-Ntem', 93);
INSERT INTO estados VALUES (1672, 'Litoral', 93);
INSERT INTO estados VALUES (1673, 'Wele-Nzas', 93);
INSERT INTO estados VALUES (1674, 'Bafata', 94);
INSERT INTO estados VALUES (1675, 'Biombo', 94);
INSERT INTO estados VALUES (1676, 'Bissau', 94);
INSERT INTO estados VALUES (1677, 'Bolama', 94);
INSERT INTO estados VALUES (1678, 'Cacheu', 94);
INSERT INTO estados VALUES (1679, 'Gabu', 94);
INSERT INTO estados VALUES (1680, 'Oio', 94);
INSERT INTO estados VALUES (1681, 'Quinara', 94);
INSERT INTO estados VALUES (1682, 'Tombali', 94);
INSERT INTO estados VALUES (1683, 'Barima-Waini', 95);
INSERT INTO estados VALUES (1684, 'Cuyuni-Mazaruni', 95);
INSERT INTO estados VALUES (1685, 'Demerara-Mahaica', 95);
INSERT INTO estados VALUES (1686, 'East Berbice-Corentyne', 95);
INSERT INTO estados VALUES (1687, 'Essequibo Islands-West Demerara', 95);
INSERT INTO estados VALUES (1688, 'Mahaica-Berbice', 95);
INSERT INTO estados VALUES (1689, 'Pomeroon-Supenaam', 95);
INSERT INTO estados VALUES (1690, 'Potaro-Siparuni', 95);
INSERT INTO estados VALUES (1691, 'Upper Demerara-Berbice', 95);
INSERT INTO estados VALUES (1692, 'Upper Takutu-Upper Essequibo', 95);
INSERT INTO estados VALUES (1693, 'Artibonite', 96);
INSERT INTO estados VALUES (1694, 'Centre', 96);
INSERT INTO estados VALUES (1695, 'Grand Anse', 96);
INSERT INTO estados VALUES (1696, 'Nord', 96);
INSERT INTO estados VALUES (1697, 'Nord-Est', 96);
INSERT INTO estados VALUES (1698, 'Nord-Ouest', 96);
INSERT INTO estados VALUES (1699, 'Ouest', 96);
INSERT INTO estados VALUES (1700, 'Sud', 96);
INSERT INTO estados VALUES (1701, 'Sud-Est', 96);
INSERT INTO estados VALUES (1840, 'Sumatera Barat', 103);
INSERT INTO estados VALUES (1702, 'Heard Island and McDonald Islands (General)', 97);
INSERT INTO estados VALUES (1703, 'Drenthe', 98);
INSERT INTO estados VALUES (1704, 'Dronten', 98);
INSERT INTO estados VALUES (1705, 'Flevoland', 98);
INSERT INTO estados VALUES (1706, 'Friesland', 98);
INSERT INTO estados VALUES (1707, 'Gelderland', 98);
INSERT INTO estados VALUES (1708, 'Groningen', 98);
INSERT INTO estados VALUES (1709, 'Lelystad', 98);
INSERT INTO estados VALUES (1710, 'Limburg', 98);
INSERT INTO estados VALUES (1711, 'Noord-Brabant', 98);
INSERT INTO estados VALUES (1712, 'Noord-Holland', 98);
INSERT INTO estados VALUES (1713, 'Overijssel', 98);
INSERT INTO estados VALUES (1714, 'Overijssel', 98);
INSERT INTO estados VALUES (1715, 'Utrecht', 98);
INSERT INTO estados VALUES (1716, 'Zeeland', 98);
INSERT INTO estados VALUES (1717, 'Zuid-Holland', 98);
INSERT INTO estados VALUES (1718, 'Zuidelijke IJsselmeerpolders', 98);
INSERT INTO estados VALUES (1719, 'Atlantida', 99);
INSERT INTO estados VALUES (1720, 'Choluteca', 99);
INSERT INTO estados VALUES (1721, 'Colon', 99);
INSERT INTO estados VALUES (1722, 'Comayagua', 99);
INSERT INTO estados VALUES (1723, 'Copan', 99);
INSERT INTO estados VALUES (1724, 'Cortes', 99);
INSERT INTO estados VALUES (1725, 'El Paraiso', 99);
INSERT INTO estados VALUES (1726, 'Francisco Morazan', 99);
INSERT INTO estados VALUES (1727, 'Gracias a Dios', 99);
INSERT INTO estados VALUES (1728, 'Intibuca', 99);
INSERT INTO estados VALUES (1729, 'Islas de la Bahia', 99);
INSERT INTO estados VALUES (1730, 'La Paz', 99);
INSERT INTO estados VALUES (1731, 'Lempira', 99);
INSERT INTO estados VALUES (1732, 'Ocotepeque', 99);
INSERT INTO estados VALUES (1733, 'Olancho', 99);
INSERT INTO estados VALUES (1734, 'Santa Barbara', 99);
INSERT INTO estados VALUES (1735, 'Valle', 99);
INSERT INTO estados VALUES (1736, 'Yoro', 99);
INSERT INTO estados VALUES (1737, 'Hong Kong (General)', 100);
INSERT INTO estados VALUES (1738, 'Bacs-Kiskun', 101);
INSERT INTO estados VALUES (1739, 'Baranya', 101);
INSERT INTO estados VALUES (1740, 'Bekes', 101);
INSERT INTO estados VALUES (1741, 'Bekescsaba', 101);
INSERT INTO estados VALUES (1742, 'Borsod-Abauj-Zemplen', 101);
INSERT INTO estados VALUES (1743, 'Budapest', 101);
INSERT INTO estados VALUES (1744, 'Csongrad', 101);
INSERT INTO estados VALUES (1745, 'Debrecen', 101);
INSERT INTO estados VALUES (1746, 'Dunaujvaros', 101);
INSERT INTO estados VALUES (1747, 'Eger', 101);
INSERT INTO estados VALUES (1748, 'Fejer', 101);
INSERT INTO estados VALUES (1749, 'Gyor', 101);
INSERT INTO estados VALUES (1750, 'Gyor-Moson-Sopron', 101);
INSERT INTO estados VALUES (1751, 'Hajdu-Bihar', 101);
INSERT INTO estados VALUES (1752, 'Heves', 101);
INSERT INTO estados VALUES (1753, 'Hodmezovasarhely', 101);
INSERT INTO estados VALUES (1754, 'Jasz-Nagykun-Szolnok', 101);
INSERT INTO estados VALUES (1755, 'Kaposvar', 101);
INSERT INTO estados VALUES (1756, 'Kecskemet', 101);
INSERT INTO estados VALUES (1757, 'Komarom-Esztergom', 101);
INSERT INTO estados VALUES (1758, 'Miskolc', 101);
INSERT INTO estados VALUES (1759, 'Nagykanizsa', 101);
INSERT INTO estados VALUES (1760, 'Nograd', 101);
INSERT INTO estados VALUES (1761, 'Nyiregyhaza', 101);
INSERT INTO estados VALUES (1762, 'Pecs', 101);
INSERT INTO estados VALUES (1763, 'Pest', 101);
INSERT INTO estados VALUES (1764, 'Somogy', 101);
INSERT INTO estados VALUES (1765, 'Sopron', 101);
INSERT INTO estados VALUES (1766, 'Szabolcs-Szatmar-Bereg', 101);
INSERT INTO estados VALUES (1767, 'Szeged', 101);
INSERT INTO estados VALUES (1768, 'Szekesfehervar', 101);
INSERT INTO estados VALUES (1769, 'Szolnok', 101);
INSERT INTO estados VALUES (1770, 'Szombathely', 101);
INSERT INTO estados VALUES (1771, 'Tatabanya', 101);
INSERT INTO estados VALUES (1772, 'Tolna', 101);
INSERT INTO estados VALUES (1773, 'Vas', 101);
INSERT INTO estados VALUES (1774, 'Veszprem', 101);
INSERT INTO estados VALUES (1775, 'Veszprem', 101);
INSERT INTO estados VALUES (1776, 'Zala', 101);
INSERT INTO estados VALUES (1777, 'Zalaegerszeg', 101);
INSERT INTO estados VALUES (1778, 'Andaman and Nicobar Islands', 102);
INSERT INTO estados VALUES (1779, 'Andhra Pradesh', 102);
INSERT INTO estados VALUES (1780, 'Arunachal Pradesh', 102);
INSERT INTO estados VALUES (1781, 'Assam', 102);
INSERT INTO estados VALUES (1782, 'Bihar', 102);
INSERT INTO estados VALUES (1783, 'Chandigarh', 102);
INSERT INTO estados VALUES (1784, 'Chhattisgarh', 102);
INSERT INTO estados VALUES (1785, 'Dadra and Nagar Haveli', 102);
INSERT INTO estados VALUES (1786, 'Daman and Diu', 102);
INSERT INTO estados VALUES (1787, 'Delhi', 102);
INSERT INTO estados VALUES (1788, 'Goa', 102);
INSERT INTO estados VALUES (1789, 'Gujarat', 102);
INSERT INTO estados VALUES (1790, 'Haryana', 102);
INSERT INTO estados VALUES (1791, 'Himachal Pradesh', 102);
INSERT INTO estados VALUES (1792, 'Jammu and Kashmir', 102);
INSERT INTO estados VALUES (1793, 'Jharkhand', 102);
INSERT INTO estados VALUES (1794, 'Karnataka', 102);
INSERT INTO estados VALUES (1795, 'Kerala', 102);
INSERT INTO estados VALUES (1796, 'Lakshadweep', 102);
INSERT INTO estados VALUES (1797, 'Madhya Pradesh', 102);
INSERT INTO estados VALUES (1798, 'Maharashtra', 102);
INSERT INTO estados VALUES (1799, 'Manipur', 102);
INSERT INTO estados VALUES (1800, 'Meghalaya', 102);
INSERT INTO estados VALUES (1801, 'Mizoram', 102);
INSERT INTO estados VALUES (1802, 'Nagaland', 102);
INSERT INTO estados VALUES (1803, 'Orissa', 102);
INSERT INTO estados VALUES (1804, 'Pondicherry', 102);
INSERT INTO estados VALUES (1805, 'Punjab', 102);
INSERT INTO estados VALUES (1806, 'Rajasthan', 102);
INSERT INTO estados VALUES (1807, 'Sikkim', 102);
INSERT INTO estados VALUES (1808, 'Tamil Nadu', 102);
INSERT INTO estados VALUES (1809, 'Tripura', 102);
INSERT INTO estados VALUES (1810, 'Uttar Pradesh', 102);
INSERT INTO estados VALUES (1811, 'Uttaranchal', 102);
INSERT INTO estados VALUES (1812, 'West Bengal', 102);
INSERT INTO estados VALUES (1813, 'Aceh', 103);
INSERT INTO estados VALUES (1814, 'Bali', 103);
INSERT INTO estados VALUES (1815, 'Banten', 103);
INSERT INTO estados VALUES (1816, 'Bengkulu', 103);
INSERT INTO estados VALUES (1817, 'Gorontalo', 103);
INSERT INTO estados VALUES (1818, 'Jakarta Raya', 103);
INSERT INTO estados VALUES (1819, 'Jambi', 103);
INSERT INTO estados VALUES (1820, 'Jawa Barat', 103);
INSERT INTO estados VALUES (1821, 'Jawa Tengah', 103);
INSERT INTO estados VALUES (1822, 'Jawa Timur', 103);
INSERT INTO estados VALUES (1823, 'Kalimantan Barat', 103);
INSERT INTO estados VALUES (1824, 'Kalimantan Selatan', 103);
INSERT INTO estados VALUES (1825, 'Kalimantan Tengah', 103);
INSERT INTO estados VALUES (1826, 'Kalimantan Timur', 103);
INSERT INTO estados VALUES (1827, 'Kepulauan Bangka Belitung', 103);
INSERT INTO estados VALUES (1828, 'Lampung', 103);
INSERT INTO estados VALUES (1829, 'Maluku', 103);
INSERT INTO estados VALUES (1830, 'Maluku Province', 103);
INSERT INTO estados VALUES (1831, 'Maluku Utara', 103);
INSERT INTO estados VALUES (1832, 'Nusa Tenggara Barat', 103);
INSERT INTO estados VALUES (1833, 'Nusa Tenggara Timur', 103);
INSERT INTO estados VALUES (1834, 'Papua', 103);
INSERT INTO estados VALUES (1835, 'Riau', 103);
INSERT INTO estados VALUES (1836, 'Sulawesi Selatan', 103);
INSERT INTO estados VALUES (1837, 'Sulawesi Tengah', 103);
INSERT INTO estados VALUES (1838, 'Sulawesi Tenggara', 103);
INSERT INTO estados VALUES (1839, 'Sulawesi Utara', 103);
INSERT INTO estados VALUES (1841, 'Sumatera Selatan', 103);
INSERT INTO estados VALUES (1842, 'Sumatera Utara', 103);
INSERT INTO estados VALUES (1843, 'Yogyakarta', 103);
INSERT INTO estados VALUES (1844, 'Al Anbar', 104);
INSERT INTO estados VALUES (1845, 'Al Basrah', 104);
INSERT INTO estados VALUES (1846, 'Al Muthanna', 104);
INSERT INTO estados VALUES (1847, 'Al Qadisiyah', 104);
INSERT INTO estados VALUES (1848, 'An Najaf', 104);
INSERT INTO estados VALUES (1849, 'Arbil', 104);
INSERT INTO estados VALUES (1850, 'As Sulaymaniyah', 104);
INSERT INTO estados VALUES (1851, 'At Tamim', 104);
INSERT INTO estados VALUES (1852, 'Babil', 104);
INSERT INTO estados VALUES (1853, 'Baghdad', 104);
INSERT INTO estados VALUES (1854, 'Dahuk', 104);
INSERT INTO estados VALUES (1855, 'Dhi Qar', 104);
INSERT INTO estados VALUES (1856, 'Diyala', 104);
INSERT INTO estados VALUES (1857, 'Karbala', 104);
INSERT INTO estados VALUES (1858, 'Maysan', 104);
INSERT INTO estados VALUES (1859, 'Ninawa', 104);
INSERT INTO estados VALUES (1860, 'Salah ad Din', 104);
INSERT INTO estados VALUES (1861, 'Wasit', 104);
INSERT INTO estados VALUES (1862, 'Carlow', 105);
INSERT INTO estados VALUES (1863, 'Cavan', 105);
INSERT INTO estados VALUES (1864, 'Clare', 105);
INSERT INTO estados VALUES (1865, 'Cork', 105);
INSERT INTO estados VALUES (1866, 'Donegal', 105);
INSERT INTO estados VALUES (1867, 'Dublin', 105);
INSERT INTO estados VALUES (1868, 'Galway', 105);
INSERT INTO estados VALUES (1869, 'Kerry', 105);
INSERT INTO estados VALUES (1870, 'Kildare', 105);
INSERT INTO estados VALUES (1871, 'Kilkenny', 105);
INSERT INTO estados VALUES (1872, 'Laois', 105);
INSERT INTO estados VALUES (1873, 'Leitrim', 105);
INSERT INTO estados VALUES (1874, 'Limerick', 105);
INSERT INTO estados VALUES (1875, 'Longford', 105);
INSERT INTO estados VALUES (1876, 'Louth', 105);
INSERT INTO estados VALUES (1877, 'Mayo', 105);
INSERT INTO estados VALUES (1878, 'Meath', 105);
INSERT INTO estados VALUES (1879, 'Monaghan', 105);
INSERT INTO estados VALUES (1880, 'Offaly', 105);
INSERT INTO estados VALUES (1881, 'Roscommon', 105);
INSERT INTO estados VALUES (1882, 'Sligo', 105);
INSERT INTO estados VALUES (1883, 'Tipperary', 105);
INSERT INTO estados VALUES (1884, 'Waterford', 105);
INSERT INTO estados VALUES (1885, 'Westmeath', 105);
INSERT INTO estados VALUES (1886, 'Wexford', 105);
INSERT INTO estados VALUES (1887, 'Wicklow', 105);
INSERT INTO estados VALUES (1888, 'Cocos (Keeling) Islands (General)', 106);
INSERT INTO estados VALUES (1889, 'Christmas Island (General)', 107);
INSERT INTO estados VALUES (1890, 'Akranes', 108);
INSERT INTO estados VALUES (1891, 'Akureyri', 108);
INSERT INTO estados VALUES (1892, 'Arnessysla', 108);
INSERT INTO estados VALUES (1893, 'Austur-Bardastrandarsysla', 108);
INSERT INTO estados VALUES (1894, 'Austur-Hunavatnssysla', 108);
INSERT INTO estados VALUES (1895, 'Austur-Skaftafellssysla', 108);
INSERT INTO estados VALUES (1896, 'Borgarfjardarsysla', 108);
INSERT INTO estados VALUES (1897, 'Dalasysla', 108);
INSERT INTO estados VALUES (1898, 'Eyjafjardarsysla', 108);
INSERT INTO estados VALUES (1899, 'Gullbringusysla', 108);
INSERT INTO estados VALUES (1900, 'Hafnarfjordur', 108);
INSERT INTO estados VALUES (1901, 'Husavik', 108);
INSERT INTO estados VALUES (1902, 'Isafjordur', 108);
INSERT INTO estados VALUES (1903, 'Keflavik', 108);
INSERT INTO estados VALUES (1904, 'Kjosarsysla', 108);
INSERT INTO estados VALUES (1905, 'Kopavogur', 108);
INSERT INTO estados VALUES (1906, 'Myrasysla', 108);
INSERT INTO estados VALUES (1907, 'Neskaupstadur', 108);
INSERT INTO estados VALUES (1908, 'Nordur-Isafjardarsysla', 108);
INSERT INTO estados VALUES (1909, 'Nordur-Mulasysla', 108);
INSERT INTO estados VALUES (1910, 'Nordur-Tingeyjarsysla', 108);
INSERT INTO estados VALUES (1911, 'Olafsfjordur', 108);
INSERT INTO estados VALUES (1912, 'Rangarvallasysla', 108);
INSERT INTO estados VALUES (1913, 'Reykjavik', 108);
INSERT INTO estados VALUES (1914, 'Saudarkrokur', 108);
INSERT INTO estados VALUES (1915, 'Seydisfjordur', 108);
INSERT INTO estados VALUES (1916, 'Siglufjordur', 108);
INSERT INTO estados VALUES (1917, 'Skagafjardarsysla', 108);
INSERT INTO estados VALUES (1918, 'Snafellsnes- og Hnappadalssysla', 108);
INSERT INTO estados VALUES (1919, 'Strandasysla', 108);
INSERT INTO estados VALUES (1920, 'Sudur-Mulasysla', 108);
INSERT INTO estados VALUES (1921, 'Sudur-Tingeyjarsysla', 108);
INSERT INTO estados VALUES (1922, 'Vestmannaeyjar', 108);
INSERT INTO estados VALUES (1923, 'Vestur-Bardastrandarsysla', 108);
INSERT INTO estados VALUES (1924, 'Vestur-Hunavatnssysla', 108);
INSERT INTO estados VALUES (1925, 'Vestur-Isafjardarsysla', 108);
INSERT INTO estados VALUES (1926, 'Vestur-Skaftafellssysla', 108);
INSERT INTO estados VALUES (1927, 'Creek', 109);
INSERT INTO estados VALUES (1928, 'Eastern', 109);
INSERT INTO estados VALUES (1929, 'Midland', 109);
INSERT INTO estados VALUES (1930, 'South Town', 109);
INSERT INTO estados VALUES (1931, 'Spot Bay', 109);
INSERT INTO estados VALUES (1932, 'Stake Bay', 109);
INSERT INTO estados VALUES (1933, 'West End', 109);
INSERT INTO estados VALUES (1934, 'Western', 109);
INSERT INTO estados VALUES (1935, 'Cook Islands (General)', 110);
INSERT INTO estados VALUES (1936, 'F?r?erne', 111);
INSERT INTO estados VALUES (1937, 'Falkland Islands (Malvinas) (General)', 112);
INSERT INTO estados VALUES (1938, 'Marshall Islands (General)', 113);
INSERT INTO estados VALUES (1939, 'Agalega Islands', 114);
INSERT INTO estados VALUES (1940, 'Black River', 114);
INSERT INTO estados VALUES (1941, 'Cargados Carajos', 114);
INSERT INTO estados VALUES (1942, 'Flacq', 114);
INSERT INTO estados VALUES (1943, 'Grand Port', 114);
INSERT INTO estados VALUES (1944, 'Moka', 114);
INSERT INTO estados VALUES (1945, 'Pamplemousses', 114);
INSERT INTO estados VALUES (1946, 'Plaines Wilhems', 114);
INSERT INTO estados VALUES (1947, 'Port Louis', 114);
INSERT INTO estados VALUES (1948, 'Riviere du Rempart', 114);
INSERT INTO estados VALUES (1949, 'Rodrigues', 114);
INSERT INTO estados VALUES (1950, 'Savanne', 114);
INSERT INTO estados VALUES (1951, 'Central', 115);
INSERT INTO estados VALUES (1952, 'Guadalcanal', 115);
INSERT INTO estados VALUES (1953, 'Isabel', 115);
INSERT INTO estados VALUES (1954, 'Makira', 115);
INSERT INTO estados VALUES (1955, 'Malaita', 115);
INSERT INTO estados VALUES (1956, 'Temotu', 115);
INSERT INTO estados VALUES (1957, 'Western', 115);
INSERT INTO estados VALUES (1958, 'South Georgia and the South Sandwich Islands (Gene', 116);
INSERT INTO estados VALUES (1959, 'Turks and Caicos Islands (General)', 117);
INSERT INTO estados VALUES (1960, 'Wallis and Futuna (General)', 118);
INSERT INTO estados VALUES (1961, 'HaDarom', 119);
INSERT INTO estados VALUES (1962, 'HaMerkaz', 119);
INSERT INTO estados VALUES (1963, 'HaZafon', 119);
INSERT INTO estados VALUES (1964, 'Hefa', 119);
INSERT INTO estados VALUES (1965, 'Tel Aviv', 119);
INSERT INTO estados VALUES (1966, 'Yerushalayim', 119);
INSERT INTO estados VALUES (1967, 'Abruzzi', 120);
INSERT INTO estados VALUES (1968, 'Basilicata', 120);
INSERT INTO estados VALUES (1969, 'Calabria', 120);
INSERT INTO estados VALUES (1970, 'Campania', 120);
INSERT INTO estados VALUES (1971, 'Emilia-Romagna', 120);
INSERT INTO estados VALUES (1972, 'Friuli-Venezia Giulia', 120);
INSERT INTO estados VALUES (1973, 'Italy (General)', 120);
INSERT INTO estados VALUES (1974, 'Lazio', 120);
INSERT INTO estados VALUES (1975, 'Liguria', 120);
INSERT INTO estados VALUES (1976, 'Lombardia', 120);
INSERT INTO estados VALUES (1977, 'Marche', 120);
INSERT INTO estados VALUES (1978, 'Molise', 120);
INSERT INTO estados VALUES (1979, 'Piemonte', 120);
INSERT INTO estados VALUES (1980, 'Puglia', 120);
INSERT INTO estados VALUES (1981, 'Sardegna', 120);
INSERT INTO estados VALUES (1982, 'Sicilia', 120);
INSERT INTO estados VALUES (1983, 'Toscana', 120);
INSERT INTO estados VALUES (1984, 'Trentino-Alto Adige', 120);
INSERT INTO estados VALUES (1985, 'Umbria', 120);
INSERT INTO estados VALUES (1986, 'Valle d Aosta', 120);
INSERT INTO estados VALUES (1987, 'Veneto', 120);
INSERT INTO estados VALUES (1988, 'Clarendon', 121);
INSERT INTO estados VALUES (1989, 'Hanover', 121);
INSERT INTO estados VALUES (1990, 'Kingston', 121);
INSERT INTO estados VALUES (1991, 'Manchester', 121);
INSERT INTO estados VALUES (1992, 'Portland', 121);
INSERT INTO estados VALUES (1993, 'Saint Andrew', 121);
INSERT INTO estados VALUES (1994, 'Saint Ann', 121);
INSERT INTO estados VALUES (1995, 'Saint Catherine', 121);
INSERT INTO estados VALUES (1996, 'Saint Elizabeth', 121);
INSERT INTO estados VALUES (1997, 'Saint James', 121);
INSERT INTO estados VALUES (1998, 'Saint Mary', 121);
INSERT INTO estados VALUES (1999, 'Saint Thomas', 121);
INSERT INTO estados VALUES (2000, 'Trelawny', 121);
INSERT INTO estados VALUES (2001, 'Westmoreland', 121);
INSERT INTO estados VALUES (2002, 'Aichi', 122);
INSERT INTO estados VALUES (2003, 'Akita', 122);
INSERT INTO estados VALUES (2004, 'Aomori', 122);
INSERT INTO estados VALUES (2005, 'Chiba', 122);
INSERT INTO estados VALUES (2006, 'Ehime', 122);
INSERT INTO estados VALUES (2007, 'Fukui', 122);
INSERT INTO estados VALUES (2008, 'Fukuoka', 122);
INSERT INTO estados VALUES (2009, 'Fukushima', 122);
INSERT INTO estados VALUES (2010, 'Gifu', 122);
INSERT INTO estados VALUES (2011, 'Gumma', 122);
INSERT INTO estados VALUES (2012, 'Hiroshima', 122);
INSERT INTO estados VALUES (2013, 'Hokkaido', 122);
INSERT INTO estados VALUES (2014, 'Hyogo', 122);
INSERT INTO estados VALUES (2015, 'Ibaraki', 122);
INSERT INTO estados VALUES (2016, 'Ishikawa', 122);
INSERT INTO estados VALUES (2017, 'Iwate', 122);
INSERT INTO estados VALUES (2018, 'Kagawa', 122);
INSERT INTO estados VALUES (2019, 'Kagoshima', 122);
INSERT INTO estados VALUES (2020, 'Kanagawa', 122);
INSERT INTO estados VALUES (2021, 'Kochi', 122);
INSERT INTO estados VALUES (2022, 'Kumamoto', 122);
INSERT INTO estados VALUES (2023, 'Kyoto', 122);
INSERT INTO estados VALUES (2024, 'Mie', 122);
INSERT INTO estados VALUES (2025, 'Miyagi', 122);
INSERT INTO estados VALUES (2026, 'Miyazaki', 122);
INSERT INTO estados VALUES (2027, 'Nagano', 122);
INSERT INTO estados VALUES (2028, 'Nagasaki', 122);
INSERT INTO estados VALUES (2029, 'Nara', 122);
INSERT INTO estados VALUES (2030, 'Niigata', 122);
INSERT INTO estados VALUES (2031, 'Oita', 122);
INSERT INTO estados VALUES (2032, 'Okayama', 122);
INSERT INTO estados VALUES (2033, 'Okinawa', 122);
INSERT INTO estados VALUES (2034, 'Osaka', 122);
INSERT INTO estados VALUES (2035, 'Saga', 122);
INSERT INTO estados VALUES (2036, 'Saitama', 122);
INSERT INTO estados VALUES (2037, 'Shiga', 122);
INSERT INTO estados VALUES (2038, 'Shimane', 122);
INSERT INTO estados VALUES (2039, 'Shizuoka', 122);
INSERT INTO estados VALUES (2040, 'Tochigi', 122);
INSERT INTO estados VALUES (2041, 'Tokushima', 122);
INSERT INTO estados VALUES (2042, 'Tokyo', 122);
INSERT INTO estados VALUES (2043, 'Tottori', 122);
INSERT INTO estados VALUES (2044, 'Toyama', 122);
INSERT INTO estados VALUES (2045, 'Wakayama', 122);
INSERT INTO estados VALUES (2046, 'Yamagata', 122);
INSERT INTO estados VALUES (2047, 'Yamaguchi', 122);
INSERT INTO estados VALUES (2048, 'Yamanashi', 122);
INSERT INTO estados VALUES (2049, 'Al Balqa', 123);
INSERT INTO estados VALUES (2050, 'Al Karak', 123);
INSERT INTO estados VALUES (2051, 'Al Mafraq', 123);
INSERT INTO estados VALUES (2052, 'Amman', 123);
INSERT INTO estados VALUES (2053, 'At Tafilah', 123);
INSERT INTO estados VALUES (2054, 'Az Zarqa', 123);
INSERT INTO estados VALUES (2055, 'Irbid', 123);
INSERT INTO estados VALUES (2056, 'Ma', 123);
INSERT INTO estados VALUES (2057, 'Almaty', 124);
INSERT INTO estados VALUES (2058, 'Almaty City', 124);
INSERT INTO estados VALUES (2059, 'Aqmola', 124);
INSERT INTO estados VALUES (2061, 'Astana City', 124);
INSERT INTO estados VALUES (2062, 'Atyrau', 124);
INSERT INTO estados VALUES (2063, 'Bayqonyr', 124);
INSERT INTO estados VALUES (2064, 'East Kazakhstan', 124);
INSERT INTO estados VALUES (2065, 'Mangghystau', 124);
INSERT INTO estados VALUES (2066, 'North Kazakhstan', 124);
INSERT INTO estados VALUES (2067, 'Pavlodar', 124);
INSERT INTO estados VALUES (2068, 'Qaraghandy', 124);
INSERT INTO estados VALUES (2069, 'Qostanay', 124);
INSERT INTO estados VALUES (2070, 'Qyzylorda', 124);
INSERT INTO estados VALUES (2071, 'South Kazakhstan', 124);
INSERT INTO estados VALUES (2072, 'West Kazakhstan', 124);
INSERT INTO estados VALUES (2073, 'Zhambyl', 124);
INSERT INTO estados VALUES (2074, 'Central', 125);
INSERT INTO estados VALUES (2075, 'Coast', 125);
INSERT INTO estados VALUES (2076, 'Eastern', 125);
INSERT INTO estados VALUES (2077, 'Nairobi Area', 125);
INSERT INTO estados VALUES (2078, 'North-Eastern', 125);
INSERT INTO estados VALUES (2079, 'Nyanza', 125);
INSERT INTO estados VALUES (2080, 'Rift Valley', 125);
INSERT INTO estados VALUES (2081, 'Western', 125);
INSERT INTO estados VALUES (2082, 'Gilbert Islands', 126);
INSERT INTO estados VALUES (2083, 'Line Islands', 126);
INSERT INTO estados VALUES (2084, 'Phoenix Islands', 126);
INSERT INTO estados VALUES (2085, 'Al Ahmadi', 127);
INSERT INTO estados VALUES (2086, 'Al Jahra', 127);
INSERT INTO estados VALUES (2087, 'Al Kuwayt', 127);
INSERT INTO estados VALUES (2088, 'Hawalli', 127);
INSERT INTO estados VALUES (2089, 'Batken', 128);
INSERT INTO estados VALUES (2090, 'Bishkek', 128);
INSERT INTO estados VALUES (2091, 'Chuy', 128);
INSERT INTO estados VALUES (2092, 'Jalal-Abad', 128);
INSERT INTO estados VALUES (2093, 'Naryn', 128);
INSERT INTO estados VALUES (2094, 'Osh', 128);
INSERT INTO estados VALUES (2095, 'Osh', 128);
INSERT INTO estados VALUES (2096, 'Talas', 128);
INSERT INTO estados VALUES (2097, 'Ysyk-Kol', 128);
INSERT INTO estados VALUES (2098, 'Attapu', 129);
INSERT INTO estados VALUES (2099, 'Champasak', 129);
INSERT INTO estados VALUES (2100, 'Houaphan', 129);
INSERT INTO estados VALUES (2101, 'Khammouan', 129);
INSERT INTO estados VALUES (2102, 'Louang Namtha', 129);
INSERT INTO estados VALUES (2103, 'Louangphrabang', 129);
INSERT INTO estados VALUES (2104, 'Oudomxai', 129);
INSERT INTO estados VALUES (2105, 'Phongsali', 129);
INSERT INTO estados VALUES (2106, 'Saravan', 129);
INSERT INTO estados VALUES (2107, 'Savannakhet', 129);
INSERT INTO estados VALUES (2108, 'Vientiane', 129);
INSERT INTO estados VALUES (2109, 'Xaignabouri', 129);
INSERT INTO estados VALUES (2110, 'Xiangkhoang', 129);
INSERT INTO estados VALUES (2111, 'Aizkraukles', 130);
INSERT INTO estados VALUES (2112, 'Aluksnes', 130);
INSERT INTO estados VALUES (2113, 'Balvu', 130);
INSERT INTO estados VALUES (2114, 'Bauskas', 130);
INSERT INTO estados VALUES (2115, 'Daugavpils', 130);
INSERT INTO estados VALUES (2116, 'Daugavpils', 130);
INSERT INTO estados VALUES (2117, 'Dobeles', 130);
INSERT INTO estados VALUES (2118, 'Gulbenes', 130);
INSERT INTO estados VALUES (2119, 'Jelgava', 130);
INSERT INTO estados VALUES (2120, 'Jelgavas', 130);
INSERT INTO estados VALUES (2121, 'Jurmala', 130);
INSERT INTO estados VALUES (2122, 'Kuldigas', 130);
INSERT INTO estados VALUES (2123, 'Limbazu', 130);
INSERT INTO estados VALUES (2124, 'Ludzas', 130);
INSERT INTO estados VALUES (2125, 'Madonas', 130);
INSERT INTO estados VALUES (2126, 'Ogres', 130);
INSERT INTO estados VALUES (2127, 'Preilu', 130);
INSERT INTO estados VALUES (2128, 'Riga', 130);
INSERT INTO estados VALUES (2129, 'Rigas', 130);
INSERT INTO estados VALUES (2130, 'Saldus', 130);
INSERT INTO estados VALUES (2131, 'Talsu', 130);
INSERT INTO estados VALUES (2132, 'Tukuma', 130);
INSERT INTO estados VALUES (2133, 'Valkas', 130);
INSERT INTO estados VALUES (2134, 'Valmieras', 130);
INSERT INTO estados VALUES (2135, 'Ventspils', 130);
INSERT INTO estados VALUES (2136, 'Ventspils', 130);
INSERT INTO estados VALUES (2137, 'Berea', 131);
INSERT INTO estados VALUES (2138, 'Butha-Buthe', 131);
INSERT INTO estados VALUES (2139, 'Leribe', 131);
INSERT INTO estados VALUES (2140, 'Mafeteng', 131);
INSERT INTO estados VALUES (2141, 'Maseru', 131);
INSERT INTO estados VALUES (2142, 'Mohales Hoek', 131);
INSERT INTO estados VALUES (2143, 'Mokhotlong', 131);
INSERT INTO estados VALUES (2144, 'Qachas Nek', 131);
INSERT INTO estados VALUES (2145, 'Quthing', 131);
INSERT INTO estados VALUES (2146, 'Thaba-Tseka', 131);
INSERT INTO estados VALUES (2147, 'Bong', 132);
INSERT INTO estados VALUES (2148, 'Grand Bassa', 132);
INSERT INTO estados VALUES (2149, 'Grand Cape Mount', 132);
INSERT INTO estados VALUES (2150, 'Grand Jide', 132);
INSERT INTO estados VALUES (2151, 'Lofa', 132);
INSERT INTO estados VALUES (2152, 'Maryland', 132);
INSERT INTO estados VALUES (2153, 'Monrovia', 132);
INSERT INTO estados VALUES (2154, 'Montserrado', 132);
INSERT INTO estados VALUES (2155, 'Nimba', 132);
INSERT INTO estados VALUES (2156, 'Sino', 132);
INSERT INTO estados VALUES (2157, 'Ajdabiya', 133);
INSERT INTO estados VALUES (2158, 'Al', 133);
INSERT INTO estados VALUES (2159, 'Al Fatih', 133);
INSERT INTO estados VALUES (2160, 'Al Jabal al Akhdar', 133);
INSERT INTO estados VALUES (2161, 'Al Jufrah', 133);
INSERT INTO estados VALUES (2162, 'Al Khums', 133);
INSERT INTO estados VALUES (2163, 'Al Kufrah', 133);
INSERT INTO estados VALUES (2164, 'An Nuqat al Khams', 133);
INSERT INTO estados VALUES (2165, 'Ash Shati', 133);
INSERT INTO estados VALUES (2166, 'Awbari', 133);
INSERT INTO estados VALUES (2167, 'Az Zawiyah', 133);
INSERT INTO estados VALUES (2168, 'Banghazi', 133);
INSERT INTO estados VALUES (2169, 'Darnah', 133);
INSERT INTO estados VALUES (2170, 'Ghadamis', 133);
INSERT INTO estados VALUES (2171, 'Gharyan', 133);
INSERT INTO estados VALUES (2172, 'Misratah', 133);
INSERT INTO estados VALUES (2173, 'Murzuq', 133);
INSERT INTO estados VALUES (2174, 'Sabha', 133);
INSERT INTO estados VALUES (2175, 'Sawfajjin', 133);
INSERT INTO estados VALUES (2176, 'Surt', 133);
INSERT INTO estados VALUES (2177, 'Tarabulus', 133);
INSERT INTO estados VALUES (2178, 'Tarhunah', 133);
INSERT INTO estados VALUES (2179, 'Tubruq', 133);
INSERT INTO estados VALUES (2180, 'Yafran', 133);
INSERT INTO estados VALUES (2181, 'Zlitan', 133);
INSERT INTO estados VALUES (2182, 'Balzers', 134);
INSERT INTO estados VALUES (2183, 'Eschen', 134);
INSERT INTO estados VALUES (2184, 'Gamprin', 134);
INSERT INTO estados VALUES (2185, 'Mauren', 134);
INSERT INTO estados VALUES (2186, 'Planken', 134);
INSERT INTO estados VALUES (2187, 'Ruggell', 134);
INSERT INTO estados VALUES (2188, 'Schaan', 134);
INSERT INTO estados VALUES (2189, 'Schellenberg', 134);
INSERT INTO estados VALUES (2190, 'Triesen', 134);
INSERT INTO estados VALUES (2191, 'Triesenberg', 134);
INSERT INTO estados VALUES (2192, 'Vaduz', 134);
INSERT INTO estados VALUES (2193, 'Alytaus Apskritis', 135);
INSERT INTO estados VALUES (2194, 'Kauno Apskritis', 135);
INSERT INTO estados VALUES (2195, 'Klaipedos Apskritis', 135);
INSERT INTO estados VALUES (2196, 'Marijampoles Apskritis', 135);
INSERT INTO estados VALUES (2197, 'Panevezio Apskritis', 135);
INSERT INTO estados VALUES (2198, 'Siauliu Apskritis', 135);
INSERT INTO estados VALUES (2199, 'Taurages Apskritis', 135);
INSERT INTO estados VALUES (2200, 'Telsiu Apskritis', 135);
INSERT INTO estados VALUES (2201, 'Utenos Apskritis', 135);
INSERT INTO estados VALUES (2202, 'Vilniaus Apskritis', 135);
INSERT INTO estados VALUES (2203, 'Diekirch', 136);
INSERT INTO estados VALUES (2204, 'Grevenmacher', 136);
INSERT INTO estados VALUES (2205, 'Luxembourg', 136);
INSERT INTO estados VALUES (2206, 'Beqaa', 137);
INSERT INTO estados VALUES (2207, 'Beyrouth', 137);
INSERT INTO estados VALUES (2208, 'Liban-Nord', 137);
INSERT INTO estados VALUES (2209, 'Liban-Sud', 137);
INSERT INTO estados VALUES (2210, 'Mont-Liban', 137);
INSERT INTO estados VALUES (2211, 'Nabatiye', 137);
INSERT INTO estados VALUES (2212, 'Ilhas', 138);
INSERT INTO estados VALUES (2213, 'Macau', 138);
INSERT INTO estados VALUES (2214, 'Aracinovo', 139);
INSERT INTO estados VALUES (2215, 'Bac', 139);
INSERT INTO estados VALUES (2216, 'Belcista', 139);
INSERT INTO estados VALUES (2217, 'Berovo', 139);
INSERT INTO estados VALUES (2218, 'Bistrica', 139);
INSERT INTO estados VALUES (2219, 'Bitola', 139);
INSERT INTO estados VALUES (2220, 'Blatec', 139);
INSERT INTO estados VALUES (2221, 'Bogdanci', 139);
INSERT INTO estados VALUES (2222, 'Bogomila', 139);
INSERT INTO estados VALUES (2223, 'Bogovinje', 139);
INSERT INTO estados VALUES (2224, 'Bosilovo', 139);
INSERT INTO estados VALUES (2225, 'Brvenica', 139);
INSERT INTO estados VALUES (2226, 'Cair', 139);
INSERT INTO estados VALUES (2227, 'Capari', 139);
INSERT INTO estados VALUES (2228, 'Caska', 139);
INSERT INTO estados VALUES (2229, 'Cegrane', 139);
INSERT INTO estados VALUES (2230, 'Centar', 139);
INSERT INTO estados VALUES (2231, 'Centar Zupa', 139);
INSERT INTO estados VALUES (2232, 'Cesinovo', 139);
INSERT INTO estados VALUES (2233, 'Cucer-Sandevo', 139);
INSERT INTO estados VALUES (2234, 'Debar', 139);
INSERT INTO estados VALUES (2235, 'Delcevo', 139);
INSERT INTO estados VALUES (2236, 'Delogozdi', 139);
INSERT INTO estados VALUES (2237, 'Demir Hisar', 139);
INSERT INTO estados VALUES (2238, 'Demir Kapija', 139);
INSERT INTO estados VALUES (2239, 'Dobrusevo', 139);
INSERT INTO estados VALUES (2240, 'Dolna Banjica', 139);
INSERT INTO estados VALUES (2241, 'Dolneni', 139);
INSERT INTO estados VALUES (2242, 'Dorce Petrov', 139);
INSERT INTO estados VALUES (2243, 'Drugovo', 139);
INSERT INTO estados VALUES (2244, 'Dzepciste', 139);
INSERT INTO estados VALUES (2245, 'Gazi Baba', 139);
INSERT INTO estados VALUES (2246, 'Gevgelija', 139);
INSERT INTO estados VALUES (2247, 'Gostivar', 139);
INSERT INTO estados VALUES (2248, 'Gradsko', 139);
INSERT INTO estados VALUES (2249, 'Ilinden', 139);
INSERT INTO estados VALUES (2250, 'Izvor', 139);
INSERT INTO estados VALUES (2251, 'Jegunovce', 139);
INSERT INTO estados VALUES (2252, 'Kamenjane', 139);
INSERT INTO estados VALUES (2253, 'Karbinci', 139);
INSERT INTO estados VALUES (2254, 'Karpos', 139);
INSERT INTO estados VALUES (2255, 'Kavadarci', 139);
INSERT INTO estados VALUES (2256, 'Kicevo', 139);
INSERT INTO estados VALUES (2257, 'Kisela Voda', 139);
INSERT INTO estados VALUES (2258, 'Klecevce', 139);
INSERT INTO estados VALUES (2259, 'Kocani', 139);
INSERT INTO estados VALUES (2260, 'Konce', 139);
INSERT INTO estados VALUES (2261, 'Kondovo', 139);
INSERT INTO estados VALUES (2262, 'Konopiste', 139);
INSERT INTO estados VALUES (2263, 'Kosel', 139);
INSERT INTO estados VALUES (2264, 'Kratovo', 139);
INSERT INTO estados VALUES (2265, 'Kriva Palanka', 139);
INSERT INTO estados VALUES (2266, 'Krivogastani', 139);
INSERT INTO estados VALUES (2267, 'Krusevo', 139);
INSERT INTO estados VALUES (2268, 'Kuklis', 139);
INSERT INTO estados VALUES (2269, 'Kukurecani', 139);
INSERT INTO estados VALUES (2270, 'Kumanovo', 139);
INSERT INTO estados VALUES (2271, 'Labunista', 139);
INSERT INTO estados VALUES (2272, 'Lipkovo', 139);
INSERT INTO estados VALUES (2273, 'Lozovo', 139);
INSERT INTO estados VALUES (2274, 'Lukovo', 139);
INSERT INTO estados VALUES (2275, 'Makedonska Kamenica', 139);
INSERT INTO estados VALUES (2276, 'Makedonski Brod', 139);
INSERT INTO estados VALUES (2277, 'Mavrovi Anovi', 139);
INSERT INTO estados VALUES (2278, 'Meseista', 139);
INSERT INTO estados VALUES (2279, 'Miravci', 139);
INSERT INTO estados VALUES (2280, 'Mogila', 139);
INSERT INTO estados VALUES (2281, 'Murtino', 139);
INSERT INTO estados VALUES (2282, 'Negotino', 139);
INSERT INTO estados VALUES (2283, 'Negotino-Polosko', 139);
INSERT INTO estados VALUES (2284, 'Novaci', 139);
INSERT INTO estados VALUES (2285, 'Novo Selo', 139);
INSERT INTO estados VALUES (2286, 'Oblesevo', 139);
INSERT INTO estados VALUES (2287, 'Ohrid', 139);
INSERT INTO estados VALUES (2288, 'Orasac', 139);
INSERT INTO estados VALUES (2289, 'Orizari', 139);
INSERT INTO estados VALUES (2290, 'Oslomej', 139);
INSERT INTO estados VALUES (2291, 'Pehcevo', 139);
INSERT INTO estados VALUES (2292, 'Petrovec', 139);
INSERT INTO estados VALUES (2293, 'Plasnica', 139);
INSERT INTO estados VALUES (2294, 'Podares', 139);
INSERT INTO estados VALUES (2295, 'Prilep', 139);
INSERT INTO estados VALUES (2296, 'Probistip', 139);
INSERT INTO estados VALUES (2297, 'Radovis', 139);
INSERT INTO estados VALUES (2298, 'Rankovce', 139);
INSERT INTO estados VALUES (2299, 'Resen', 139);
INSERT INTO estados VALUES (2300, 'Rosoman', 139);
INSERT INTO estados VALUES (2301, 'Rostusa', 139);
INSERT INTO estados VALUES (2302, 'Samokov', 139);
INSERT INTO estados VALUES (2303, 'Saraj', 139);
INSERT INTO estados VALUES (2304, 'Sipkovica', 139);
INSERT INTO estados VALUES (2305, 'Sopiste', 139);
INSERT INTO estados VALUES (2306, 'Sopotnica', 139);
INSERT INTO estados VALUES (2307, 'Srbinovo', 139);
INSERT INTO estados VALUES (2308, 'Star Dojran', 139);
INSERT INTO estados VALUES (2309, 'Staravina', 139);
INSERT INTO estados VALUES (2310, 'Staro Nagoricane', 139);
INSERT INTO estados VALUES (2311, 'Stip', 139);
INSERT INTO estados VALUES (2312, 'Struga', 139);
INSERT INTO estados VALUES (2313, 'Strumica', 139);
INSERT INTO estados VALUES (2314, 'Studenicani', 139);
INSERT INTO estados VALUES (2315, 'Suto Orizari', 139);
INSERT INTO estados VALUES (2316, 'Sveti Nikole', 139);
INSERT INTO estados VALUES (2317, 'Tearce', 139);
INSERT INTO estados VALUES (2318, 'Tetovo', 139);
INSERT INTO estados VALUES (2319, 'Topolcani', 139);
INSERT INTO estados VALUES (2320, 'Valandovo', 139);
INSERT INTO estados VALUES (2321, 'Vasilevo', 139);
INSERT INTO estados VALUES (2322, 'Veles', 139);
INSERT INTO estados VALUES (2323, 'Velesta', 139);
INSERT INTO estados VALUES (2324, 'Vevcani', 139);
INSERT INTO estados VALUES (2325, 'Vinica', 139);
INSERT INTO estados VALUES (2326, 'Vitoliste', 139);
INSERT INTO estados VALUES (2327, 'Vranestica', 139);
INSERT INTO estados VALUES (2328, 'Vrapciste', 139);
INSERT INTO estados VALUES (2329, 'Vratnica', 139);
INSERT INTO estados VALUES (2330, 'Vrutok', 139);
INSERT INTO estados VALUES (2331, 'Zajas', 139);
INSERT INTO estados VALUES (2332, 'Zelenikovo', 139);
INSERT INTO estados VALUES (2333, 'Zelino', 139);
INSERT INTO estados VALUES (2334, 'Zitose', 139);
INSERT INTO estados VALUES (2335, 'Zletovo', 139);
INSERT INTO estados VALUES (2336, 'Zrnovci', 139);
INSERT INTO estados VALUES (2337, 'Ilhas', 139);
INSERT INTO estados VALUES (2338, 'Macau', 139);
INSERT INTO estados VALUES (2339, 'Antananarivo', 140);
INSERT INTO estados VALUES (2340, 'Antsiranana', 140);
INSERT INTO estados VALUES (2341, 'Fianarantsoa', 140);
INSERT INTO estados VALUES (2342, 'Mahajanga', 140);
INSERT INTO estados VALUES (2343, 'Toamasina', 140);
INSERT INTO estados VALUES (2344, 'Toliara', 140);
INSERT INTO estados VALUES (2345, 'Johor', 141);
INSERT INTO estados VALUES (2346, 'Kedah', 141);
INSERT INTO estados VALUES (2347, 'Kelantan', 141);
INSERT INTO estados VALUES (2348, 'Labuan', 141);
INSERT INTO estados VALUES (2349, 'Melaka', 141);
INSERT INTO estados VALUES (2350, 'Negeri Sembilan', 141);
INSERT INTO estados VALUES (2351, 'Pahang', 141);
INSERT INTO estados VALUES (2352, 'Perak', 141);
INSERT INTO estados VALUES (2353, 'Perlis', 141);
INSERT INTO estados VALUES (2354, 'Pulau Pinang', 141);
INSERT INTO estados VALUES (2355, 'Sabah', 141);
INSERT INTO estados VALUES (2356, 'Sarawak', 141);
INSERT INTO estados VALUES (2357, 'Selangor', 141);
INSERT INTO estados VALUES (2358, 'Terengganu', 141);
INSERT INTO estados VALUES (2359, 'Wilayah Persekutuan', 141);
INSERT INTO estados VALUES (2360, 'Balaka', 142);
INSERT INTO estados VALUES (2361, 'Blantyre', 142);
INSERT INTO estados VALUES (2362, 'Chikwawa', 142);
INSERT INTO estados VALUES (2363, 'Chiradzulu', 142);
INSERT INTO estados VALUES (2364, 'Chitipa', 142);
INSERT INTO estados VALUES (2365, 'Dedza', 142);
INSERT INTO estados VALUES (2366, 'Dowa', 142);
INSERT INTO estados VALUES (2367, 'Karonga', 142);
INSERT INTO estados VALUES (2368, 'Kasungu', 142);
INSERT INTO estados VALUES (2369, 'Likoma', 142);
INSERT INTO estados VALUES (2370, 'Lilongwe', 142);
INSERT INTO estados VALUES (2371, 'Machinga', 142);
INSERT INTO estados VALUES (2372, 'Mangochi', 142);
INSERT INTO estados VALUES (2373, 'Mchinji', 142);
INSERT INTO estados VALUES (2374, 'Mulanje', 142);
INSERT INTO estados VALUES (2375, 'Mwanza', 142);
INSERT INTO estados VALUES (2376, 'Mzimba', 142);
INSERT INTO estados VALUES (2377, 'Nkhata Bay', 142);
INSERT INTO estados VALUES (2378, 'Nkhotakota', 142);
INSERT INTO estados VALUES (2379, 'Nsanje', 142);
INSERT INTO estados VALUES (2380, 'Ntcheu', 142);
INSERT INTO estados VALUES (2381, 'Ntchisi', 142);
INSERT INTO estados VALUES (2382, 'Phalombe', 142);
INSERT INTO estados VALUES (2383, 'Rumphi', 142);
INSERT INTO estados VALUES (2384, 'Salima', 142);
INSERT INTO estados VALUES (2385, 'Thyolo', 142);
INSERT INTO estados VALUES (2386, 'Zomba', 142);
INSERT INTO estados VALUES (2387, 'Aliff', 143);
INSERT INTO estados VALUES (2388, 'Baa', 143);
INSERT INTO estados VALUES (2389, 'Daalu', 143);
INSERT INTO estados VALUES (2390, 'Faafu', 143);
INSERT INTO estados VALUES (2391, 'Gaafu Aliff', 143);
INSERT INTO estados VALUES (2392, 'Gaafu Daalu', 143);
INSERT INTO estados VALUES (2393, 'Haa Aliff', 143);
INSERT INTO estados VALUES (2394, 'Haa Daalu', 143);
INSERT INTO estados VALUES (2395, 'Kaafu', 143);
INSERT INTO estados VALUES (2396, 'Laamu', 143);
INSERT INTO estados VALUES (2397, 'Laviyani', 143);
INSERT INTO estados VALUES (2398, 'Male', 143);
INSERT INTO estados VALUES (2399, 'Meemu', 143);
INSERT INTO estados VALUES (2400, 'Naviyani', 143);
INSERT INTO estados VALUES (2401, 'Noonu', 143);
INSERT INTO estados VALUES (2402, 'Raa', 143);
INSERT INTO estados VALUES (2403, 'Seenu', 143);
INSERT INTO estados VALUES (2404, 'Shaviyani', 143);
INSERT INTO estados VALUES (2405, 'Thaa', 143);
INSERT INTO estados VALUES (2406, 'Waavu', 143);
INSERT INTO estados VALUES (2407, 'Malta (General)', 144);
INSERT INTO estados VALUES (2408, 'Bamako', 145);
INSERT INTO estados VALUES (2409, 'Gao', 145);
INSERT INTO estados VALUES (2410, 'Kayes', 145);
INSERT INTO estados VALUES (2411, 'Kidal', 145);
INSERT INTO estados VALUES (2412, 'Koulikoro', 145);
INSERT INTO estados VALUES (2413, 'Mopti', 145);
INSERT INTO estados VALUES (2414, 'Segou', 145);
INSERT INTO estados VALUES (2415, 'Sikasso', 145);
INSERT INTO estados VALUES (2416, 'Tombouctou', 145);
INSERT INTO estados VALUES (2417, 'Agadir', 146);
INSERT INTO estados VALUES (2418, 'Al Hoceima', 146);
INSERT INTO estados VALUES (2419, 'Azilal', 146);
INSERT INTO estados VALUES (2420, 'Ben Slimane', 146);
INSERT INTO estados VALUES (2421, 'Beni Mellal', 146);
INSERT INTO estados VALUES (2422, 'Boulemane', 146);
INSERT INTO estados VALUES (2423, 'Casablanca', 146);
INSERT INTO estados VALUES (2424, 'Chaouen', 146);
INSERT INTO estados VALUES (2425, 'El Jadida', 146);
INSERT INTO estados VALUES (2426, 'El Kelaa des Srarhna', 146);
INSERT INTO estados VALUES (2427, 'Er Rachidia', 146);
INSERT INTO estados VALUES (2428, 'Essaouira', 146);
INSERT INTO estados VALUES (2429, 'Fes', 146);
INSERT INTO estados VALUES (2430, 'Figuig', 146);
INSERT INTO estados VALUES (2431, 'Guelmim', 146);
INSERT INTO estados VALUES (2432, 'Ifrane', 146);
INSERT INTO estados VALUES (2433, 'Kenitra', 146);
INSERT INTO estados VALUES (2434, 'Khemisset', 146);
INSERT INTO estados VALUES (2435, 'Khenifra', 146);
INSERT INTO estados VALUES (2436, 'Khouribga', 146);
INSERT INTO estados VALUES (2437, 'Laayoune', 146);
INSERT INTO estados VALUES (2438, 'Larache', 146);
INSERT INTO estados VALUES (2439, 'Marrakech', 146);
INSERT INTO estados VALUES (2440, 'Meknes', 146);
INSERT INTO estados VALUES (2441, 'Nador', 146);
INSERT INTO estados VALUES (2442, 'Ouarzazate', 146);
INSERT INTO estados VALUES (2443, 'Oujda', 146);
INSERT INTO estados VALUES (2444, 'Rabat-Sale', 146);
INSERT INTO estados VALUES (2445, 'Safi', 146);
INSERT INTO estados VALUES (2446, 'Settat', 146);
INSERT INTO estados VALUES (2447, 'Sidi Kacem', 146);
INSERT INTO estados VALUES (2448, 'Tan-Tan', 146);
INSERT INTO estados VALUES (2449, 'Tanger', 146);
INSERT INTO estados VALUES (2450, 'Taounate', 146);
INSERT INTO estados VALUES (2451, 'Taroudannt', 146);
INSERT INTO estados VALUES (2452, 'Tata', 146);
INSERT INTO estados VALUES (2453, 'Taza', 146);
INSERT INTO estados VALUES (2454, 'Tetouan', 146);
INSERT INTO estados VALUES (2455, 'Tiznit', 146);
INSERT INTO estados VALUES (2456, 'Martinique Departement', 147);
INSERT INTO estados VALUES (2457, 'Adrar', 148);
INSERT INTO estados VALUES (2458, 'Assaba', 148);
INSERT INTO estados VALUES (2459, 'Brakna', 148);
INSERT INTO estados VALUES (2460, 'Dakhlet Nouadhibou', 148);
INSERT INTO estados VALUES (2461, 'Gorgol', 148);
INSERT INTO estados VALUES (2462, 'Guidimaka', 148);
INSERT INTO estados VALUES (2463, 'Hodh Ech Chargui', 148);
INSERT INTO estados VALUES (2464, 'Hodh El Gharbi', 148);
INSERT INTO estados VALUES (2465, 'Inchiri', 148);
INSERT INTO estados VALUES (2466, 'Tagant', 148);
INSERT INTO estados VALUES (2467, 'Tiris Zemmour', 148);
INSERT INTO estados VALUES (2468, 'Trarza', 148);
INSERT INTO estados VALUES (2469, 'Mayotte (General)', 149);
INSERT INTO estados VALUES (2470, 'Chuuk', 150);
INSERT INTO estados VALUES (2471, 'Kosrae', 150);
INSERT INTO estados VALUES (2472, 'Pohnpei', 150);
INSERT INTO estados VALUES (2473, 'Yap', 150);
INSERT INTO estados VALUES (2474, 'Balti', 151);
INSERT INTO estados VALUES (2475, 'Cahul', 151);
INSERT INTO estados VALUES (2476, 'Chisinau', 151);
INSERT INTO estados VALUES (2477, 'Edinet', 151);
INSERT INTO estados VALUES (2478, 'Gagauzia', 151);
INSERT INTO estados VALUES (2479, 'Lapusna', 151);
INSERT INTO estados VALUES (2480, 'Orhei', 151);
INSERT INTO estados VALUES (2481, 'Soroca', 151);
INSERT INTO estados VALUES (2482, 'Stinga Nistrului', 151);
INSERT INTO estados VALUES (2483, 'Tighina', 151);
INSERT INTO estados VALUES (2484, 'Ungheni', 151);
INSERT INTO estados VALUES (2485, 'Arhangay', 152);
INSERT INTO estados VALUES (2486, 'Bayan-Olgiy', 152);
INSERT INTO estados VALUES (2487, 'Bayanhongor', 152);
INSERT INTO estados VALUES (2488, 'Bulgan', 152);
INSERT INTO estados VALUES (2489, 'Darhan', 152);
INSERT INTO estados VALUES (2490, 'Darhan Uul', 152);
INSERT INTO estados VALUES (2491, 'Dornod', 152);
INSERT INTO estados VALUES (2492, 'Dornogovi', 152);
INSERT INTO estados VALUES (2493, 'Dundgovi', 152);
INSERT INTO estados VALUES (2494, 'Dzavhan', 152);
INSERT INTO estados VALUES (2495, 'Erdenet', 152);
INSERT INTO estados VALUES (2496, 'Govi-Altay', 152);
INSERT INTO estados VALUES (2497, 'Govi-Sumber', 152);
INSERT INTO estados VALUES (2498, 'Hentiy', 152);
INSERT INTO estados VALUES (2499, 'Hovd', 152);
INSERT INTO estados VALUES (2500, 'Hovsgol', 152);
INSERT INTO estados VALUES (2501, 'Omnogovi', 152);
INSERT INTO estados VALUES (2502, 'Orhon', 152);
INSERT INTO estados VALUES (2503, 'Ovorhangay', 152);
INSERT INTO estados VALUES (2504, 'Selenge', 152);
INSERT INTO estados VALUES (2505, 'Suhbaatar', 152);
INSERT INTO estados VALUES (2506, 'Tov', 152);
INSERT INTO estados VALUES (2507, 'Ulaanbaatar', 152);
INSERT INTO estados VALUES (2508, 'Uvs', 152);
INSERT INTO estados VALUES (2509, 'Saint Anthony', 153);
INSERT INTO estados VALUES (2510, 'Saint Georges', 153);
INSERT INTO estados VALUES (2511, 'Saint Peter', 153);
INSERT INTO estados VALUES (2512, 'Cabo Delgado', 154);
INSERT INTO estados VALUES (2513, 'Gaza', 154);
INSERT INTO estados VALUES (2514, 'Inhambane', 154);
INSERT INTO estados VALUES (2515, 'Manica', 154);
INSERT INTO estados VALUES (2516, 'Maputo', 154);
INSERT INTO estados VALUES (2517, 'Nampula', 154);
INSERT INTO estados VALUES (2518, 'Niassa', 154);
INSERT INTO estados VALUES (2519, 'Sofala', 154);
INSERT INTO estados VALUES (2520, 'Tete', 154);
INSERT INTO estados VALUES (2521, 'Zambezia', 154);
INSERT INTO estados VALUES (2522, 'Chin State', 155);
INSERT INTO estados VALUES (2523, 'Irrawaddy', 155);
INSERT INTO estados VALUES (2524, 'Kachin State', 155);
INSERT INTO estados VALUES (2525, 'Karan State', 155);
INSERT INTO estados VALUES (2526, 'Kayah State', 155);
INSERT INTO estados VALUES (2527, 'Magwe', 155);
INSERT INTO estados VALUES (2528, 'Mandalay', 155);
INSERT INTO estados VALUES (2529, 'Mon State', 155);
INSERT INTO estados VALUES (2530, 'Pegu', 155);
INSERT INTO estados VALUES (2531, 'Rakhine State', 155);
INSERT INTO estados VALUES (2532, 'Rangoon', 155);
INSERT INTO estados VALUES (2533, 'Sagaing', 155);
INSERT INTO estados VALUES (2534, 'Shan State', 155);
INSERT INTO estados VALUES (2535, 'Tenasserim', 155);
INSERT INTO estados VALUES (2536, 'Yangon', 155);
INSERT INTO estados VALUES (2537, 'Aguascalientes', 156);
INSERT INTO estados VALUES (2538, 'Baja California', 156);
INSERT INTO estados VALUES (2539, 'Baja California Sur', 156);
INSERT INTO estados VALUES (2540, 'Campeche', 156);
INSERT INTO estados VALUES (2541, 'Chiapas', 156);
INSERT INTO estados VALUES (2542, 'Chihuahua', 156);
INSERT INTO estados VALUES (2543, 'Coahuila de Zaragoza', 156);
INSERT INTO estados VALUES (2544, 'Colima', 156);
INSERT INTO estados VALUES (2545, 'Distrito Federal', 156);
INSERT INTO estados VALUES (2546, 'Durango', 156);
INSERT INTO estados VALUES (2547, 'Guanajuato', 156);
INSERT INTO estados VALUES (2548, 'Guerrero', 156);
INSERT INTO estados VALUES (2549, 'Hidalgo', 156);
INSERT INTO estados VALUES (2550, 'Jalisco', 156);
INSERT INTO estados VALUES (2551, 'Mexico', 156);
INSERT INTO estados VALUES (2552, 'Michoacan de Ocampo', 156);
INSERT INTO estados VALUES (2553, 'Morelos', 156);
INSERT INTO estados VALUES (2554, 'Nayarit', 156);
INSERT INTO estados VALUES (2555, 'Nuevo Leon', 156);
INSERT INTO estados VALUES (2556, 'Oaxaca', 156);
INSERT INTO estados VALUES (2557, 'Puebla', 156);
INSERT INTO estados VALUES (2558, 'Queretaro de Arteaga', 156);
INSERT INTO estados VALUES (2559, 'Quintana Roo', 156);
INSERT INTO estados VALUES (2560, 'San Luis Potosi', 156);
INSERT INTO estados VALUES (2561, 'Sinaloa', 156);
INSERT INTO estados VALUES (2562, 'Sonora', 156);
INSERT INTO estados VALUES (2563, 'Tabasco', 156);
INSERT INTO estados VALUES (2564, 'Tamaulipas', 156);
INSERT INTO estados VALUES (2565, 'Tlaxcala', 156);
INSERT INTO estados VALUES (2566, 'Veracruz-Llave', 156);
INSERT INTO estados VALUES (2567, 'Yucatan', 156);
INSERT INTO estados VALUES (2568, 'Zacatecas', 156);
INSERT INTO estados VALUES (2569, 'La Condamine', 157);
INSERT INTO estados VALUES (2570, 'Monaco', 157);
INSERT INTO estados VALUES (2571, 'Monte-Carlo', 157);
INSERT INTO estados VALUES (2572, 'Bethanien', 158);
INSERT INTO estados VALUES (2573, 'Boesmanland', 158);
INSERT INTO estados VALUES (2574, 'Caprivi', 158);
INSERT INTO estados VALUES (2575, 'Caprivi Oos', 158);
INSERT INTO estados VALUES (2576, 'Damaraland', 158);
INSERT INTO estados VALUES (2577, 'Erongo', 158);
INSERT INTO estados VALUES (2578, 'Gobabis', 158);
INSERT INTO estados VALUES (2579, 'Grootfontein', 158);
INSERT INTO estados VALUES (2580, 'Hardap', 158);
INSERT INTO estados VALUES (2581, 'Hereroland Oos', 158);
INSERT INTO estados VALUES (2582, 'Hereroland Wes', 158);
INSERT INTO estados VALUES (2583, 'Kaokoland', 158);
INSERT INTO estados VALUES (2584, 'Karas', 158);
INSERT INTO estados VALUES (2585, 'Karasburg', 158);
INSERT INTO estados VALUES (2586, 'Karibib', 158);
INSERT INTO estados VALUES (2587, 'Kavango', 158);
INSERT INTO estados VALUES (2588, 'Keetmanshoop', 158);
INSERT INTO estados VALUES (2589, 'Khomas Region', 158);
INSERT INTO estados VALUES (2590, 'Kunene', 158);
INSERT INTO estados VALUES (2591, 'Luderitz', 158);
INSERT INTO estados VALUES (2592, 'Maltahohe', 158);
INSERT INTO estados VALUES (2593, 'Mariental', 158);
INSERT INTO estados VALUES (2594, 'Namaland', 158);
INSERT INTO estados VALUES (2595, 'Ohangwena', 158);
INSERT INTO estados VALUES (2596, 'Okahandja', 158);
INSERT INTO estados VALUES (2597, 'Okavango', 158);
INSERT INTO estados VALUES (2598, 'Omaheke', 158);
INSERT INTO estados VALUES (2599, 'Omaruru', 158);
INSERT INTO estados VALUES (2600, 'Omusati', 158);
INSERT INTO estados VALUES (2601, 'Oshana', 158);
INSERT INTO estados VALUES (2602, 'Oshikoto', 158);
INSERT INTO estados VALUES (2603, 'Otjiwarongo', 158);
INSERT INTO estados VALUES (2604, 'Otjozondjupa', 158);
INSERT INTO estados VALUES (2605, 'Outjo', 158);
INSERT INTO estados VALUES (2606, 'Owambo', 158);
INSERT INTO estados VALUES (2607, 'Rehoboth', 158);
INSERT INTO estados VALUES (2608, 'Swakopmund', 158);
INSERT INTO estados VALUES (2609, 'Tsumeb', 158);
INSERT INTO estados VALUES (2610, 'Windhoek', 158);
INSERT INTO estados VALUES (2611, 'Aiwo', 159);
INSERT INTO estados VALUES (2612, 'Anabar', 159);
INSERT INTO estados VALUES (2613, 'Anetan', 159);
INSERT INTO estados VALUES (2614, 'Anibare', 159);
INSERT INTO estados VALUES (2615, 'Baiti', 159);
INSERT INTO estados VALUES (2616, 'Boe', 159);
INSERT INTO estados VALUES (2617, 'Buada', 159);
INSERT INTO estados VALUES (2618, 'Denigomodu', 159);
INSERT INTO estados VALUES (2619, 'Ewa', 159);
INSERT INTO estados VALUES (2620, 'Ijuw', 159);
INSERT INTO estados VALUES (2621, 'Meneng', 159);
INSERT INTO estados VALUES (2622, 'Nibok', 159);
INSERT INTO estados VALUES (2623, 'Uaboe', 159);
INSERT INTO estados VALUES (2624, 'Yaren', 159);
INSERT INTO estados VALUES (2625, 'Bagmati', 160);
INSERT INTO estados VALUES (2626, 'Bheri', 160);
INSERT INTO estados VALUES (2627, 'Bagmati Zone', 160);
INSERT INTO estados VALUES (2628, 'Dhawalagiri', 160);
INSERT INTO estados VALUES (2629, 'Gandaki', 160);
INSERT INTO estados VALUES (2630, 'Janakpur', 160);
INSERT INTO estados VALUES (2631, 'Karnali', 160);
INSERT INTO estados VALUES (2632, 'Kosi', 160);
INSERT INTO estados VALUES (2633, 'Lumbini', 160);
INSERT INTO estados VALUES (2634, 'Mahakali', 160);
INSERT INTO estados VALUES (2635, 'Mechi', 160);
INSERT INTO estados VALUES (2636, 'Narayani', 160);
INSERT INTO estados VALUES (2637, 'Rapti', 160);
INSERT INTO estados VALUES (2638, 'Sagarmatha', 160);
INSERT INTO estados VALUES (2639, 'Seti', 160);
INSERT INTO estados VALUES (2640, 'Boaco', 161);
INSERT INTO estados VALUES (2641, 'Carazo', 161);
INSERT INTO estados VALUES (2642, 'Chinandega', 161);
INSERT INTO estados VALUES (2643, 'Chontales', 161);
INSERT INTO estados VALUES (2644, 'Esteli', 161);
INSERT INTO estados VALUES (2645, 'Granada', 161);
INSERT INTO estados VALUES (2646, 'Jinotega', 161);
INSERT INTO estados VALUES (2647, 'Leon', 161);
INSERT INTO estados VALUES (2648, 'Madriz', 161);
INSERT INTO estados VALUES (2649, 'Managua', 161);
INSERT INTO estados VALUES (2650, 'Masaya', 161);
INSERT INTO estados VALUES (2651, 'Matagalpa', 161);
INSERT INTO estados VALUES (2652, 'Nueva Segovia', 161);
INSERT INTO estados VALUES (2653, 'Rio San Juan', 161);
INSERT INTO estados VALUES (2654, 'Rivas', 161);
INSERT INTO estados VALUES (2655, 'Zelaya', 161);
INSERT INTO estados VALUES (2656, 'Abia', 162);
INSERT INTO estados VALUES (2657, 'Abuja Capital Territory', 162);
INSERT INTO estados VALUES (2658, 'Adamawa', 162);
INSERT INTO estados VALUES (2659, 'Akwa Ibom', 162);
INSERT INTO estados VALUES (2660, 'Anambra', 162);
INSERT INTO estados VALUES (2661, 'Bauchi', 162);
INSERT INTO estados VALUES (2662, 'Bayelsa', 162);
INSERT INTO estados VALUES (2663, 'Benue', 162);
INSERT INTO estados VALUES (2664, 'Borno', 162);
INSERT INTO estados VALUES (2665, 'Cross River', 162);
INSERT INTO estados VALUES (2666, 'Delta', 162);
INSERT INTO estados VALUES (2667, 'Ebonyi', 162);
INSERT INTO estados VALUES (2668, 'Edo', 162);
INSERT INTO estados VALUES (2669, 'Ekiti', 162);
INSERT INTO estados VALUES (2670, 'Enugu', 162);
INSERT INTO estados VALUES (2671, 'Gombe', 162);
INSERT INTO estados VALUES (2672, 'Imo', 162);
INSERT INTO estados VALUES (2673, 'Jigawa', 162);
INSERT INTO estados VALUES (2674, 'Kaduna', 162);
INSERT INTO estados VALUES (2675, 'Kano', 162);
INSERT INTO estados VALUES (2676, 'Katsina', 162);
INSERT INTO estados VALUES (2677, 'Kebbi', 162);
INSERT INTO estados VALUES (2678, 'Kogi', 162);
INSERT INTO estados VALUES (2679, 'Kwara', 162);
INSERT INTO estados VALUES (2680, 'Lagos', 162);
INSERT INTO estados VALUES (2681, 'Nassarawa', 162);
INSERT INTO estados VALUES (2682, 'Niger', 162);
INSERT INTO estados VALUES (2683, 'Ogun', 162);
INSERT INTO estados VALUES (2684, 'Ondo', 162);
INSERT INTO estados VALUES (2685, 'Ondo', 162);
INSERT INTO estados VALUES (2686, 'Osun', 162);
INSERT INTO estados VALUES (2687, 'Oyo', 162);
INSERT INTO estados VALUES (2688, 'Plateau', 162);
INSERT INTO estados VALUES (2689, 'Rivers', 162);
INSERT INTO estados VALUES (2690, 'Rivers', 162);
INSERT INTO estados VALUES (2691, 'Sokoto', 162);
INSERT INTO estados VALUES (2692, 'Taraba', 162);
INSERT INTO estados VALUES (2693, 'Yobe', 162);
INSERT INTO estados VALUES (2694, 'Zamfara', 162);
INSERT INTO estados VALUES (2695, 'Niue (General)', 163);
INSERT INTO estados VALUES (2696, 'Norfolk Island (General)', 164);
INSERT INTO estados VALUES (2697, 'Northern Mariana Islands (General)', 165);
INSERT INTO estados VALUES (2698, 'Akershus', 166);
INSERT INTO estados VALUES (2699, 'Aust-Agder', 166);
INSERT INTO estados VALUES (2700, 'Buskerud', 166);
INSERT INTO estados VALUES (2701, 'Finnmark', 166);
INSERT INTO estados VALUES (2702, 'Hedmark', 166);
INSERT INTO estados VALUES (2703, 'Hordaland', 166);
INSERT INTO estados VALUES (2704, 'More og Romsdal', 166);
INSERT INTO estados VALUES (2705, 'Nord-Trondelag', 166);
INSERT INTO estados VALUES (2706, 'Nordland', 166);
INSERT INTO estados VALUES (2707, 'Oppland', 166);
INSERT INTO estados VALUES (2708, 'Oslo', 166);
INSERT INTO estados VALUES (2709, 'Ostfold', 166);
INSERT INTO estados VALUES (2710, 'Rogaland', 166);
INSERT INTO estados VALUES (2711, 'Sogn og Fjordane', 166);
INSERT INTO estados VALUES (2712, 'Sor-Trondelag', 166);
INSERT INTO estados VALUES (2713, 'Telemark', 166);
INSERT INTO estados VALUES (2714, 'Troms', 166);
INSERT INTO estados VALUES (2715, 'Vest-Agder', 166);
INSERT INTO estados VALUES (2716, 'Vestfold', 166);
INSERT INTO estados VALUES (2717, 'Nouvelle-Caledonie', 167);
INSERT INTO estados VALUES (2718, 'Akaroa', 168);
INSERT INTO estados VALUES (2719, 'Amuri', 168);
INSERT INTO estados VALUES (2720, 'Ashburton', 168);
INSERT INTO estados VALUES (2721, 'Bay of Islands', 168);
INSERT INTO estados VALUES (2722, 'Bruce', 168);
INSERT INTO estados VALUES (2723, 'Buller', 168);
INSERT INTO estados VALUES (2724, 'Chatham Islands', 168);
INSERT INTO estados VALUES (2725, 'Cheviot', 168);
INSERT INTO estados VALUES (2726, 'Clifton', 168);
INSERT INTO estados VALUES (2727, 'Clutha', 168);
INSERT INTO estados VALUES (2728, 'Cook', 168);
INSERT INTO estados VALUES (2729, 'Dannevirke', 168);
INSERT INTO estados VALUES (2730, 'Egmont', 168);
INSERT INTO estados VALUES (2731, 'Eketahuna', 168);
INSERT INTO estados VALUES (2732, 'Ellesmere', 168);
INSERT INTO estados VALUES (2733, 'Eltham', 168);
INSERT INTO estados VALUES (2734, 'Eyre', 168);
INSERT INTO estados VALUES (2735, 'Featherston', 168);
INSERT INTO estados VALUES (2736, 'Franklin', 168);
INSERT INTO estados VALUES (2737, 'Golden Bay', 168);
INSERT INTO estados VALUES (2738, 'Great Barrier Island', 168);
INSERT INTO estados VALUES (2739, 'Grey', 168);
INSERT INTO estados VALUES (2740, 'Hauraki Plains', 168);
INSERT INTO estados VALUES (2741, 'Hawera', 168);
INSERT INTO estados VALUES (2742, 'Hawkes Bay', 168);
INSERT INTO estados VALUES (2743, 'Heathcote', 168);
INSERT INTO estados VALUES (2744, 'Hikurangi', 168);
INSERT INTO estados VALUES (2745, 'Hobson', 168);
INSERT INTO estados VALUES (2746, 'Hokianga', 168);
INSERT INTO estados VALUES (2747, 'Horowhenua', 168);
INSERT INTO estados VALUES (2748, 'Hurunui', 168);
INSERT INTO estados VALUES (2749, 'Hutt', 168);
INSERT INTO estados VALUES (2750, 'Inangahua', 168);
INSERT INTO estados VALUES (2751, 'Inglewood', 168);
INSERT INTO estados VALUES (2752, 'Kaikoura', 168);
INSERT INTO estados VALUES (2753, 'Kairanga', 168);
INSERT INTO estados VALUES (2754, 'Kiwitea', 168);
INSERT INTO estados VALUES (2755, 'Lake', 168);
INSERT INTO estados VALUES (2756, 'Mackenzie', 168);
INSERT INTO estados VALUES (2757, 'Malvern', 168);
INSERT INTO estados VALUES (2758, 'Manaia', 168);
INSERT INTO estados VALUES (2759, 'Manawatu', 168);
INSERT INTO estados VALUES (2760, 'Mangonui', 168);
INSERT INTO estados VALUES (2761, 'Maniototo', 168);
INSERT INTO estados VALUES (2762, 'Marlborough', 168);
INSERT INTO estados VALUES (2763, 'Masterton', 168);
INSERT INTO estados VALUES (2764, 'Matamata', 168);
INSERT INTO estados VALUES (2765, 'Mount Herbert', 168);
INSERT INTO estados VALUES (2766, 'Ohinemuri', 168);
INSERT INTO estados VALUES (2767, 'Opotiki', 168);
INSERT INTO estados VALUES (2768, 'Oroua', 168);
INSERT INTO estados VALUES (2769, 'Otamatea', 168);
INSERT INTO estados VALUES (2770, 'Otorohanga', 168);
INSERT INTO estados VALUES (2771, 'Oxford', 168);
INSERT INTO estados VALUES (2772, 'Pahiatua', 168);
INSERT INTO estados VALUES (2773, 'Paparua', 168);
INSERT INTO estados VALUES (2774, 'Patea', 168);
INSERT INTO estados VALUES (2775, 'Piako', 168);
INSERT INTO estados VALUES (2776, 'Pohangina', 168);
INSERT INTO estados VALUES (2777, 'Raglan', 168);
INSERT INTO estados VALUES (2778, 'Rangiora', 168);
INSERT INTO estados VALUES (2779, 'Rangitikei', 168);
INSERT INTO estados VALUES (2780, 'Rodney', 168);
INSERT INTO estados VALUES (2781, 'Rotorua', 168);
INSERT INTO estados VALUES (2782, 'Runanga', 168);
INSERT INTO estados VALUES (2783, 'Saint Kilda', 168);
INSERT INTO estados VALUES (2784, 'Silverpeaks', 168);
INSERT INTO estados VALUES (2785, 'Southland', 168);
INSERT INTO estados VALUES (2786, 'Stewart Island', 168);
INSERT INTO estados VALUES (2787, 'Stratford', 168);
INSERT INTO estados VALUES (2788, 'Strathallan', 168);
INSERT INTO estados VALUES (2789, 'Taranaki', 168);
INSERT INTO estados VALUES (2790, 'Taumarunui', 168);
INSERT INTO estados VALUES (2791, 'Taupo', 168);
INSERT INTO estados VALUES (2792, 'Tauranga', 168);
INSERT INTO estados VALUES (2793, 'Thames-Coromandel', 168);
INSERT INTO estados VALUES (2794, 'Tuapeka', 168);
INSERT INTO estados VALUES (2795, 'Vincent', 168);
INSERT INTO estados VALUES (2796, 'Waiapu', 168);
INSERT INTO estados VALUES (2797, 'Waiheke', 168);
INSERT INTO estados VALUES (2798, 'Waihemo', 168);
INSERT INTO estados VALUES (2799, 'Waikato', 168);
INSERT INTO estados VALUES (2800, 'Waikohu', 168);
INSERT INTO estados VALUES (2801, 'Waimairi', 168);
INSERT INTO estados VALUES (2802, 'Waimarino', 168);
INSERT INTO estados VALUES (2803, 'Waimate', 168);
INSERT INTO estados VALUES (2804, 'Waimate West', 168);
INSERT INTO estados VALUES (2805, 'Waimea', 168);
INSERT INTO estados VALUES (2806, 'Waipa', 168);
INSERT INTO estados VALUES (2807, 'Waipawa', 168);
INSERT INTO estados VALUES (2808, 'Waipukurau', 168);
INSERT INTO estados VALUES (2809, 'Wairarapa South', 168);
INSERT INTO estados VALUES (2810, 'Wairewa', 168);
INSERT INTO estados VALUES (2811, 'Wairoa', 168);
INSERT INTO estados VALUES (2812, 'Waitaki', 168);
INSERT INTO estados VALUES (2813, 'Waitomo', 168);
INSERT INTO estados VALUES (2814, 'Waitotara', 168);
INSERT INTO estados VALUES (2815, 'Wallace', 168);
INSERT INTO estados VALUES (2816, 'Wanganui', 168);
INSERT INTO estados VALUES (2817, 'Waverley', 168);
INSERT INTO estados VALUES (2818, 'Westland', 168);
INSERT INTO estados VALUES (2819, 'Whakatane', 168);
INSERT INTO estados VALUES (2820, 'Whangarei', 168);
INSERT INTO estados VALUES (2821, 'Whangaroa', 168);
INSERT INTO estados VALUES (2822, 'Woodville', 168);
INSERT INTO estados VALUES (2823, 'Agadez', 169);
INSERT INTO estados VALUES (2824, 'Diffa', 169);
INSERT INTO estados VALUES (2825, 'Dosso', 169);
INSERT INTO estados VALUES (2826, 'Maradi', 169);
INSERT INTO estados VALUES (2827, 'Niamey', 169);
INSERT INTO estados VALUES (2828, 'Tahoua', 169);
INSERT INTO estados VALUES (2829, 'Zinder', 169);
INSERT INTO estados VALUES (2830, 'Ad Dakhiliyah', 170);
INSERT INTO estados VALUES (2831, 'Al Batinah', 170);
INSERT INTO estados VALUES (2832, 'Al Wusta', 170);
INSERT INTO estados VALUES (2833, 'Ash Sharqiyah', 170);
INSERT INTO estados VALUES (2834, 'Az Zahirah', 170);
INSERT INTO estados VALUES (2835, 'Masqat', 170);
INSERT INTO estados VALUES (2836, 'Musandam', 170);
INSERT INTO estados VALUES (2837, 'Zufar', 170);
INSERT INTO estados VALUES (2838, 'Azad Kashmir', 171);
INSERT INTO estados VALUES (2839, 'Balochistan', 171);
INSERT INTO estados VALUES (2840, 'Federally Administered Tribal Areas', 171);
INSERT INTO estados VALUES (2841, 'Islamabad', 171);
INSERT INTO estados VALUES (2842, 'North-West Frontier', 171);
INSERT INTO estados VALUES (2843, 'Northern Areas', 171);
INSERT INTO estados VALUES (2844, 'Punjab', 171);
INSERT INTO estados VALUES (2845, 'Sindh', 171);
INSERT INTO estados VALUES (2846, 'Palau (General)', 172);
INSERT INTO estados VALUES (2847, 'Palestinian Territory (General)', 173);
INSERT INTO estados VALUES (2848, 'Bocas del Toro', 174);
INSERT INTO estados VALUES (2849, 'Chiriqui', 174);
INSERT INTO estados VALUES (2850, 'Cocle', 174);
INSERT INTO estados VALUES (2851, 'Colon', 174);
INSERT INTO estados VALUES (2852, 'Darien', 174);
INSERT INTO estados VALUES (2853, 'Herrera', 174);
INSERT INTO estados VALUES (2854, 'Los Santos', 174);
INSERT INTO estados VALUES (2855, 'Panama', 174);
INSERT INTO estados VALUES (2856, 'San Blas', 174);
INSERT INTO estados VALUES (2857, 'Veraguas', 174);
INSERT INTO estados VALUES (2858, 'Central', 175);
INSERT INTO estados VALUES (2859, 'Chimbu', 175);
INSERT INTO estados VALUES (2860, 'East New Britain', 175);
INSERT INTO estados VALUES (2861, 'East Sepik', 175);
INSERT INTO estados VALUES (2862, 'Eastern Highlands', 175);
INSERT INTO estados VALUES (2863, 'Enga', 175);
INSERT INTO estados VALUES (2864, 'Gulf', 175);
INSERT INTO estados VALUES (2865, 'Madang', 175);
INSERT INTO estados VALUES (2866, 'Manus', 175);
INSERT INTO estados VALUES (2867, 'Milne Bay', 175);
INSERT INTO estados VALUES (2868, 'Morobe', 175);
INSERT INTO estados VALUES (2869, 'National Capital', 175);
INSERT INTO estados VALUES (2870, 'New Ireland', 175);
INSERT INTO estados VALUES (2871, 'North Solomons', 175);
INSERT INTO estados VALUES (2872, 'Northern', 175);
INSERT INTO estados VALUES (2873, 'Sandaun', 175);
INSERT INTO estados VALUES (2874, 'Southern Highlands', 175);
INSERT INTO estados VALUES (2875, 'West New Britain', 175);
INSERT INTO estados VALUES (2876, 'Western', 175);
INSERT INTO estados VALUES (2877, 'Western Highlands', 175);
INSERT INTO estados VALUES (2878, 'Alto Paraguay', 176);
INSERT INTO estados VALUES (2879, 'Alto Parana', 176);
INSERT INTO estados VALUES (2880, 'Amambay', 176);
INSERT INTO estados VALUES (2881, 'Boqueron', 176);
INSERT INTO estados VALUES (2882, 'Caaguazu', 176);
INSERT INTO estados VALUES (2883, 'Caazapa', 176);
INSERT INTO estados VALUES (2884, 'Canindeyu', 176);
INSERT INTO estados VALUES (2885, 'Central', 176);
INSERT INTO estados VALUES (2886, 'Chaco', 176);
INSERT INTO estados VALUES (2887, 'Concepcion', 176);
INSERT INTO estados VALUES (2888, 'Cordillera', 176);
INSERT INTO estados VALUES (2889, 'Guaira', 176);
INSERT INTO estados VALUES (2890, 'Itapua', 176);
INSERT INTO estados VALUES (2891, 'Misiones', 176);
INSERT INTO estados VALUES (2892, 'Neembucu', 176);
INSERT INTO estados VALUES (2893, 'Nueva Asuncion', 176);
INSERT INTO estados VALUES (2894, 'Paraguari', 176);
INSERT INTO estados VALUES (2895, 'Presidente Hayes', 176);
INSERT INTO estados VALUES (2896, 'San Pedro', 176);
INSERT INTO estados VALUES (2897, 'Amazonas', 177);
INSERT INTO estados VALUES (2898, 'Ancash', 177);
INSERT INTO estados VALUES (2899, 'Apurimac', 177);
INSERT INTO estados VALUES (2900, 'Arequipa', 177);
INSERT INTO estados VALUES (2901, 'Ayacucho', 177);
INSERT INTO estados VALUES (2902, 'Cajamarca', 177);
INSERT INTO estados VALUES (2903, 'Callao', 177);
INSERT INTO estados VALUES (2904, 'Cusco', 177);
INSERT INTO estados VALUES (2905, 'Huancavelica', 177);
INSERT INTO estados VALUES (2906, 'Huanuco', 177);
INSERT INTO estados VALUES (2907, 'Ica', 177);
INSERT INTO estados VALUES (2908, 'Junin', 177);
INSERT INTO estados VALUES (2909, 'La Libertad', 177);
INSERT INTO estados VALUES (2910, 'Lambayeque', 177);
INSERT INTO estados VALUES (2911, 'Lima', 177);
INSERT INTO estados VALUES (2912, 'Loreto', 177);
INSERT INTO estados VALUES (2913, 'Madre de Dios', 177);
INSERT INTO estados VALUES (2914, 'Moquegua', 177);
INSERT INTO estados VALUES (2915, 'Pasco', 177);
INSERT INTO estados VALUES (2916, 'Piura', 177);
INSERT INTO estados VALUES (2917, 'Puno', 177);
INSERT INTO estados VALUES (2918, 'San Martin', 177);
INSERT INTO estados VALUES (2919, 'Tacna', 177);
INSERT INTO estados VALUES (2920, 'Tumbes', 177);
INSERT INTO estados VALUES (2921, 'Ucayali', 177);
INSERT INTO estados VALUES (2922, 'Pitcairn (General)', 178);
INSERT INTO estados VALUES (2923, 'Biala Podlaska', 179);
INSERT INTO estados VALUES (2924, 'Bialystok', 179);
INSERT INTO estados VALUES (2925, 'Bielsko', 179);
INSERT INTO estados VALUES (2926, 'Bydgoszcz', 179);
INSERT INTO estados VALUES (2927, 'Chelm', 179);
INSERT INTO estados VALUES (2928, 'Ciechanow', 179);
INSERT INTO estados VALUES (2929, 'Czestochowa', 179);
INSERT INTO estados VALUES (2930, 'Dolnoslaskie', 179);
INSERT INTO estados VALUES (2931, 'Elblag', 179);
INSERT INTO estados VALUES (2932, 'Gdansk', 179);
INSERT INTO estados VALUES (2933, 'Gorzow', 179);
INSERT INTO estados VALUES (2934, 'Jelenia Gora', 179);
INSERT INTO estados VALUES (2935, 'Kalisz', 179);
INSERT INTO estados VALUES (2936, 'Katowice', 179);
INSERT INTO estados VALUES (2937, 'Kielce', 179);
INSERT INTO estados VALUES (2938, 'Konin', 179);
INSERT INTO estados VALUES (2939, 'Koszalin', 179);
INSERT INTO estados VALUES (2940, 'Krakow', 179);
INSERT INTO estados VALUES (2941, 'Krosno', 179);
INSERT INTO estados VALUES (2942, 'Kujawsko-Pomorskie', 179);
INSERT INTO estados VALUES (2943, 'Legnica', 179);
INSERT INTO estados VALUES (2944, 'Leszno', 179);
INSERT INTO estados VALUES (2945, 'Lodz', 179);
INSERT INTO estados VALUES (2946, 'Lodzkie', 179);
INSERT INTO estados VALUES (2947, 'Lomza', 179);
INSERT INTO estados VALUES (2948, 'Lubelskie', 179);
INSERT INTO estados VALUES (2949, 'Lublin', 179);
INSERT INTO estados VALUES (2950, 'Lubuskie', 179);
INSERT INTO estados VALUES (2951, 'Malopolskie', 179);
INSERT INTO estados VALUES (2952, 'Mazowieckie', 179);
INSERT INTO estados VALUES (2953, 'Nowy Sacz', 179);
INSERT INTO estados VALUES (2954, 'Olsztyn', 179);
INSERT INTO estados VALUES (2955, 'Opole', 179);
INSERT INTO estados VALUES (2956, 'Opolskie', 179);
INSERT INTO estados VALUES (2957, 'Ostroleka', 179);
INSERT INTO estados VALUES (2958, 'Pila', 179);
INSERT INTO estados VALUES (2959, 'Piotrkow', 179);
INSERT INTO estados VALUES (2960, 'Plock', 179);
INSERT INTO estados VALUES (2961, 'Podkarpackie', 179);
INSERT INTO estados VALUES (2962, 'Podlaskie', 179);
INSERT INTO estados VALUES (2963, 'Pomorskie', 179);
INSERT INTO estados VALUES (2964, 'Poznan', 179);
INSERT INTO estados VALUES (2965, 'Przemysl', 179);
INSERT INTO estados VALUES (2966, 'Radom', 179);
INSERT INTO estados VALUES (2967, 'Rzeszow', 179);
INSERT INTO estados VALUES (2968, 'Siedlce', 179);
INSERT INTO estados VALUES (2969, 'Sieradz', 179);
INSERT INTO estados VALUES (2970, 'Skierniewice', 179);
INSERT INTO estados VALUES (2971, 'Slaskie', 179);
INSERT INTO estados VALUES (2972, 'Slupsk', 179);
INSERT INTO estados VALUES (2973, 'Suwalki', 179);
INSERT INTO estados VALUES (2974, 'Swietokrzyskie', 179);
INSERT INTO estados VALUES (2975, 'Szczecin', 179);
INSERT INTO estados VALUES (2976, 'Tarnobrzeg', 179);
INSERT INTO estados VALUES (2977, 'Tarnow', 179);
INSERT INTO estados VALUES (2978, 'Torun', 179);
INSERT INTO estados VALUES (2979, 'Walbrzych', 179);
INSERT INTO estados VALUES (2980, 'Warminsko-Mazurskie', 179);
INSERT INTO estados VALUES (2981, 'Warszawa', 179);
INSERT INTO estados VALUES (2982, 'Wielkopolskie', 179);
INSERT INTO estados VALUES (2983, 'Wloclawek', 179);
INSERT INTO estados VALUES (2984, 'Wroclaw', 179);
INSERT INTO estados VALUES (2985, 'Zachodniopomorskie', 179);
INSERT INTO estados VALUES (2986, 'Zamosc', 179);
INSERT INTO estados VALUES (2987, 'Zielona Gora', 179);
INSERT INTO estados VALUES (2988, 'Aveiro', 180);
INSERT INTO estados VALUES (2989, 'Azores', 180);
INSERT INTO estados VALUES (2990, 'Beja', 180);
INSERT INTO estados VALUES (2991, 'Braga', 180);
INSERT INTO estados VALUES (2992, 'Braganca', 180);
INSERT INTO estados VALUES (2993, 'Castelo Branco', 180);
INSERT INTO estados VALUES (2994, 'Coimbra', 180);
INSERT INTO estados VALUES (2995, 'Evora', 180);
INSERT INTO estados VALUES (2996, 'Faro', 180);
INSERT INTO estados VALUES (2997, 'Guarda', 180);
INSERT INTO estados VALUES (2998, 'Leiria', 180);
INSERT INTO estados VALUES (2999, 'Lisboa', 180);
INSERT INTO estados VALUES (3000, 'Madeira', 180);
INSERT INTO estados VALUES (3001, 'Portalegre', 180);
INSERT INTO estados VALUES (3002, 'Porto', 180);
INSERT INTO estados VALUES (3003, 'Santarem', 180);
INSERT INTO estados VALUES (3004, 'Setubal', 180);
INSERT INTO estados VALUES (3005, 'Viana do Castelo', 180);
INSERT INTO estados VALUES (3006, 'Vila Real', 180);
INSERT INTO estados VALUES (3007, 'Viseu', 180);
INSERT INTO estados VALUES (3008, 'Puerto Rico (General)', 181);
INSERT INTO estados VALUES (3009, 'Ad Dawhah', 182);
INSERT INTO estados VALUES (3010, 'Al Ghuwariyah', 182);
INSERT INTO estados VALUES (3011, 'Al Jumaliyah', 182);
INSERT INTO estados VALUES (3012, 'Al Khawr', 182);
INSERT INTO estados VALUES (3013, 'Al Wakrah', 182);
INSERT INTO estados VALUES (3014, 'Al Wakrah Municipality', 182);
INSERT INTO estados VALUES (3015, 'Ar Rayyan', 182);
INSERT INTO estados VALUES (3016, 'Jariyan al Batnah', 182);
INSERT INTO estados VALUES (3017, 'Madinat ach Shamal', 182);
INSERT INTO estados VALUES (3018, 'Umm Said', 182);
INSERT INTO estados VALUES (3019, 'Umm Salal', 182);
INSERT INTO estados VALUES (3020, 'Aberdeen City', 183);
INSERT INTO estados VALUES (3021, 'Aberdeenshire', 183);
INSERT INTO estados VALUES (3022, 'Angus', 183);
INSERT INTO estados VALUES (3023, 'Antrim', 183);
INSERT INTO estados VALUES (3024, 'Ards', 183);
INSERT INTO estados VALUES (3025, 'Argyll and Bute', 183);
INSERT INTO estados VALUES (3026, 'Armagh', 183);
INSERT INTO estados VALUES (3027, 'Avon', 183);
INSERT INTO estados VALUES (3028, 'Ballymena', 183);
INSERT INTO estados VALUES (3029, 'Ballymoney', 183);
INSERT INTO estados VALUES (3030, 'Banbridge', 183);
INSERT INTO estados VALUES (3031, 'Barking and Dagenham', 183);
INSERT INTO estados VALUES (3032, 'Barnet', 183);
INSERT INTO estados VALUES (3033, 'Barnsley', 183);
INSERT INTO estados VALUES (3034, 'Bath and North East Somerset', 183);
INSERT INTO estados VALUES (3035, 'Bedfordshire', 183);
INSERT INTO estados VALUES (3036, 'Belfast', 183);
INSERT INTO estados VALUES (3037, 'Berkshire', 183);
INSERT INTO estados VALUES (3038, 'Bexley', 183);
INSERT INTO estados VALUES (3039, 'Birmingham', 183);
INSERT INTO estados VALUES (3040, 'Blackburn with Darwen', 183);
INSERT INTO estados VALUES (3041, 'Blackpool', 183);
INSERT INTO estados VALUES (3042, 'Blaenau Gwent', 183);
INSERT INTO estados VALUES (3043, 'Bolton', 183);
INSERT INTO estados VALUES (3044, 'Bournemouth', 183);
INSERT INTO estados VALUES (3045, 'Bracknell Forest', 183);
INSERT INTO estados VALUES (3046, 'Bradford', 183);
INSERT INTO estados VALUES (3047, 'Brent', 183);
INSERT INTO estados VALUES (3048, 'Bridgend', 183);
INSERT INTO estados VALUES (3049, 'Brighton and Hove', 183);
INSERT INTO estados VALUES (3050, 'Bristol, City of', 183);
INSERT INTO estados VALUES (3051, 'Bromley', 183);
INSERT INTO estados VALUES (3052, 'Buckinghamshire', 183);
INSERT INTO estados VALUES (3053, 'Bury', 183);
INSERT INTO estados VALUES (3054, 'Caerphilly', 183);
INSERT INTO estados VALUES (3055, 'Calderdale', 183);
INSERT INTO estados VALUES (3056, 'Cambridgeshire', 183);
INSERT INTO estados VALUES (3057, 'Camden', 183);
INSERT INTO estados VALUES (3058, 'Cardiff', 183);
INSERT INTO estados VALUES (3059, 'Carmarthenshire', 183);
INSERT INTO estados VALUES (3060, 'Carrickfergus', 183);
INSERT INTO estados VALUES (3061, 'Castlereagh', 183);
INSERT INTO estados VALUES (3062, 'Central', 183);
INSERT INTO estados VALUES (3063, 'Ceredigion', 183);
INSERT INTO estados VALUES (3064, 'Cheshire', 183);
INSERT INTO estados VALUES (3065, 'Clackmannanshire', 183);
INSERT INTO estados VALUES (3066, 'Cleveland', 183);
INSERT INTO estados VALUES (3067, 'Clwyd', 183);
INSERT INTO estados VALUES (3068, 'Coleraine', 183);
INSERT INTO estados VALUES (3069, 'Conwy', 183);
INSERT INTO estados VALUES (3070, 'Cookstown', 183);
INSERT INTO estados VALUES (3071, 'Cornwall', 183);
INSERT INTO estados VALUES (3072, 'Coventry', 183);
INSERT INTO estados VALUES (3073, 'Craigavon', 183);
INSERT INTO estados VALUES (3074, 'Croydon', 183);
INSERT INTO estados VALUES (3075, 'Cumbria', 183);
INSERT INTO estados VALUES (3076, 'Darlington', 183);
INSERT INTO estados VALUES (3077, 'Denbighshire', 183);
INSERT INTO estados VALUES (3078, 'Derby', 183);
INSERT INTO estados VALUES (3079, 'Derbyshire', 183);
INSERT INTO estados VALUES (3080, 'Derry', 183);
INSERT INTO estados VALUES (3081, 'Devon', 183);
INSERT INTO estados VALUES (3082, 'Doncaster', 183);
INSERT INTO estados VALUES (3083, 'Dorset', 183);
INSERT INTO estados VALUES (3084, 'Down', 183);
INSERT INTO estados VALUES (3085, 'Dudley', 183);
INSERT INTO estados VALUES (3086, 'Dumfries and Galloway', 183);
INSERT INTO estados VALUES (3087, 'Dundee City', 183);
INSERT INTO estados VALUES (3088, 'Dungannon', 183);
INSERT INTO estados VALUES (3089, 'Durham', 183);
INSERT INTO estados VALUES (3090, 'Dyfed', 183);
INSERT INTO estados VALUES (3091, 'Ealing', 183);
INSERT INTO estados VALUES (3092, 'East Ayrshire', 183);
INSERT INTO estados VALUES (3093, 'East Dunbartonshire', 183);
INSERT INTO estados VALUES (3094, 'East Lothian', 183);
INSERT INTO estados VALUES (3095, 'East Renfrewshire', 183);
INSERT INTO estados VALUES (3096, 'East Riding of Yorkshire', 183);
INSERT INTO estados VALUES (3097, 'East Sussex', 183);
INSERT INTO estados VALUES (3098, 'Edinburgh, City of', 183);
INSERT INTO estados VALUES (3099, 'Eilean Siar', 183);
INSERT INTO estados VALUES (3100, 'Enfield', 183);
INSERT INTO estados VALUES (3101, 'Essex', 183);
INSERT INTO estados VALUES (3102, 'Falkirk', 183);
INSERT INTO estados VALUES (3103, 'Fermanagh', 183);
INSERT INTO estados VALUES (3104, 'Fife', 183);
INSERT INTO estados VALUES (3105, 'Flintshire', 183);
INSERT INTO estados VALUES (3106, 'Gateshead', 183);
INSERT INTO estados VALUES (3107, 'Glasgow City', 183);
INSERT INTO estados VALUES (3108, 'Gloucestershire', 183);
INSERT INTO estados VALUES (3109, 'Grampian', 183);
INSERT INTO estados VALUES (3110, 'Greater London', 183);
INSERT INTO estados VALUES (3111, 'Greater Manchester', 183);
INSERT INTO estados VALUES (3112, 'Greenwich', 183);
INSERT INTO estados VALUES (3113, 'Gwent', 183);
INSERT INTO estados VALUES (3114, 'Gwynedd', 183);
INSERT INTO estados VALUES (3115, 'Hackney', 183);
INSERT INTO estados VALUES (3116, 'Halton', 183);
INSERT INTO estados VALUES (3117, 'Hammersmith and Fulham', 183);
INSERT INTO estados VALUES (3118, 'Hampshire', 183);
INSERT INTO estados VALUES (3119, 'Haringey', 183);
INSERT INTO estados VALUES (3120, 'Harrow', 183);
INSERT INTO estados VALUES (3121, 'Hartlepool', 183);
INSERT INTO estados VALUES (3122, 'Havering', 183);
INSERT INTO estados VALUES (3123, 'Hereford and Worcester', 183);
INSERT INTO estados VALUES (3124, 'Herefordshire', 183);
INSERT INTO estados VALUES (3125, 'Hertford', 183);
INSERT INTO estados VALUES (3126, 'Highland', 183);
INSERT INTO estados VALUES (3127, 'Hillingdon', 183);
INSERT INTO estados VALUES (3128, 'Hounslow', 183);
INSERT INTO estados VALUES (3129, 'Humberside', 183);
INSERT INTO estados VALUES (3130, 'Inverclyde', 183);
INSERT INTO estados VALUES (3131, 'Isle of Anglesey', 183);
INSERT INTO estados VALUES (3132, 'Isle of Wight', 183);
INSERT INTO estados VALUES (3133, 'Islington', 183);
INSERT INTO estados VALUES (3134, 'Kensington and Chelsea', 183);
INSERT INTO estados VALUES (3135, 'Kent', 183);
INSERT INTO estados VALUES (3136, 'Kingston upon Hull, City of', 183);
INSERT INTO estados VALUES (3137, 'Kingston upon Thames', 183);
INSERT INTO estados VALUES (3138, 'Kirklees', 183);
INSERT INTO estados VALUES (3139, 'Knowsley', 183);
INSERT INTO estados VALUES (3140, 'Lambeth', 183);
INSERT INTO estados VALUES (3141, 'Lancashire', 183);
INSERT INTO estados VALUES (3142, 'Larne', 183);
INSERT INTO estados VALUES (3143, 'Leeds', 183);
INSERT INTO estados VALUES (3144, 'Leicester', 183);
INSERT INTO estados VALUES (3145, 'Leicestershire', 183);
INSERT INTO estados VALUES (3146, 'Lewisham', 183);
INSERT INTO estados VALUES (3147, 'Limavady', 183);
INSERT INTO estados VALUES (3148, 'Lincolnshire', 183);
INSERT INTO estados VALUES (3149, 'Lisburn', 183);
INSERT INTO estados VALUES (3150, 'Liverpool', 183);
INSERT INTO estados VALUES (3151, 'London, City of', 183);
INSERT INTO estados VALUES (3152, 'Lothian', 183);
INSERT INTO estados VALUES (3153, 'Luton', 183);
INSERT INTO estados VALUES (3154, 'Magherafelt', 183);
INSERT INTO estados VALUES (3155, 'Manchester', 183);
INSERT INTO estados VALUES (3156, 'Medway', 183);
INSERT INTO estados VALUES (3157, 'Merseyside', 183);
INSERT INTO estados VALUES (3158, 'Merthyr Tydfil', 183);
INSERT INTO estados VALUES (3159, 'Merton', 183);
INSERT INTO estados VALUES (3160, 'Mid Glamorgan', 183);
INSERT INTO estados VALUES (3161, 'Middlesbrough', 183);
INSERT INTO estados VALUES (3162, 'Midlothian', 183);
INSERT INTO estados VALUES (3163, 'Milton Keynes', 183);
INSERT INTO estados VALUES (3164, 'Monmouthshire', 183);
INSERT INTO estados VALUES (3165, 'Moray', 183);
INSERT INTO estados VALUES (3166, 'Moyle', 183);
INSERT INTO estados VALUES (3167, 'Neath Port Talbot', 183);
INSERT INTO estados VALUES (3168, 'Newcastle upon Tyne', 183);
INSERT INTO estados VALUES (3169, 'Newham', 183);
INSERT INTO estados VALUES (3170, 'Newport', 183);
INSERT INTO estados VALUES (3171, 'Newry and Mourne', 183);
INSERT INTO estados VALUES (3172, 'Newtownabbey', 183);
INSERT INTO estados VALUES (3173, 'Norfolk', 183);
INSERT INTO estados VALUES (3174, 'North Ayrshire', 183);
INSERT INTO estados VALUES (3175, 'North Down', 183);
INSERT INTO estados VALUES (3176, 'North East Lincolnshire', 183);
INSERT INTO estados VALUES (3177, 'North Lanarkshire', 183);
INSERT INTO estados VALUES (3178, 'North Lincolnshire', 183);
INSERT INTO estados VALUES (3179, 'North Somerset', 183);
INSERT INTO estados VALUES (3180, 'North Tyneside', 183);
INSERT INTO estados VALUES (3181, 'North Yorkshire', 183);
INSERT INTO estados VALUES (3182, 'Northamptonshire', 183);
INSERT INTO estados VALUES (3183, 'Northumberland', 183);
INSERT INTO estados VALUES (3184, 'Nottingham', 183);
INSERT INTO estados VALUES (3185, 'Nottinghamshire', 183);
INSERT INTO estados VALUES (3186, 'Oldham', 183);
INSERT INTO estados VALUES (3187, 'Omagh', 183);
INSERT INTO estados VALUES (3188, 'Orkney', 183);
INSERT INTO estados VALUES (3189, 'Oxfordshire', 183);
INSERT INTO estados VALUES (3190, 'Pembrokeshire', 183);
INSERT INTO estados VALUES (3191, 'Perth and Kinross', 183);
INSERT INTO estados VALUES (3192, 'Peterborough', 183);
INSERT INTO estados VALUES (3193, 'Plymouth', 183);
INSERT INTO estados VALUES (3194, 'Poole', 183);
INSERT INTO estados VALUES (3195, 'Portsmouth', 183);
INSERT INTO estados VALUES (3196, 'Powys', 183);
INSERT INTO estados VALUES (3197, 'Reading', 183);
INSERT INTO estados VALUES (3198, 'Redbridge', 183);
INSERT INTO estados VALUES (3199, 'Redcar and Cleveland', 183);
INSERT INTO estados VALUES (3200, 'Renfrewshire', 183);
INSERT INTO estados VALUES (3201, 'Rhondda Cynon Taff', 183);
INSERT INTO estados VALUES (3202, 'Richmond upon Thames', 183);
INSERT INTO estados VALUES (3203, 'Rochdale', 183);
INSERT INTO estados VALUES (3204, 'Rotherham', 183);
INSERT INTO estados VALUES (3205, 'Rutland', 183);
INSERT INTO estados VALUES (3206, 'Salford', 183);
INSERT INTO estados VALUES (3207, 'Sandwell', 183);
INSERT INTO estados VALUES (3208, 'Scottish Borders', 183);
INSERT INTO estados VALUES (3209, 'The Sefton', 183);
INSERT INTO estados VALUES (3210, 'Sheffield', 183);
INSERT INTO estados VALUES (3211, 'Shetland Islands', 183);
INSERT INTO estados VALUES (3212, 'Shropshire', 183);
INSERT INTO estados VALUES (3213, 'Slough', 183);
INSERT INTO estados VALUES (3214, 'Solihull', 183);
INSERT INTO estados VALUES (3215, 'Somerset', 183);
INSERT INTO estados VALUES (3216, 'South Ayrshire', 183);
INSERT INTO estados VALUES (3217, 'South Glamorgan', 183);
INSERT INTO estados VALUES (3218, 'South Gloucestershire', 183);
INSERT INTO estados VALUES (3219, 'South Lanarkshire', 183);
INSERT INTO estados VALUES (3220, 'South Tyneside', 183);
INSERT INTO estados VALUES (3221, 'South Yorkshire', 183);
INSERT INTO estados VALUES (3222, 'Southampton', 183);
INSERT INTO estados VALUES (3223, 'Southend-on-Sea', 183);
INSERT INTO estados VALUES (3224, 'Southwark', 183);
INSERT INTO estados VALUES (3225, 'St. Helens', 183);
INSERT INTO estados VALUES (3226, 'Staffordshire', 183);
INSERT INTO estados VALUES (3227, 'Stirling', 183);
INSERT INTO estados VALUES (3228, 'Stockport', 183);
INSERT INTO estados VALUES (3229, 'Stockton-on-Tees', 183);
INSERT INTO estados VALUES (3230, 'Stoke-on-Trent', 183);
INSERT INTO estados VALUES (3231, 'Strabane', 183);
INSERT INTO estados VALUES (3232, 'Strathclyde', 183);
INSERT INTO estados VALUES (3233, 'Suffolk', 183);
INSERT INTO estados VALUES (3234, 'Sunderland', 183);
INSERT INTO estados VALUES (3235, 'Surrey', 183);
INSERT INTO estados VALUES (3236, 'Sutton', 183);
INSERT INTO estados VALUES (3237, 'Swansea', 183);
INSERT INTO estados VALUES (3238, 'Swindon', 183);
INSERT INTO estados VALUES (3239, 'Tameside', 183);
INSERT INTO estados VALUES (3240, 'Tayside', 183);
INSERT INTO estados VALUES (3241, 'Telford and Wrekin', 183);
INSERT INTO estados VALUES (3242, 'Thurrock', 183);
INSERT INTO estados VALUES (3243, 'Torbay', 183);
INSERT INTO estados VALUES (3244, 'Torfaen', 183);
INSERT INTO estados VALUES (3245, 'Tower Hamlets', 183);
INSERT INTO estados VALUES (3246, 'Trafford', 183);
INSERT INTO estados VALUES (3247, 'Tyne and Wear', 183);
INSERT INTO estados VALUES (3248, 'Vale of Glamorgan, The', 183);
INSERT INTO estados VALUES (3249, 'Wakefield', 183);
INSERT INTO estados VALUES (3250, 'Walsall', 183);
INSERT INTO estados VALUES (3251, 'Waltham Forest', 183);
INSERT INTO estados VALUES (3252, 'Wandsworth', 183);
INSERT INTO estados VALUES (3253, 'Warrington', 183);
INSERT INTO estados VALUES (3254, 'Warwickshire', 183);
INSERT INTO estados VALUES (3255, 'West Berkshire', 183);
INSERT INTO estados VALUES (3256, 'West Dunbartonshire', 183);
INSERT INTO estados VALUES (3257, 'West Glamorgan', 183);
INSERT INTO estados VALUES (3258, 'West Lothian', 183);
INSERT INTO estados VALUES (3259, 'West Midlands', 183);
INSERT INTO estados VALUES (3260, 'West Sussex', 183);
INSERT INTO estados VALUES (3261, 'West Yorkshire', 183);
INSERT INTO estados VALUES (3262, 'Westminster', 183);
INSERT INTO estados VALUES (3263, 'Wigan', 183);
INSERT INTO estados VALUES (3264, 'Wiltshire', 183);
INSERT INTO estados VALUES (3265, 'Windsor and Maidenhead', 183);
INSERT INTO estados VALUES (3266, 'Wirral', 183);
INSERT INTO estados VALUES (3267, 'Wokingham', 183);
INSERT INTO estados VALUES (3268, 'Wolverhampton', 183);
INSERT INTO estados VALUES (3269, 'Worcestershire', 183);
INSERT INTO estados VALUES (3270, 'Wrexham', 183);
INSERT INTO estados VALUES (3271, 'York', 183);
INSERT INTO estados VALUES (3272, 'Bamingui-Bangoran', 184);
INSERT INTO estados VALUES (3273, 'Bangui', 184);
INSERT INTO estados VALUES (3274, 'Basse-Kotto', 184);
INSERT INTO estados VALUES (3275, 'Haut-Mbomou', 184);
INSERT INTO estados VALUES (3276, 'Haute-Kotto', 184);
INSERT INTO estados VALUES (3277, 'Kemo', 184);
INSERT INTO estados VALUES (3278, 'Lobaye', 184);
INSERT INTO estados VALUES (3279, 'Mambere-Kadei', 184);
INSERT INTO estados VALUES (3280, 'Mbomou', 184);
INSERT INTO estados VALUES (3281, 'Nana-Grebizi', 184);
INSERT INTO estados VALUES (3282, 'Nana-Mambere', 184);
INSERT INTO estados VALUES (3283, 'Ombella-Mpoko', 184);
INSERT INTO estados VALUES (3284, 'Ouaka', 184);
INSERT INTO estados VALUES (3285, 'Ouham', 184);
INSERT INTO estados VALUES (3286, 'Ouham-Pende', 184);
INSERT INTO estados VALUES (3287, 'Sangha-Mbaere', 184);
INSERT INTO estados VALUES (3288, 'Vakaga', 184);
INSERT INTO estados VALUES (3289, 'Blansko', 185);
INSERT INTO estados VALUES (3290, 'Breclav', 185);
INSERT INTO estados VALUES (3291, 'Hlavni Mesto Praha', 185);
INSERT INTO estados VALUES (3292, 'Hradec Kralove', 185);
INSERT INTO estados VALUES (3293, 'Jablonec nad Nisou', 185);
INSERT INTO estados VALUES (3294, 'Jiein', 185);
INSERT INTO estados VALUES (3295, 'Jihlava', 185);
INSERT INTO estados VALUES (3296, 'Jihocesky Kraj', 185);
INSERT INTO estados VALUES (3297, 'Jihomoravsky Kraj', 185);
INSERT INTO estados VALUES (3298, 'Karlovarsky Kraj', 185);
INSERT INTO estados VALUES (3299, 'Kolin', 185);
INSERT INTO estados VALUES (3300, 'Kralovehradecky Kraj', 185);
INSERT INTO estados VALUES (3301, 'Liberec', 185);
INSERT INTO estados VALUES (3302, 'Liberecky Kraj', 185);
INSERT INTO estados VALUES (3303, 'Melnik', 185);
INSERT INTO estados VALUES (3304, 'Mlada Boleslav', 185);
INSERT INTO estados VALUES (3305, 'Moravskoslezsky Kraj', 185);
INSERT INTO estados VALUES (3306, 'Nachod', 185);
INSERT INTO estados VALUES (3307, 'Nymburk', 185);
INSERT INTO estados VALUES (3308, 'Olomoucky Kraj', 185);
INSERT INTO estados VALUES (3309, 'Pardubice', 185);
INSERT INTO estados VALUES (3310, 'Pardubicky Kraj', 185);
INSERT INTO estados VALUES (3311, 'Plzensky Kraj', 185);
INSERT INTO estados VALUES (3312, 'Semily', 185);
INSERT INTO estados VALUES (3313, 'Stredocesky Kraj', 185);
INSERT INTO estados VALUES (3314, 'Trutnov', 185);
INSERT INTO estados VALUES (3315, 'Ustecky Kraj', 185);
INSERT INTO estados VALUES (3316, 'Vysocina', 185);
INSERT INTO estados VALUES (3317, 'Zlinsky Kraj', 185);
INSERT INTO estados VALUES (3318, 'Congo, The Democratic Republic of the (General)', 186);
INSERT INTO estados VALUES (3319, 'Azua', 187);
INSERT INTO estados VALUES (3320, 'Baoruco', 187);
INSERT INTO estados VALUES (3321, 'Barahona', 187);
INSERT INTO estados VALUES (3322, 'Dajabon', 187);
INSERT INTO estados VALUES (3323, 'Distrito Nacional', 187);
INSERT INTO estados VALUES (3324, 'Duarte', 187);
INSERT INTO estados VALUES (3325, 'El Seibo', 187);
INSERT INTO estados VALUES (3326, 'Elias Pina', 187);
INSERT INTO estados VALUES (3327, 'Espaillat', 187);
INSERT INTO estados VALUES (3328, 'Hato Mayor', 187);
INSERT INTO estados VALUES (3329, 'Independencia', 187);
INSERT INTO estados VALUES (3330, 'La Altagracia', 187);
INSERT INTO estados VALUES (3331, 'La Romana', 187);
INSERT INTO estados VALUES (3332, 'La Vega', 187);
INSERT INTO estados VALUES (3333, 'Maria Trinidad Sanchez', 187);
INSERT INTO estados VALUES (3334, 'Monsenor Nouel', 187);
INSERT INTO estados VALUES (3335, 'Monte Cristi', 187);
INSERT INTO estados VALUES (3336, 'Monte Plata', 187);
INSERT INTO estados VALUES (3337, 'Pedernales', 187);
INSERT INTO estados VALUES (3338, 'Peravia', 187);
INSERT INTO estados VALUES (3339, 'Puerto Plata', 187);
INSERT INTO estados VALUES (3340, 'Salcedo', 187);
INSERT INTO estados VALUES (3341, 'Samana', 187);
INSERT INTO estados VALUES (3342, 'San Cristobal', 187);
INSERT INTO estados VALUES (3343, 'San Juan', 187);
INSERT INTO estados VALUES (3344, 'San Pedro De Macoris', 187);
INSERT INTO estados VALUES (3345, 'Sanchez Ramirez', 187);
INSERT INTO estados VALUES (3346, 'Santiago', 187);
INSERT INTO estados VALUES (3347, 'Santiago Rodriguez', 187);
INSERT INTO estados VALUES (3348, 'Valverde', 187);
INSERT INTO estados VALUES (3349, 'Ardabil', 188);
INSERT INTO estados VALUES (3350, 'Azarbayjan-e Bakhtari', 188);
INSERT INTO estados VALUES (3351, 'Azarbayjan-e Khavari', 188);
INSERT INTO estados VALUES (3352, 'Bakhtaran', 188);
INSERT INTO estados VALUES (3353, 'Bushehr', 188);
INSERT INTO estados VALUES (3354, 'Chahar Mahall va Bakhtiari', 188);
INSERT INTO estados VALUES (3355, 'East Azarbaijan', 188);
INSERT INTO estados VALUES (3356, 'Esfahan', 188);
INSERT INTO estados VALUES (3357, 'Fars', 188);
INSERT INTO estados VALUES (3358, 'Gilan', 188);
INSERT INTO estados VALUES (3359, 'Golestan', 188);
INSERT INTO estados VALUES (3360, 'Hamadan', 188);
INSERT INTO estados VALUES (3361, 'Hormozgan', 188);
INSERT INTO estados VALUES (3362, 'Ilam', 188);
INSERT INTO estados VALUES (3363, 'Kerman', 188);
INSERT INTO estados VALUES (3364, 'Khorasan', 188);
INSERT INTO estados VALUES (3365, 'Khuzestan', 188);
INSERT INTO estados VALUES (3366, 'Kohkiluyeh va Buyer Ahmadi', 188);
INSERT INTO estados VALUES (3367, 'Kordestan', 188);
INSERT INTO estados VALUES (3368, 'Lorestan', 188);
INSERT INTO estados VALUES (3369, 'Markazi', 188);
INSERT INTO estados VALUES (3370, 'Markazi', 188);
INSERT INTO estados VALUES (3371, 'Mazandaran', 188);
INSERT INTO estados VALUES (3372, 'Mazandaran', 188);
INSERT INTO estados VALUES (3373, 'Qazvin', 188);
INSERT INTO estados VALUES (3374, 'Qom', 188);
INSERT INTO estados VALUES (3375, 'Semnan', 188);
INSERT INTO estados VALUES (3376, 'Sistan va Baluchestan', 188);
INSERT INTO estados VALUES (3377, 'Tehran', 188);
INSERT INTO estados VALUES (3378, 'Yazd', 188);
INSERT INTO estados VALUES (3379, 'Zanjan', 188);
INSERT INTO estados VALUES (3380, 'Zanjan', 188);
INSERT INTO estados VALUES (3381, 'Butare', 189);
INSERT INTO estados VALUES (3382, 'Byumba', 189);
INSERT INTO estados VALUES (3383, 'Cyangugu', 189);
INSERT INTO estados VALUES (3384, 'Gikongoro', 189);
INSERT INTO estados VALUES (3385, 'Gisenyi', 189);
INSERT INTO estados VALUES (3386, 'Gitarama', 189);
INSERT INTO estados VALUES (3387, 'Kibungo', 189);
INSERT INTO estados VALUES (3388, 'Kibuye', 189);
INSERT INTO estados VALUES (3389, 'Kigali', 189);
INSERT INTO estados VALUES (3390, 'Ruhengeri', 189);
INSERT INTO estados VALUES (3391, 'Alba', 190);
INSERT INTO estados VALUES (3392, 'Arad', 190);
INSERT INTO estados VALUES (3393, 'Arges', 190);
INSERT INTO estados VALUES (3394, 'Bacau', 190);
INSERT INTO estados VALUES (3395, 'Bihor', 190);
INSERT INTO estados VALUES (3396, 'Bistrita-Nasaud', 190);
INSERT INTO estados VALUES (3397, 'Botosani', 190);
INSERT INTO estados VALUES (3398, 'Braila', 190);
INSERT INTO estados VALUES (3399, 'Brasov', 190);
INSERT INTO estados VALUES (3400, 'Bucuresti', 190);
INSERT INTO estados VALUES (3401, 'Buzau', 190);
INSERT INTO estados VALUES (3402, 'Calarasi', 190);
INSERT INTO estados VALUES (3403, 'Caras-Severin', 190);
INSERT INTO estados VALUES (3404, 'Cluj', 190);
INSERT INTO estados VALUES (3405, 'Constanta', 190);
INSERT INTO estados VALUES (3406, 'Covasna', 190);
INSERT INTO estados VALUES (3407, 'Dambovita', 190);
INSERT INTO estados VALUES (3408, 'Dolj', 190);
INSERT INTO estados VALUES (3409, 'Galati', 190);
INSERT INTO estados VALUES (3410, 'Giurgiu', 190);
INSERT INTO estados VALUES (3411, 'Gorj', 190);
INSERT INTO estados VALUES (3412, 'Harghita', 190);
INSERT INTO estados VALUES (3413, 'Hunedoara', 190);
INSERT INTO estados VALUES (3414, 'Ialomita', 190);
INSERT INTO estados VALUES (3415, 'Iasi', 190);
INSERT INTO estados VALUES (3416, 'Ilfov', 190);
INSERT INTO estados VALUES (3417, 'Maramures', 190);
INSERT INTO estados VALUES (3418, 'Mehedinti', 190);
INSERT INTO estados VALUES (3419, 'Mures', 190);
INSERT INTO estados VALUES (3420, 'Neamt', 190);
INSERT INTO estados VALUES (3421, 'Olt', 190);
INSERT INTO estados VALUES (3422, 'Prahova', 190);
INSERT INTO estados VALUES (3423, 'Salaj', 190);
INSERT INTO estados VALUES (3424, 'Satu Mare', 190);
INSERT INTO estados VALUES (3425, 'Sibiu', 190);
INSERT INTO estados VALUES (3426, 'Suceava', 190);
INSERT INTO estados VALUES (3427, 'Teleorman', 190);
INSERT INTO estados VALUES (3428, 'Timis', 190);
INSERT INTO estados VALUES (3429, 'Tulcea', 190);
INSERT INTO estados VALUES (3430, 'Valcea', 190);
INSERT INTO estados VALUES (3431, 'Vaslui', 190);
INSERT INTO estados VALUES (3432, 'Vrancea', 190);
INSERT INTO estados VALUES (3433, 'Adygeya, Republic of', 191);
INSERT INTO estados VALUES (3434, 'Aginsky Buryatsky AO', 191);
INSERT INTO estados VALUES (3435, 'Altaisky krai', 191);
INSERT INTO estados VALUES (3436, 'Amur', 191);
INSERT INTO estados VALUES (3437, 'Arkhangel sk', 191);
INSERT INTO estados VALUES (3438, 'Astrakhan', 191);
INSERT INTO estados VALUES (3439, 'Bashkortostan', 191);
INSERT INTO estados VALUES (3440, 'Belgorod', 191);
INSERT INTO estados VALUES (3441, 'Bryansk', 191);
INSERT INTO estados VALUES (3442, 'Buryat', 191);
INSERT INTO estados VALUES (3443, 'Chechnya', 191);
INSERT INTO estados VALUES (3444, 'Chechnya Republic', 191);
INSERT INTO estados VALUES (3445, 'Chelyabinsk', 191);
INSERT INTO estados VALUES (3446, 'Chita', 191);
INSERT INTO estados VALUES (3447, 'Chukot', 191);
INSERT INTO estados VALUES (3448, 'Chuvashia', 191);
INSERT INTO estados VALUES (3449, 'Dagestan', 191);
INSERT INTO estados VALUES (3450, 'Evenk', 191);
INSERT INTO estados VALUES (3451, 'Gorno-Altay', 191);
INSERT INTO estados VALUES (3452, 'Ingush', 191);
INSERT INTO estados VALUES (3453, 'Irkutsk', 191);
INSERT INTO estados VALUES (3454, 'Ivanovo', 191);
INSERT INTO estados VALUES (3455, 'JA', 191);
INSERT INTO estados VALUES (3456, 'Kabardin-Balkar', 191);
INSERT INTO estados VALUES (3457, 'Kaliningrad', 191);
INSERT INTO estados VALUES (3458, 'Kalmyk', 191);
INSERT INTO estados VALUES (3459, 'Kaluga', 191);
INSERT INTO estados VALUES (3460, 'Kamchatka', 191);
INSERT INTO estados VALUES (3461, 'Karachay-Cherkess', 191);
INSERT INTO estados VALUES (3462, 'Karelia', 191);
INSERT INTO estados VALUES (3463, 'Kemerovo', 191);
INSERT INTO estados VALUES (3464, 'Khabarovsk', 191);
INSERT INTO estados VALUES (3465, 'Khakass', 191);
INSERT INTO estados VALUES (3466, 'Khanty-Mansiy', 191);
INSERT INTO estados VALUES (3467, 'Kirov', 191);
INSERT INTO estados VALUES (3468, 'Komi', 191);
INSERT INTO estados VALUES (3469, 'Komi-Permyak', 191);
INSERT INTO estados VALUES (3470, 'Koryak', 191);
INSERT INTO estados VALUES (3471, 'Kostroma', 191);
INSERT INTO estados VALUES (3472, 'Krasnodar', 191);
INSERT INTO estados VALUES (3473, 'Krasnoyarsk', 191);
INSERT INTO estados VALUES (3474, 'Kurgan', 191);
INSERT INTO estados VALUES (3475, 'Kursk', 191);
INSERT INTO estados VALUES (3476, 'Leningrad', 191);
INSERT INTO estados VALUES (3477, 'Lipetsk', 191);
INSERT INTO estados VALUES (3478, 'Magadan', 191);
INSERT INTO estados VALUES (3479, 'Mariy-El', 191);
INSERT INTO estados VALUES (3480, 'Mordovia', 191);
INSERT INTO estados VALUES (3481, 'Moscow City', 191);
INSERT INTO estados VALUES (3482, 'Moskva', 191);
INSERT INTO estados VALUES (3483, 'Murmansk', 191);
INSERT INTO estados VALUES (3484, 'Nenets', 191);
INSERT INTO estados VALUES (3485, 'Nizhegorod', 191);
INSERT INTO estados VALUES (3486, 'North Ossetia', 191);
INSERT INTO estados VALUES (3487, 'Novgorod', 191);
INSERT INTO estados VALUES (3488, 'Novosibirsk', 191);
INSERT INTO estados VALUES (3489, 'Omsk', 191);
INSERT INTO estados VALUES (3490, 'Orel', 191);
INSERT INTO estados VALUES (3491, 'Orenburg', 191);
INSERT INTO estados VALUES (3492, 'Penza', 191);
INSERT INTO estados VALUES (3493, 'Perm', 191);
INSERT INTO estados VALUES (3494, 'Primor ye', 191);
INSERT INTO estados VALUES (3495, 'Pskov', 191);
INSERT INTO estados VALUES (3496, 'Rostov', 191);
INSERT INTO estados VALUES (3497, 'Ryazan', 191);
INSERT INTO estados VALUES (3498, 'Saint Petersburg City', 191);
INSERT INTO estados VALUES (3499, 'Sakha', 191);
INSERT INTO estados VALUES (3500, 'Sakhalin', 191);
INSERT INTO estados VALUES (3501, 'Samara', 191);
INSERT INTO estados VALUES (3502, 'Saratov', 191);
INSERT INTO estados VALUES (3503, 'Smolensk', 191);
INSERT INTO estados VALUES (3504, 'Stavropol', 191);
INSERT INTO estados VALUES (3505, 'Sverdlovsk', 191);
INSERT INTO estados VALUES (3506, 'Tambovskaya oblast', 191);
INSERT INTO estados VALUES (3507, 'Tatarstan', 191);
INSERT INTO estados VALUES (3508, 'Taymyr', 191);
INSERT INTO estados VALUES (3509, 'Tomsk', 191);
INSERT INTO estados VALUES (3510, 'Tula', 191);
INSERT INTO estados VALUES (3511, 'Tuva', 191);
INSERT INTO estados VALUES (3512, 'Tver', 191);
INSERT INTO estados VALUES (3513, 'Tyumen', 191);
INSERT INTO estados VALUES (3514, 'Udmurt', 191);
INSERT INTO estados VALUES (3515, 'Ul yanovsk', 191);
INSERT INTO estados VALUES (3516, 'Ust-Orda Buryat', 191);
INSERT INTO estados VALUES (3517, 'Vladimir', 191);
INSERT INTO estados VALUES (3518, 'Volgograd', 191);
INSERT INTO estados VALUES (3519, 'Vologda', 191);
INSERT INTO estados VALUES (3520, 'Voronezh', 191);
INSERT INTO estados VALUES (3521, 'Yamal-Nenets', 191);
INSERT INTO estados VALUES (3522, 'Yaroslavl', 191);
INSERT INTO estados VALUES (3523, 'Yevrey', 191);
INSERT INTO estados VALUES (3524, 'Christ Church Nichola Town', 192);
INSERT INTO estados VALUES (3525, 'Saint Anne Sandy Point', 192);
INSERT INTO estados VALUES (3526, 'Saint George Basseterre', 192);
INSERT INTO estados VALUES (3527, 'Saint George Gingerland', 192);
INSERT INTO estados VALUES (3528, 'Saint James Windward', 192);
INSERT INTO estados VALUES (3529, 'Saint John Capisterre', 192);
INSERT INTO estados VALUES (3530, 'Saint John Figtree', 192);
INSERT INTO estados VALUES (3531, 'Saint Mary Cayon', 192);
INSERT INTO estados VALUES (3532, 'Saint Paul Capisterre', 192);
INSERT INTO estados VALUES (3533, 'Saint Paul Charlestown', 192);
INSERT INTO estados VALUES (3534, 'Saint Peter Basseterre', 192);
INSERT INTO estados VALUES (3535, 'Saint Thomas Lowland', 192);
INSERT INTO estados VALUES (3536, 'Saint Thomas Middle Island', 192);
INSERT INTO estados VALUES (3537, 'Trinity Palmetto Point', 192);
INSERT INTO estados VALUES (3538, 'Saint-Pierre et Miquelon Collectivite Territoriale', 193);
INSERT INTO estados VALUES (3539, 'Aiga-i-le-Tai', 194);
INSERT INTO estados VALUES (3540, 'Atua', 194);
INSERT INTO estados VALUES (3541, 'Fa', 194);
INSERT INTO estados VALUES (3542, 'Gaga', 194);
INSERT INTO estados VALUES (3543, 'Gagaifomauga', 194);
INSERT INTO estados VALUES (3544, 'Palauli', 194);
INSERT INTO estados VALUES (3545, 'Satupa', 194);
INSERT INTO estados VALUES (3546, 'Tuamasaga', 194);
INSERT INTO estados VALUES (3547, 'Va', 194);
INSERT INTO estados VALUES (3548, 'Vaisigano', 194);
INSERT INTO estados VALUES (3549, 'Acquaviva', 195);
INSERT INTO estados VALUES (3550, 'Borgo Maggiore', 195);
INSERT INTO estados VALUES (3551, 'Chiesanuova', 195);
INSERT INTO estados VALUES (3552, 'Domagnano', 195);
INSERT INTO estados VALUES (3553, 'Faetano', 195);
INSERT INTO estados VALUES (3554, 'Fiorentino', 195);
INSERT INTO estados VALUES (3555, 'Monte Giardino', 195);
INSERT INTO estados VALUES (3556, 'San Marino', 195);
INSERT INTO estados VALUES (3557, 'Serravalle', 195);
INSERT INTO estados VALUES (3558, 'Charlotte', 196);
INSERT INTO estados VALUES (3559, 'Grenadines', 196);
INSERT INTO estados VALUES (3560, 'Saint Andrew', 196);
INSERT INTO estados VALUES (3561, 'Saint David', 196);
INSERT INTO estados VALUES (3562, 'Saint George', 196);
INSERT INTO estados VALUES (3563, 'Saint Patrick', 196);
INSERT INTO estados VALUES (3564, 'Ascension', 197);
INSERT INTO estados VALUES (3565, 'Saint Helena', 197);
INSERT INTO estados VALUES (3566, 'Tristan da Cunha', 197);
INSERT INTO estados VALUES (3567, 'Anse-la-Raye', 198);
INSERT INTO estados VALUES (3568, 'Castries', 198);
INSERT INTO estados VALUES (3569, 'Choiseul', 198);
INSERT INTO estados VALUES (3570, 'Dauphin', 198);
INSERT INTO estados VALUES (3571, 'Dennery', 198);
INSERT INTO estados VALUES (3572, 'Gros-Islet', 198);
INSERT INTO estados VALUES (3573, 'Laborie', 198);
INSERT INTO estados VALUES (3574, 'Micoud', 198);
INSERT INTO estados VALUES (3575, 'Praslin', 198);
INSERT INTO estados VALUES (3576, 'Soufriere', 198);
INSERT INTO estados VALUES (3577, 'Vieux-Fort', 198);
INSERT INTO estados VALUES (3578, 'Principe', 199);
INSERT INTO estados VALUES (3579, 'Sao Tome', 199);
INSERT INTO estados VALUES (3580, 'Dakar', 200);
INSERT INTO estados VALUES (3581, 'Diourbel', 200);
INSERT INTO estados VALUES (3582, 'Fatick', 200);
INSERT INTO estados VALUES (3583, 'Kaolack', 200);
INSERT INTO estados VALUES (3584, 'Kolda', 200);
INSERT INTO estados VALUES (3585, 'Louga', 200);
INSERT INTO estados VALUES (3586, 'Saint-Louis', 200);
INSERT INTO estados VALUES (3587, 'Saint-Louis Region', 200);
INSERT INTO estados VALUES (3588, 'Tambacounda', 200);
INSERT INTO estados VALUES (3589, 'Thies', 200);
INSERT INTO estados VALUES (3590, 'Ziguinchor', 200);
INSERT INTO estados VALUES (3591, 'Kosovo', 201);
INSERT INTO estados VALUES (3592, 'Vojvodina', 201);
INSERT INTO estados VALUES (3593, 'Anse Boileau', 202);
INSERT INTO estados VALUES (3594, 'Anse Etoile', 202);
INSERT INTO estados VALUES (3595, 'Anse Louis', 202);
INSERT INTO estados VALUES (3596, 'Anse Royale', 202);
INSERT INTO estados VALUES (3597, 'Anse aux Pins', 202);
INSERT INTO estados VALUES (3598, 'Baie Lazare', 202);
INSERT INTO estados VALUES (3599, 'Baie Sainte Anne', 202);
INSERT INTO estados VALUES (3600, 'Beau Vallon', 202);
INSERT INTO estados VALUES (3601, 'Bel Air', 202);
INSERT INTO estados VALUES (3602, 'Bel Ombre', 202);
INSERT INTO estados VALUES (3603, 'Cascade', 202);
INSERT INTO estados VALUES (3604, 'Glacis', 202);
INSERT INTO estados VALUES (3605, 'Grand Anse', 202);
INSERT INTO estados VALUES (3606, 'Grand Anse', 202);
INSERT INTO estados VALUES (3607, 'La Digue', 202);
INSERT INTO estados VALUES (3608, 'La Riviere Anglaise', 202);
INSERT INTO estados VALUES (3609, 'Mont Buxton', 202);
INSERT INTO estados VALUES (3610, 'Mont Fleuri', 202);
INSERT INTO estados VALUES (3611, 'Plaisance', 202);
INSERT INTO estados VALUES (3612, 'Pointe La Rue', 202);
INSERT INTO estados VALUES (3613, 'Port Glaud', 202);
INSERT INTO estados VALUES (3614, 'Saint Louis', 202);
INSERT INTO estados VALUES (3615, 'Takamaka', 202);
INSERT INTO estados VALUES (3616, 'Eastern', 203);
INSERT INTO estados VALUES (3617, 'Northern', 203);
INSERT INTO estados VALUES (3618, 'Southern', 203);
INSERT INTO estados VALUES (3619, 'Western Area', 203);
INSERT INTO estados VALUES (3620, 'Singapore (General)', 204);
INSERT INTO estados VALUES (3621, 'Al Hasakah', 205);
INSERT INTO estados VALUES (3622, 'Al Ladhiqiyah', 205);
INSERT INTO estados VALUES (3623, 'Al Qunaytirah', 205);
INSERT INTO estados VALUES (3624, 'Ar Raqqah', 205);
INSERT INTO estados VALUES (3625, 'As Suwayda', 205);
INSERT INTO estados VALUES (3626, 'Dar', 205);
INSERT INTO estados VALUES (3627, 'Dayr az Zawr', 205);
INSERT INTO estados VALUES (3628, 'Dimashq', 205);
INSERT INTO estados VALUES (3629, 'Halab', 205);
INSERT INTO estados VALUES (3630, 'Hamah', 205);
INSERT INTO estados VALUES (3631, 'Hims', 205);
INSERT INTO estados VALUES (3632, 'Idlib', 205);
INSERT INTO estados VALUES (3633, 'Rif Dimashq', 205);
INSERT INTO estados VALUES (3634, 'Tartus', 205);
INSERT INTO estados VALUES (3635, 'Bakool', 206);
INSERT INTO estados VALUES (3636, 'Banaadir', 206);
INSERT INTO estados VALUES (3637, 'Bari', 206);
INSERT INTO estados VALUES (3638, 'Bay', 206);
INSERT INTO estados VALUES (3639, 'Galguduud', 206);
INSERT INTO estados VALUES (3640, 'Gedo', 206);
INSERT INTO estados VALUES (3641, 'Hiiraan', 206);
INSERT INTO estados VALUES (3642, 'Jubbada Dhexe', 206);
INSERT INTO estados VALUES (3643, 'Jubbada Hoose', 206);
INSERT INTO estados VALUES (3644, 'Mudug', 206);
INSERT INTO estados VALUES (3645, 'Nugaal', 206);
INSERT INTO estados VALUES (3646, 'Sanaag', 206);
INSERT INTO estados VALUES (3647, 'Shabeellaha Dhexe', 206);
INSERT INTO estados VALUES (3648, 'Shabeellaha Hoose', 206);
INSERT INTO estados VALUES (3649, 'Togdheer', 206);
INSERT INTO estados VALUES (3650, 'Woqooyi Galbeed', 206);
INSERT INTO estados VALUES (3651, 'Amparai', 207);
INSERT INTO estados VALUES (3652, 'Anuradhapura', 207);
INSERT INTO estados VALUES (3653, 'Badulla', 207);
INSERT INTO estados VALUES (3654, 'Batticaloa', 207);
INSERT INTO estados VALUES (3655, 'Central Province', 207);
INSERT INTO estados VALUES (3656, 'Colombo', 207);
INSERT INTO estados VALUES (3657, 'Galle', 207);
INSERT INTO estados VALUES (3658, 'Gampaha', 207);
INSERT INTO estados VALUES (3659, 'Hambantota', 207);
INSERT INTO estados VALUES (3660, 'Jaffna', 207);
INSERT INTO estados VALUES (3661, 'Kalutara', 207);
INSERT INTO estados VALUES (3662, 'Kandy', 207);
INSERT INTO estados VALUES (3663, 'Kegalla', 207);
INSERT INTO estados VALUES (3664, 'Kurunegala', 207);
INSERT INTO estados VALUES (3665, 'Mannar', 207);
INSERT INTO estados VALUES (3666, 'Matale', 207);
INSERT INTO estados VALUES (3667, 'Matara', 207);
INSERT INTO estados VALUES (3668, 'Moneragala', 207);
INSERT INTO estados VALUES (3669, 'Mullaittivu', 207);
INSERT INTO estados VALUES (3670, 'North Central Province', 207);
INSERT INTO estados VALUES (3671, 'North Eastern Province', 207);
INSERT INTO estados VALUES (3672, 'North Western Province', 207);
INSERT INTO estados VALUES (3673, 'Nuwara Eliya', 207);
INSERT INTO estados VALUES (3674, 'Polonnaruwa', 207);
INSERT INTO estados VALUES (3675, 'Puttalam', 207);
INSERT INTO estados VALUES (3676, 'Ratnapura', 207);
INSERT INTO estados VALUES (3677, 'Sabaragamuwa Province', 207);
INSERT INTO estados VALUES (3678, 'Southern Province', 207);
INSERT INTO estados VALUES (3679, 'Trincomalee', 207);
INSERT INTO estados VALUES (3680, 'Uva Province', 207);
INSERT INTO estados VALUES (3681, 'Vavuniya', 207);
INSERT INTO estados VALUES (3682, 'Western Province', 207);
INSERT INTO estados VALUES (3683, 'Hhohho', 208);
INSERT INTO estados VALUES (3684, 'Lubombo', 208);
INSERT INTO estados VALUES (3685, 'Manzini', 208);
INSERT INTO estados VALUES (3686, 'Praslin', 208);
INSERT INTO estados VALUES (3687, 'Shiselweni', 208);
INSERT INTO estados VALUES (3688, 'Eastern Cape', 209);
INSERT INTO estados VALUES (3689, 'Free State', 209);
INSERT INTO estados VALUES (3690, 'Gauteng', 209);
INSERT INTO estados VALUES (3691, 'KwaZulu-Natal', 209);
INSERT INTO estados VALUES (3692, 'Limpopo', 209);
INSERT INTO estados VALUES (3693, 'Mpumalanga', 209);
INSERT INTO estados VALUES (3694, 'North-West', 209);
INSERT INTO estados VALUES (3695, 'Northern Cape', 209);
INSERT INTO estados VALUES (3696, 'Western Cape', 209);
INSERT INTO estados VALUES (3697, 'Al Istiwaiyah', 210);
INSERT INTO estados VALUES (3698, 'Al Khartum', 210);
INSERT INTO estados VALUES (3699, 'Al Wusta', 210);
INSERT INTO estados VALUES (3700, 'Ash Shamaliyah', 210);
INSERT INTO estados VALUES (3701, 'Ash Sharqiyah', 210);
INSERT INTO estados VALUES (3702, 'Bahr al Ghazal', 210);
INSERT INTO estados VALUES (3703, 'Darfur', 210);
INSERT INTO estados VALUES (3704, 'Kurdufan', 210);
INSERT INTO estados VALUES (3705, 'Alvsborgs Lan', 211);
INSERT INTO estados VALUES (3706, 'Blekinge Lan', 211);
INSERT INTO estados VALUES (3707, 'Dalarnas Lan', 211);
INSERT INTO estados VALUES (3708, 'Gavleborgs Lan', 211);
INSERT INTO estados VALUES (3709, 'Goteborgs och Bohus Lan', 211);
INSERT INTO estados VALUES (3710, 'Gotlands Lan', 211);
INSERT INTO estados VALUES (3711, 'Hallands Lan', 211);
INSERT INTO estados VALUES (3712, 'Jamtlands Lan', 211);
INSERT INTO estados VALUES (3713, 'Jonkopings Lan', 211);
INSERT INTO estados VALUES (3714, 'Kalmar Lan', 211);
INSERT INTO estados VALUES (3715, 'Kristianstads Lan', 211);
INSERT INTO estados VALUES (3716, 'Kronobergs Lan', 211);
INSERT INTO estados VALUES (3717, 'Malmohus Lan', 211);
INSERT INTO estados VALUES (3718, 'Norrbottens Lan', 211);
INSERT INTO estados VALUES (3719, 'Orebro Lan', 211);
INSERT INTO estados VALUES (3720, 'Ostergotlands Lan', 211);
INSERT INTO estados VALUES (3721, 'Skane Lan', 211);
INSERT INTO estados VALUES (3722, 'Skaraborgs Lan', 211);
INSERT INTO estados VALUES (3723, 'Sodermanlands Lan', 211);
INSERT INTO estados VALUES (3724, 'Stockholms Lan', 211);
INSERT INTO estados VALUES (3725, 'Uppsala Lan', 211);
INSERT INTO estados VALUES (3726, 'Varmlands Lan', 211);
INSERT INTO estados VALUES (3727, 'Vasterbottens Lan', 211);
INSERT INTO estados VALUES (3728, 'Vasternorrlands Lan', 211);
INSERT INTO estados VALUES (3729, 'Vastmanlands Lan', 211);
INSERT INTO estados VALUES (3730, 'Vastra Gotaland', 211);
INSERT INTO estados VALUES (3731, 'Aargau', 212);
INSERT INTO estados VALUES (3732, 'Ausser-Rhoden', 212);
INSERT INTO estados VALUES (3733, 'Basel-Landschaft', 212);
INSERT INTO estados VALUES (3734, 'Basel-Stadt', 212);
INSERT INTO estados VALUES (3735, 'Bern', 212);
INSERT INTO estados VALUES (3736, 'Fribourg', 212);
INSERT INTO estados VALUES (3737, 'Geneve', 212);
INSERT INTO estados VALUES (3738, 'Glarus', 212);
INSERT INTO estados VALUES (3739, 'Graubunden', 212);
INSERT INTO estados VALUES (3740, 'Inner-Rhoden', 212);
INSERT INTO estados VALUES (3741, 'Jura', 212);
INSERT INTO estados VALUES (3742, 'Luzern', 212);
INSERT INTO estados VALUES (3743, 'Neuchatel', 212);
INSERT INTO estados VALUES (3744, 'Nidwalden', 212);
INSERT INTO estados VALUES (3745, 'Obwalden', 212);
INSERT INTO estados VALUES (3746, 'Sankt Gallen', 212);
INSERT INTO estados VALUES (3747, 'Schaffhausen', 212);
INSERT INTO estados VALUES (3748, 'Schwyz', 212);
INSERT INTO estados VALUES (3749, 'Solothurn', 212);
INSERT INTO estados VALUES (3750, 'Thurgau', 212);
INSERT INTO estados VALUES (3751, 'Ticino', 212);
INSERT INTO estados VALUES (3752, 'Uri', 212);
INSERT INTO estados VALUES (3753, 'Valais', 212);
INSERT INTO estados VALUES (3754, 'Vaud', 212);
INSERT INTO estados VALUES (3755, 'Zug', 212);
INSERT INTO estados VALUES (3756, 'Zurich', 212);
INSERT INTO estados VALUES (3757, 'Brokopondo', 213);
INSERT INTO estados VALUES (3758, 'Commewijne', 213);
INSERT INTO estados VALUES (3759, 'Coronie', 213);
INSERT INTO estados VALUES (3760, 'Marowijne', 213);
INSERT INTO estados VALUES (3761, 'Nickerie', 213);
INSERT INTO estados VALUES (3762, 'Para', 213);
INSERT INTO estados VALUES (3763, 'Paramaribo', 213);
INSERT INTO estados VALUES (3764, 'Saramacca', 213);
INSERT INTO estados VALUES (3765, 'Sipaliwini', 213);
INSERT INTO estados VALUES (3766, 'Wanica', 213);
INSERT INTO estados VALUES (3767, 'Svalbard and Jan Mayen (General)', 214);
INSERT INTO estados VALUES (3768, 'Ang Thong', 215);
INSERT INTO estados VALUES (3769, 'Buriram', 215);
INSERT INTO estados VALUES (3770, 'Chachoengsao', 215);
INSERT INTO estados VALUES (3771, 'Chai Nat', 215);
INSERT INTO estados VALUES (3772, 'Chaiyaphum', 215);
INSERT INTO estados VALUES (3773, 'Chanthaburi', 215);
INSERT INTO estados VALUES (3774, 'Chiang Mai', 215);
INSERT INTO estados VALUES (3775, 'Chiang Rai', 215);
INSERT INTO estados VALUES (3776, 'Chon Buri', 215);
INSERT INTO estados VALUES (3777, 'Chumphon', 215);
INSERT INTO estados VALUES (3778, 'Kalasin', 215);
INSERT INTO estados VALUES (3779, 'Kamphaeng Phet', 215);
INSERT INTO estados VALUES (3780, 'Kanchanaburi', 215);
INSERT INTO estados VALUES (3781, 'Khon Kaen', 215);
INSERT INTO estados VALUES (3782, 'Krabi', 215);
INSERT INTO estados VALUES (3783, 'Krung Thep', 215);
INSERT INTO estados VALUES (3784, 'Lampang', 215);
INSERT INTO estados VALUES (3785, 'Lamphun', 215);
INSERT INTO estados VALUES (3786, 'Loei', 215);
INSERT INTO estados VALUES (3787, 'Lop Buri', 215);
INSERT INTO estados VALUES (3788, 'Mae Hong Son', 215);
INSERT INTO estados VALUES (3789, 'Maha Sarakham', 215);
INSERT INTO estados VALUES (3790, 'Mukdahan', 215);
INSERT INTO estados VALUES (3791, 'Nakhon Nayok', 215);
INSERT INTO estados VALUES (3792, 'Nakhon Pathom', 215);
INSERT INTO estados VALUES (3793, 'Nakhon Phanom', 215);
INSERT INTO estados VALUES (3794, 'Nakhon Ratchasima', 215);
INSERT INTO estados VALUES (3795, 'Nakhon Sawan', 215);
INSERT INTO estados VALUES (3796, 'Nakhon Si Thammarat', 215);
INSERT INTO estados VALUES (3797, 'Nan', 215);
INSERT INTO estados VALUES (3798, 'Narathiwat', 215);
INSERT INTO estados VALUES (3799, 'Nong Khai', 215);
INSERT INTO estados VALUES (3800, 'Nonthaburi', 215);
INSERT INTO estados VALUES (3801, 'Pathum Thani', 215);
INSERT INTO estados VALUES (3802, 'Pattani', 215);
INSERT INTO estados VALUES (3803, 'Phangnga', 215);
INSERT INTO estados VALUES (3804, 'Phatthalung', 215);
INSERT INTO estados VALUES (3805, 'Phayao', 215);
INSERT INTO estados VALUES (3806, 'Phetchabun', 215);
INSERT INTO estados VALUES (3807, 'Phetchaburi', 215);
INSERT INTO estados VALUES (3808, 'Phichit', 215);
INSERT INTO estados VALUES (3809, 'Phitsanulok', 215);
INSERT INTO estados VALUES (3810, 'Phra Nakhon Si Ayutthaya', 215);
INSERT INTO estados VALUES (3811, 'Phrae', 215);
INSERT INTO estados VALUES (3812, 'Phuket', 215);
INSERT INTO estados VALUES (3813, 'Prachin Buri', 215);
INSERT INTO estados VALUES (3814, 'Prachuap Khiri Khan', 215);
INSERT INTO estados VALUES (3815, 'Ranong', 215);
INSERT INTO estados VALUES (3816, 'Ratchaburi', 215);
INSERT INTO estados VALUES (3817, 'Rayong', 215);
INSERT INTO estados VALUES (3818, 'Roi Et', 215);
INSERT INTO estados VALUES (3819, 'Sakon Nakhon', 215);
INSERT INTO estados VALUES (3820, 'Samut Prakan', 215);
INSERT INTO estados VALUES (3821, 'Samut Sakhon', 215);
INSERT INTO estados VALUES (3822, 'Samut Songkhram', 215);
INSERT INTO estados VALUES (3823, 'Saraburi', 215);
INSERT INTO estados VALUES (3824, 'Satun', 215);
INSERT INTO estados VALUES (3825, 'Sing Buri', 215);
INSERT INTO estados VALUES (3826, 'Sisaket', 215);
INSERT INTO estados VALUES (3827, 'Songkhla', 215);
INSERT INTO estados VALUES (3828, 'Sukhothai', 215);
INSERT INTO estados VALUES (3829, 'Suphan Buri', 215);
INSERT INTO estados VALUES (3830, 'Surat Thani', 215);
INSERT INTO estados VALUES (3831, 'Surin', 215);
INSERT INTO estados VALUES (3832, 'Tak', 215);
INSERT INTO estados VALUES (3833, 'Trang', 215);
INSERT INTO estados VALUES (3834, 'Trat', 215);
INSERT INTO estados VALUES (3835, 'Ubon Ratchathani', 215);
INSERT INTO estados VALUES (3836, 'Ubon Ratchathani Province', 215);
INSERT INTO estados VALUES (3837, 'Udon Thani', 215);
INSERT INTO estados VALUES (3838, 'Uthai Thani', 215);
INSERT INTO estados VALUES (3839, 'Uttaradit', 215);
INSERT INTO estados VALUES (3840, 'Yala', 215);
INSERT INTO estados VALUES (3841, 'Yasothon', 215);
INSERT INTO estados VALUES (3842, 'Fu-chien', 216);
INSERT INTO estados VALUES (3843, 'Kao-hsiung', 216);
INSERT INTO estados VALUES (3844, 'T ai-pei', 216);
INSERT INTO estados VALUES (3845, 'T ai-wan', 216);
INSERT INTO estados VALUES (3846, 'Khatlon', 217);
INSERT INTO estados VALUES (3847, 'Kuhistoni Badakhshon', 217);
INSERT INTO estados VALUES (3848, 'Sughd', 217);
INSERT INTO estados VALUES (3849, 'Arusha', 218);
INSERT INTO estados VALUES (3850, 'Arusha Region', 218);
INSERT INTO estados VALUES (3851, 'Dar es Salaam', 218);
INSERT INTO estados VALUES (3852, 'Dodoma', 218);
INSERT INTO estados VALUES (3853, 'Iringa', 218);
INSERT INTO estados VALUES (3854, 'Kagera', 218);
INSERT INTO estados VALUES (3855, 'Kigoma', 218);
INSERT INTO estados VALUES (3856, 'Kilimanjaro', 218);
INSERT INTO estados VALUES (3857, 'Lindi', 218);
INSERT INTO estados VALUES (3858, 'Mara', 218);
INSERT INTO estados VALUES (3859, 'Mbeya', 218);
INSERT INTO estados VALUES (3860, 'Morogoro', 218);
INSERT INTO estados VALUES (3861, 'Mtwara', 218);
INSERT INTO estados VALUES (3862, 'Mwanza', 218);
INSERT INTO estados VALUES (3863, 'Pemba North', 218);
INSERT INTO estados VALUES (3864, 'Pemba South', 218);
INSERT INTO estados VALUES (3865, 'Pwani', 218);
INSERT INTO estados VALUES (3866, 'Rukwa', 218);
INSERT INTO estados VALUES (3867, 'Ruvuma', 218);
INSERT INTO estados VALUES (3868, 'Shinyanga', 218);
INSERT INTO estados VALUES (3869, 'Singida', 218);
INSERT INTO estados VALUES (3870, 'Tabora', 218);
INSERT INTO estados VALUES (3871, 'Tanga', 218);
INSERT INTO estados VALUES (3872, 'Zanzibar Central', 218);
INSERT INTO estados VALUES (3873, 'Zanzibar North', 218);
INSERT INTO estados VALUES (3874, 'Zanzibar Urban', 218);
INSERT INTO estados VALUES (3875, 'Amlame', 219);
INSERT INTO estados VALUES (3876, 'Aneho', 219);
INSERT INTO estados VALUES (3877, 'Atakpame', 219);
INSERT INTO estados VALUES (3878, 'Badou', 219);
INSERT INTO estados VALUES (3879, 'Bafilo', 219);
INSERT INTO estados VALUES (3880, 'Bassar', 219);
INSERT INTO estados VALUES (3881, 'Dapaong', 219);
INSERT INTO estados VALUES (3882, 'Kante', 219);
INSERT INTO estados VALUES (3883, 'Klouto', 219);
INSERT INTO estados VALUES (3884, 'Kpagouda', 219);
INSERT INTO estados VALUES (3885, 'Lama-Kara', 219);
INSERT INTO estados VALUES (3886, 'Lome', 219);
INSERT INTO estados VALUES (3887, 'Mango', 219);
INSERT INTO estados VALUES (3888, 'Maritime Region', 219);
INSERT INTO estados VALUES (3889, 'Niamtougou', 219);
INSERT INTO estados VALUES (3890, 'Notse', 219);
INSERT INTO estados VALUES (3891, 'Sotouboua', 219);
INSERT INTO estados VALUES (3892, 'Tabligbo', 219);
INSERT INTO estados VALUES (3893, 'Tchamba', 219);
INSERT INTO estados VALUES (3894, 'Tchaoudjo', 219);
INSERT INTO estados VALUES (3895, 'Tsevie', 219);
INSERT INTO estados VALUES (3896, 'Vogan', 219);
INSERT INTO estados VALUES (3897, 'Ha', 220);
INSERT INTO estados VALUES (3898, 'Tongatapu', 220);
INSERT INTO estados VALUES (3899, 'Vava', 220);
INSERT INTO estados VALUES (3900, 'Tokelau (General)', 221);
INSERT INTO estados VALUES (3901, 'Arima', 222);
INSERT INTO estados VALUES (3902, 'Caroni', 222);
INSERT INTO estados VALUES (3903, 'Mayaro', 222);
INSERT INTO estados VALUES (3904, 'Nariva', 222);
INSERT INTO estados VALUES (3905, 'Port-of-Spain', 222);
INSERT INTO estados VALUES (3906, 'Saint Andrew', 222);
INSERT INTO estados VALUES (3907, 'Saint David', 222);
INSERT INTO estados VALUES (3908, 'Saint George', 222);
INSERT INTO estados VALUES (3909, 'Saint Patrick', 222);
INSERT INTO estados VALUES (3910, 'San Fernando', 222);
INSERT INTO estados VALUES (3911, 'Tobago', 222);
INSERT INTO estados VALUES (3912, 'Victoria', 222);
INSERT INTO estados VALUES (3913, 'Ahal', 223);
INSERT INTO estados VALUES (3914, 'Balkan', 223);
INSERT INTO estados VALUES (3915, 'Dashoguz', 223);
INSERT INTO estados VALUES (3916, 'Lebap', 223);
INSERT INTO estados VALUES (3917, 'Mary', 223);
INSERT INTO estados VALUES (3918, 'Adana', 224);
INSERT INTO estados VALUES (3919, 'Adiyaman', 224);
INSERT INTO estados VALUES (3920, 'Afyon', 224);
INSERT INTO estados VALUES (3921, 'Agri', 224);
INSERT INTO estados VALUES (3922, 'Aksaray', 224);
INSERT INTO estados VALUES (3923, 'Amasya', 224);
INSERT INTO estados VALUES (3924, 'Ankara', 224);
INSERT INTO estados VALUES (3925, 'Antalya', 224);
INSERT INTO estados VALUES (3926, 'Ardahan', 224);
INSERT INTO estados VALUES (3927, 'Artvin', 224);
INSERT INTO estados VALUES (3928, 'Aydin', 224);
INSERT INTO estados VALUES (3929, 'Balikesir', 224);
INSERT INTO estados VALUES (3930, 'Bartin', 224);
INSERT INTO estados VALUES (3931, 'Batman', 224);
INSERT INTO estados VALUES (3932, 'Bayburt', 224);
INSERT INTO estados VALUES (3933, 'Bilecik', 224);
INSERT INTO estados VALUES (3934, 'Bingol', 224);
INSERT INTO estados VALUES (3935, 'Bitlis', 224);
INSERT INTO estados VALUES (3936, 'Bolu', 224);
INSERT INTO estados VALUES (3937, 'Burdur', 224);
INSERT INTO estados VALUES (3938, 'Bursa', 224);
INSERT INTO estados VALUES (3939, 'Canakkale', 224);
INSERT INTO estados VALUES (3940, 'Cankiri', 224);
INSERT INTO estados VALUES (3941, 'Corum', 224);
INSERT INTO estados VALUES (3942, 'Denizli', 224);
INSERT INTO estados VALUES (3943, 'Diyarbakir', 224);
INSERT INTO estados VALUES (3944, 'Duzce', 224);
INSERT INTO estados VALUES (3945, 'Edirne', 224);
INSERT INTO estados VALUES (3946, 'Elazig', 224);
INSERT INTO estados VALUES (3947, 'Erzincan', 224);
INSERT INTO estados VALUES (3948, 'Erzurum', 224);
INSERT INTO estados VALUES (3949, 'Eskisehir', 224);
INSERT INTO estados VALUES (3950, 'Gaziantep', 224);
INSERT INTO estados VALUES (3951, 'Giresun', 224);
INSERT INTO estados VALUES (3952, 'Gumushane', 224);
INSERT INTO estados VALUES (3953, 'Hakkari', 224);
INSERT INTO estados VALUES (3954, 'Hatay', 224);
INSERT INTO estados VALUES (3955, 'Icel', 224);
INSERT INTO estados VALUES (3956, 'Igdir', 224);
INSERT INTO estados VALUES (3957, 'Isparta', 224);
INSERT INTO estados VALUES (3958, 'Istanbul', 224);
INSERT INTO estados VALUES (3959, 'Izmir', 224);
INSERT INTO estados VALUES (3960, 'Kahramanmaras', 224);
INSERT INTO estados VALUES (3961, 'Karabuk', 224);
INSERT INTO estados VALUES (3962, 'Karaman', 224);
INSERT INTO estados VALUES (3963, 'Kars', 224);
INSERT INTO estados VALUES (3964, 'Kastamonu', 224);
INSERT INTO estados VALUES (3965, 'Kayseri', 224);
INSERT INTO estados VALUES (3966, 'Kilis', 224);
INSERT INTO estados VALUES (3967, 'Kirikkale', 224);
INSERT INTO estados VALUES (3968, 'Kirklareli', 224);
INSERT INTO estados VALUES (3969, 'Kirsehir', 224);
INSERT INTO estados VALUES (3970, 'Kocaeli', 224);
INSERT INTO estados VALUES (3971, 'Konya', 224);
INSERT INTO estados VALUES (3972, 'Kutahya', 224);
INSERT INTO estados VALUES (3973, 'Malatya', 224);
INSERT INTO estados VALUES (3974, 'Manisa', 224);
INSERT INTO estados VALUES (3975, 'Mardin', 224);
INSERT INTO estados VALUES (3976, 'Mugla', 224);
INSERT INTO estados VALUES (3977, 'Mus', 224);
INSERT INTO estados VALUES (3978, 'Nevsehir', 224);
INSERT INTO estados VALUES (3979, 'Nigde', 224);
INSERT INTO estados VALUES (3980, 'Ordu', 224);
INSERT INTO estados VALUES (3981, 'Osmaniye', 224);
INSERT INTO estados VALUES (3982, 'Rize', 224);
INSERT INTO estados VALUES (3983, 'Sakarya', 224);
INSERT INTO estados VALUES (3984, 'Samsun', 224);
INSERT INTO estados VALUES (3985, 'Sanliurfa', 224);
INSERT INTO estados VALUES (3986, 'Siirt', 224);
INSERT INTO estados VALUES (3987, 'Sinop', 224);
INSERT INTO estados VALUES (3988, 'Sirnak', 224);
INSERT INTO estados VALUES (3989, 'Sivas', 224);
INSERT INTO estados VALUES (3990, 'Tekirdag', 224);
INSERT INTO estados VALUES (3991, 'Tokat', 224);
INSERT INTO estados VALUES (3992, 'Trabzon', 224);
INSERT INTO estados VALUES (3993, 'Tunceli', 224);
INSERT INTO estados VALUES (3994, 'Usak', 224);
INSERT INTO estados VALUES (3995, 'Van', 224);
INSERT INTO estados VALUES (3996, 'Yalova', 224);
INSERT INTO estados VALUES (3997, 'Yozgat', 224);
INSERT INTO estados VALUES (3998, 'Zonguldak', 224);
INSERT INTO estados VALUES (3999, 'Tuvalu (General)', 225);
INSERT INTO estados VALUES (4000, 'Al Mahdiyah', 226);
INSERT INTO estados VALUES (4001, 'Al Munastir', 226);
INSERT INTO estados VALUES (4002, 'Al Qasrayn', 226);
INSERT INTO estados VALUES (4003, 'Al Qayrawan', 226);
INSERT INTO estados VALUES (4004, 'Ariana', 226);
INSERT INTO estados VALUES (4005, 'Ariana Governorate', 226);
INSERT INTO estados VALUES (4006, 'Bajah', 226);
INSERT INTO estados VALUES (4007, 'Banzart', 226);
INSERT INTO estados VALUES (4008, 'Bin', 226);
INSERT INTO estados VALUES (4009, 'Jundubah', 226);
INSERT INTO estados VALUES (4010, 'Kef', 226);
INSERT INTO estados VALUES (4011, 'Madanin', 226);
INSERT INTO estados VALUES (4012, 'Manouba', 226);
INSERT INTO estados VALUES (4013, 'Nabul', 226);
INSERT INTO estados VALUES (4014, 'Qabis', 226);
INSERT INTO estados VALUES (4015, 'Qafsah', 226);
INSERT INTO estados VALUES (4016, 'Qibili', 226);
INSERT INTO estados VALUES (4017, 'Safaqis', 226);
INSERT INTO estados VALUES (4018, 'Sidi Bu Zayd', 226);
INSERT INTO estados VALUES (4019, 'Silyanah', 226);
INSERT INTO estados VALUES (4020, 'Susah', 226);
INSERT INTO estados VALUES (4021, 'Tatawin', 226);
INSERT INTO estados VALUES (4022, 'Tawzar', 226);
INSERT INTO estados VALUES (4023, 'Tunis', 226);
INSERT INTO estados VALUES (4024, 'Zaghwan', 226);
INSERT INTO estados VALUES (4025, 'Cherkas ka Oblast', 227);
INSERT INTO estados VALUES (4026, 'Chernihivska Oblast', 227);
INSERT INTO estados VALUES (4027, 'Chernivets ka Oblast', 227);
INSERT INTO estados VALUES (4028, 'Dnipropetrovs ka Oblast', 227);
INSERT INTO estados VALUES (4029, 'Donets ka Oblast', 227);
INSERT INTO estados VALUES (4030, 'Ivano-Frankivs ka Oblast', 227);
INSERT INTO estados VALUES (4031, 'Kharkivs ka Oblast', 227);
INSERT INTO estados VALUES (4032, 'Khersons ka Oblast', 227);
INSERT INTO estados VALUES (4033, 'Khmel nyts ka Oblast', 227);
INSERT INTO estados VALUES (4034, 'Kirovohrads ka Oblast', 227);
INSERT INTO estados VALUES (4035, 'Krym', 227);
INSERT INTO estados VALUES (4036, 'Kyyiv', 227);
INSERT INTO estados VALUES (4037, 'Kyyivs ka Oblast', 227);
INSERT INTO estados VALUES (4038, 'L vivs ka Oblast', 227);
INSERT INTO estados VALUES (4039, 'Luhans ka Oblast', 227);
INSERT INTO estados VALUES (4040, 'Mykolayivs ka Oblast', 227);
INSERT INTO estados VALUES (4041, 'Odes ka Oblast', 227);
INSERT INTO estados VALUES (4042, 'Poltavs ka Oblast', 227);
INSERT INTO estados VALUES (4043, 'Rivnens ka Oblast', 227);
INSERT INTO estados VALUES (4044, 'Sevastopol', 227);
INSERT INTO estados VALUES (4045, 'Sums ka Oblast', 227);
INSERT INTO estados VALUES (4046, 'Ternopils ka Oblast', 227);
INSERT INTO estados VALUES (4047, 'Vinnyts ka Oblast', 227);
INSERT INTO estados VALUES (4048, 'Volyns ka Oblast', 227);
INSERT INTO estados VALUES (4049, 'Zakarpats ka Oblast', 227);
INSERT INTO estados VALUES (4050, 'Zaporiz ka Oblast', 227);
INSERT INTO estados VALUES (4051, 'Zhytomyrs ka Oblast', 227);
INSERT INTO estados VALUES (4052, 'Adjumani', 228);
INSERT INTO estados VALUES (4053, 'Arua', 228);
INSERT INTO estados VALUES (4054, 'Bugiri', 228);
INSERT INTO estados VALUES (4055, 'Busia', 228);
INSERT INTO estados VALUES (4056, 'Busoga', 228);
INSERT INTO estados VALUES (4057, 'Central', 228);
INSERT INTO estados VALUES (4058, 'Eastern', 228);
INSERT INTO estados VALUES (4059, 'Iganga', 228);
INSERT INTO estados VALUES (4060, 'Kabarole', 228);
INSERT INTO estados VALUES (4061, 'Kaberamaido', 228);
INSERT INTO estados VALUES (4062, 'Kampala', 228);
INSERT INTO estados VALUES (4063, 'Kamwenge', 228);
INSERT INTO estados VALUES (4064, 'Kanungu', 228);
INSERT INTO estados VALUES (4065, 'Karamoja', 228);
INSERT INTO estados VALUES (4066, 'Katakwi', 228);
INSERT INTO estados VALUES (4067, 'Kayunga', 228);
INSERT INTO estados VALUES (4068, 'Kitgum', 228);
INSERT INTO estados VALUES (4069, 'Kyenjojo', 228);
INSERT INTO estados VALUES (4070, 'Mayuge', 228);
INSERT INTO estados VALUES (4071, 'Mbale', 228);
INSERT INTO estados VALUES (4072, 'Moroto', 228);
INSERT INTO estados VALUES (4073, 'Mpigi', 228);
INSERT INTO estados VALUES (4074, 'Mukono', 228);
INSERT INTO estados VALUES (4075, 'Nakapiripirit', 228);
INSERT INTO estados VALUES (4076, 'Nakasongola', 228);
INSERT INTO estados VALUES (4077, 'Nile', 228);
INSERT INTO estados VALUES (4078, 'North Buganda', 228);
INSERT INTO estados VALUES (4079, 'Northern', 228);
INSERT INTO estados VALUES (4080, 'Pader', 228);
INSERT INTO estados VALUES (4081, 'Rukungiri', 228);
INSERT INTO estados VALUES (4082, 'Sembabule', 228);
INSERT INTO estados VALUES (4083, 'Sironko', 228);
INSERT INTO estados VALUES (4084, 'Soroti', 228);
INSERT INTO estados VALUES (4085, 'South Buganda', 228);
INSERT INTO estados VALUES (4086, 'Southern', 228);
INSERT INTO estados VALUES (4087, 'Wakiso', 228);
INSERT INTO estados VALUES (4088, 'Western', 228);
INSERT INTO estados VALUES (4089, 'Yumbe', 228);
INSERT INTO estados VALUES (4090, 'United States Minor Outlying Islands (General)', 229);
INSERT INTO estados VALUES (4091, 'Artigas', 230);
INSERT INTO estados VALUES (4092, 'Canelones', 230);
INSERT INTO estados VALUES (4093, 'Cerro Largo', 230);
INSERT INTO estados VALUES (4094, 'Colonia', 230);
INSERT INTO estados VALUES (4095, 'Durazno', 230);
INSERT INTO estados VALUES (4096, 'Flores', 230);
INSERT INTO estados VALUES (4097, 'Florida', 230);
INSERT INTO estados VALUES (4098, 'Lavalleja', 230);
INSERT INTO estados VALUES (4099, 'Maldonado', 230);
INSERT INTO estados VALUES (4100, 'Montevideo', 230);
INSERT INTO estados VALUES (4101, 'Paysandu', 230);
INSERT INTO estados VALUES (4102, 'Rio Negro', 230);
INSERT INTO estados VALUES (4103, 'Rivera', 230);
INSERT INTO estados VALUES (4104, 'Rocha', 230);
INSERT INTO estados VALUES (4105, 'Salto', 230);
INSERT INTO estados VALUES (4106, 'San Jose', 230);
INSERT INTO estados VALUES (4107, 'Soriano', 230);
INSERT INTO estados VALUES (4108, 'Tacuarembo', 230);
INSERT INTO estados VALUES (4109, 'Treinta y Tres', 230);
INSERT INTO estados VALUES (4110, 'Andijon', 231);
INSERT INTO estados VALUES (4111, 'Bukhoro', 231);
INSERT INTO estados VALUES (4112, 'Farghona', 231);
INSERT INTO estados VALUES (4113, 'Jizzakh', 231);
INSERT INTO estados VALUES (4114, 'Khorazm', 231);
INSERT INTO estados VALUES (4115, 'Namangan', 231);
INSERT INTO estados VALUES (4116, 'Nawoiy', 231);
INSERT INTO estados VALUES (4117, 'Qashqadaryo', 231);
INSERT INTO estados VALUES (4118, 'Qoraqalpoghiston', 231);
INSERT INTO estados VALUES (4119, 'Samarqand', 231);
INSERT INTO estados VALUES (4120, 'Sirdaryo', 231);
INSERT INTO estados VALUES (4121, 'Sirdaryo Province', 231);
INSERT INTO estados VALUES (4122, 'Surkhondaryo', 231);
INSERT INTO estados VALUES (4123, 'Toshkent', 231);
INSERT INTO estados VALUES (4124, 'Ambrym', 232);
INSERT INTO estados VALUES (4125, 'Aoba', 232);
INSERT INTO estados VALUES (4126, 'Efate', 232);
INSERT INTO estados VALUES (4127, 'Epi', 232);
INSERT INTO estados VALUES (4128, 'Malakula', 232);
INSERT INTO estados VALUES (4129, 'Malampa', 232);
INSERT INTO estados VALUES (4130, 'Paama', 232);
INSERT INTO estados VALUES (4131, 'Penama', 232);
INSERT INTO estados VALUES (4132, 'Pentecote', 232);
INSERT INTO estados VALUES (4133, 'Sanma', 232);
INSERT INTO estados VALUES (4134, 'Shefa', 232);
INSERT INTO estados VALUES (4135, 'Shepherd', 232);
INSERT INTO estados VALUES (4136, 'Tafea', 232);
INSERT INTO estados VALUES (4137, 'Torba', 232);
INSERT INTO estados VALUES (4138, 'Amazonas', 233);
INSERT INTO estados VALUES (4139, 'Anzoategui', 233);
INSERT INTO estados VALUES (4140, 'Apure', 233);
INSERT INTO estados VALUES (4141, 'Aragua', 233);
INSERT INTO estados VALUES (4142, 'Barinas', 233);
INSERT INTO estados VALUES (4143, 'Bolívar', 233);
INSERT INTO estados VALUES (4144, 'Carabobo', 233);
INSERT INTO estados VALUES (4145, 'Cojedes', 233);
INSERT INTO estados VALUES (4146, 'Delta Amacuro', 233);
INSERT INTO estados VALUES (4147, 'Dependencias Federales', 233);
INSERT INTO estados VALUES (4148, 'Distrito Capital', 233);
INSERT INTO estados VALUES (4149, 'Falcón', 233);
INSERT INTO estados VALUES (4150, 'Guarico', 233);
INSERT INTO estados VALUES (4151, 'Lara', 233);
INSERT INTO estados VALUES (4152, 'Merida', 233);
INSERT INTO estados VALUES (4153, 'Miranda', 233);
INSERT INTO estados VALUES (4154, 'Monagas', 233);
INSERT INTO estados VALUES (4155, 'Nueva Esparta', 233);
INSERT INTO estados VALUES (4156, 'Portuguesa', 233);
INSERT INTO estados VALUES (4157, 'Sucre', 233);
INSERT INTO estados VALUES (4158, 'Tachira', 233);
INSERT INTO estados VALUES (4159, 'Trujillo', 233);
INSERT INTO estados VALUES (4160, 'Vargas', 233);
INSERT INTO estados VALUES (4161, 'Yaracuy', 233);
INSERT INTO estados VALUES (4162, 'Zulia', 233);
INSERT INTO estados VALUES (4163, 'An Giang', 234);
INSERT INTO estados VALUES (4164, 'An Giang Province', 234);
INSERT INTO estados VALUES (4165, 'Ba Ria-Vung Tau', 234);
INSERT INTO estados VALUES (4166, 'Bac Thai', 234);
INSERT INTO estados VALUES (4167, 'Ben Tre', 234);
INSERT INTO estados VALUES (4168, 'Binh Dinh', 234);
INSERT INTO estados VALUES (4169, 'Binh Thuan', 234);
INSERT INTO estados VALUES (4170, 'Binh Tri Thien', 234);
INSERT INTO estados VALUES (4171, 'Can Tho', 234);
INSERT INTO estados VALUES (4172, 'Cao Bang', 234);
INSERT INTO estados VALUES (4173, 'Cuu Long', 234);
INSERT INTO estados VALUES (4174, 'Dac Lac', 234);
INSERT INTO estados VALUES (4175, 'Dac Lak Province', 234);
INSERT INTO estados VALUES (4176, 'Dong Nai', 234);
INSERT INTO estados VALUES (4177, 'Dong Nai', 234);
INSERT INTO estados VALUES (4178, 'Dong Thap', 234);
INSERT INTO estados VALUES (4179, 'Gia Lai', 234);
INSERT INTO estados VALUES (4180, 'Gia Lai-Kon Tum', 234);
INSERT INTO estados VALUES (4181, 'Ha Bac', 234);
INSERT INTO estados VALUES (4182, 'Ha Giang', 234);
INSERT INTO estados VALUES (4183, 'Ha Nam Ninh', 234);
INSERT INTO estados VALUES (4184, 'Ha Noi', 234);
INSERT INTO estados VALUES (4185, 'Ha Son Binh', 234);
INSERT INTO estados VALUES (4186, 'Ha Tay', 234);
INSERT INTO estados VALUES (4187, 'Ha Tinh', 234);
INSERT INTO estados VALUES (4188, 'Ha Tuyen', 234);
INSERT INTO estados VALUES (4189, 'Hai Hung', 234);
INSERT INTO estados VALUES (4190, 'Hai Phong', 234);
INSERT INTO estados VALUES (4191, 'Hanoi', 234);
INSERT INTO estados VALUES (4192, 'Hau Giang', 234);
INSERT INTO estados VALUES (4193, 'Ho Chi Minh', 234);
INSERT INTO estados VALUES (4194, 'Hoa Binh', 234);
INSERT INTO estados VALUES (4195, 'Hung Yen Province', 234);
INSERT INTO estados VALUES (4196, 'Ha Nam Province', 234);
INSERT INTO estados VALUES (4197, 'Hai Duong Province', 234);
INSERT INTO estados VALUES (4198, 'Ha Chi Minh Municipality', 234);
INSERT INTO estados VALUES (4199, 'Khanh Hoa', 234);
INSERT INTO estados VALUES (4200, 'Kien Giang', 234);
INSERT INTO estados VALUES (4201, 'Kin Giang Province', 234);
INSERT INTO estados VALUES (4202, 'Kon Tum', 234);
INSERT INTO estados VALUES (4203, 'Lai Chau', 234);
INSERT INTO estados VALUES (4204, 'Lam Dong', 234);
INSERT INTO estados VALUES (4205, 'Lang Son', 234);
INSERT INTO estados VALUES (4206, 'Lao Cai', 234);
INSERT INTO estados VALUES (4207, 'Long An', 234);
INSERT INTO estados VALUES (4208, 'Minh Hai', 234);
INSERT INTO estados VALUES (4209, 'Minh Hi Tinh', 234);
INSERT INTO estados VALUES (4210, 'Nam Ha', 234);
INSERT INTO estados VALUES (4211, 'Nghe An', 234);
INSERT INTO estados VALUES (4212, 'Nghe Tinh', 234);
INSERT INTO estados VALUES (4213, 'Nghia Binh', 234);
INSERT INTO estados VALUES (4214, 'Ninh Binh', 234);
INSERT INTO estados VALUES (4215, 'Ninh Thuan', 234);
INSERT INTO estados VALUES (4216, 'Phu Khanh', 234);
INSERT INTO estados VALUES (4217, 'Phu Yen', 234);
INSERT INTO estados VALUES (4218, 'Quang Binh', 234);
INSERT INTO estados VALUES (4219, 'Quang Nam-Da Nang', 234);
INSERT INTO estados VALUES (4220, 'Quang Ngai', 234);
INSERT INTO estados VALUES (4221, 'Quang Ninh', 234);
INSERT INTO estados VALUES (4222, 'Quang Tri', 234);
INSERT INTO estados VALUES (4223, 'Quang Nam Province', 234);
INSERT INTO estados VALUES (4224, 'Soc Trang', 234);
INSERT INTO estados VALUES (4225, 'Son La', 234);
INSERT INTO estados VALUES (4226, 'Song Be', 234);
INSERT INTO estados VALUES (4227, 'Tay Ninh', 234);
INSERT INTO estados VALUES (4228, 'Thai Binh', 234);
INSERT INTO estados VALUES (4229, 'Thanh Hoa', 234);
INSERT INTO estados VALUES (4230, 'Thua Thien', 234);
INSERT INTO estados VALUES (4231, 'Thai Nguy?n Province', 234);
INSERT INTO estados VALUES (4232, 'Tien Giang', 234);
INSERT INTO estados VALUES (4233, 'Tra Vinh', 234);
INSERT INTO estados VALUES (4234, 'Tuyen Quang', 234);
INSERT INTO estados VALUES (4235, 'Vinh Long', 234);
INSERT INTO estados VALUES (4236, 'Vinh Phu', 234);
INSERT INTO estados VALUES (4237, 'Vinh Phu T?nh', 234);
INSERT INTO estados VALUES (4238, 'Yen Bai', 234);
INSERT INTO estados VALUES (4239, 'Dong Thap Province', 234);
INSERT INTO estados VALUES (4240, 'Virgin Islands, British (General)', 235);
INSERT INTO estados VALUES (4241, 'Virgin Islands, U.S. (General)', 236);
INSERT INTO estados VALUES (4242, 'Western Sahara (General)', 237);
INSERT INTO estados VALUES (4243, 'Abyan', 238);
INSERT INTO estados VALUES (4244, 'Adan', 238);
INSERT INTO estados VALUES (4245, 'Adan Governorate', 238);
INSERT INTO estados VALUES (4246, 'Al Bayda', 238);
INSERT INTO estados VALUES (4247, 'Al Hudaydah', 238);
INSERT INTO estados VALUES (4248, 'Al Jawf', 238);
INSERT INTO estados VALUES (4249, 'Al Mahrah', 238);
INSERT INTO estados VALUES (4250, 'Al Mahwit', 238);
INSERT INTO estados VALUES (4251, 'Dhamar', 238);
INSERT INTO estados VALUES (4252, 'Hadramawt', 238);
INSERT INTO estados VALUES (4253, 'Hajjah', 238);
INSERT INTO estados VALUES (4254, 'Ibb', 238);
INSERT INTO estados VALUES (4255, 'Lahij', 238);
INSERT INTO estados VALUES (4256, 'Ma rib', 238);
INSERT INTO estados VALUES (4257, 'Sa', 238);
INSERT INTO estados VALUES (4258, 'San', 238);
INSERT INTO estados VALUES (4259, 'Shabwah', 238);
INSERT INTO estados VALUES (4260, 'Ta', 238);
INSERT INTO estados VALUES (4261, 'Taizz Governorate', 238);
INSERT INTO estados VALUES (4262, 'Bandundu', 239);
INSERT INTO estados VALUES (4263, 'Bas-Congo', 239);
INSERT INTO estados VALUES (4264, 'Equateur', 239);
INSERT INTO estados VALUES (4265, 'Kasai-Occidental', 239);
INSERT INTO estados VALUES (4266, 'Kasai-Oriental', 239);
INSERT INTO estados VALUES (4267, 'Katanga', 239);
INSERT INTO estados VALUES (4268, 'Kinshasa', 239);
INSERT INTO estados VALUES (4269, 'Kivu', 239);
INSERT INTO estados VALUES (4270, 'Maniema', 239);
INSERT INTO estados VALUES (4271, 'Nord-Kivu', 239);
INSERT INTO estados VALUES (4272, 'Orientale', 239);
INSERT INTO estados VALUES (4273, 'Sud-Kivu', 239);
INSERT INTO estados VALUES (4274, 'Central', 240);
INSERT INTO estados VALUES (4275, 'Copperbelt', 240);
INSERT INTO estados VALUES (4276, 'Eastern', 240);
INSERT INTO estados VALUES (4277, 'Luapula', 240);
INSERT INTO estados VALUES (4278, 'Lusaka', 240);
INSERT INTO estados VALUES (4279, 'North-Western', 240);
INSERT INTO estados VALUES (4280, 'Northern', 240);
INSERT INTO estados VALUES (4281, 'Southern', 240);
INSERT INTO estados VALUES (4282, 'Western', 240);
INSERT INTO estados VALUES (4283, 'Bulawayo', 241);
INSERT INTO estados VALUES (4284, 'Harare', 241);
INSERT INTO estados VALUES (4285, 'Manicaland', 241);
INSERT INTO estados VALUES (4286, 'Mashonaland Central', 241);
INSERT INTO estados VALUES (4287, 'Mashonaland East', 241);
INSERT INTO estados VALUES (4288, 'Mashonaland West', 241);
INSERT INTO estados VALUES (4289, 'Masvingo', 241);
INSERT INTO estados VALUES (4290, 'Matabeleland North', 241);
INSERT INTO estados VALUES (4291, 'Matabeleland South', 241);
INSERT INTO estados VALUES (4292, 'Midlands', 241);


--
-- TOC entry 2138 (class 0 OID 21395)
-- Dependencies: 167
-- Data for Name: etapas; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2139 (class 0 OID 21400)
-- Dependencies: 169
-- Data for Name: expedientes; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2140 (class 0 OID 21408)
-- Dependencies: 171
-- Data for Name: interesados; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2141 (class 0 OID 21413)
-- Dependencies: 173
-- Data for Name: logs_usuarios; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO logs_usuarios VALUES (5, 1, 'El usuario con la C.I. 17693788 ha sido autenticado correctamente y ha ingresado al sistema.', 'EXITOSO', '2012-05-06 18:39:52');
INSERT INTO logs_usuarios VALUES (6, 1, 'El usuario con la C.I. 17693788 ha sido autenticado correctamente y ha ingresado al sistema.', 'EXITOSO', '2012-05-08 06:55:05');
INSERT INTO logs_usuarios VALUES (7, 1, 'El usuario con la C.I. 17693788 ha sido autenticado correctamente y ha ingresado al sistema.', 'EXITOSO', '2012-05-16 23:50:08');
INSERT INTO logs_usuarios VALUES (8, 1, 'El usuario con la C.I. 17693788 ha sido autenticado correctamente y ha ingresado al sistema.', 'EXITOSO', '2012-05-17 05:59:17');


--
-- TOC entry 2142 (class 0 OID 21426)
-- Dependencies: 175
-- Data for Name: organismos; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2143 (class 0 OID 21431)
-- Dependencies: 177
-- Data for Name: paises; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO paises VALUES (1, 'Afganistan');
INSERT INTO paises VALUES (2, 'Albania');
INSERT INTO paises VALUES (3, 'Alemania');
INSERT INTO paises VALUES (4, 'American Samoa');
INSERT INTO paises VALUES (5, 'Andorra');
INSERT INTO paises VALUES (6, 'Angola');
INSERT INTO paises VALUES (7, 'Anguila');
INSERT INTO paises VALUES (8, 'Antigua and Barbuda');
INSERT INTO paises VALUES (9, 'Antillas Holandesas');
INSERT INTO paises VALUES (10, 'Antartida');
INSERT INTO paises VALUES (11, 'Arabia Saudita');
INSERT INTO paises VALUES (12, 'Argelia');
INSERT INTO paises VALUES (13, 'Argentina');
INSERT INTO paises VALUES (14, 'Armenia');
INSERT INTO paises VALUES (15, 'Aruba');
INSERT INTO paises VALUES (17, 'Australia');
INSERT INTO paises VALUES (18, 'Austria');
INSERT INTO paises VALUES (19, 'Azerbaijan');
INSERT INTO paises VALUES (20, 'Bahamas');
INSERT INTO paises VALUES (21, 'Bahrein');
INSERT INTO paises VALUES (22, 'Bangladesh');
INSERT INTO paises VALUES (23, 'Barbados');
INSERT INTO paises VALUES (24, 'Belice');
INSERT INTO paises VALUES (25, 'Benin');
INSERT INTO paises VALUES (26, 'Bermuda');
INSERT INTO paises VALUES (27, 'Bielorrusia');
INSERT INTO paises VALUES (28, 'Bolivia');
INSERT INTO paises VALUES (29, 'Bosnia y Herzegovina');
INSERT INTO paises VALUES (30, 'Botsuana');
INSERT INTO paises VALUES (31, 'Bouvet Island');
INSERT INTO paises VALUES (32, 'Brasil');
INSERT INTO paises VALUES (33, 'British Indian Ocean Territory');
INSERT INTO paises VALUES (34, 'Brunei Darussalam');
INSERT INTO paises VALUES (35, 'Bulgaria');
INSERT INTO paises VALUES (36, 'Burkina Faso');
INSERT INTO paises VALUES (37, 'Burundi');
INSERT INTO paises VALUES (38, 'Butan');
INSERT INTO paises VALUES (39, 'Belgica');
INSERT INTO paises VALUES (40, 'Cabo Verda');
INSERT INTO paises VALUES (41, 'Camboya');
INSERT INTO paises VALUES (42, 'Camerun');
INSERT INTO paises VALUES (44, 'Canada');
INSERT INTO paises VALUES (45, 'Chad');
INSERT INTO paises VALUES (46, 'Chile');
INSERT INTO paises VALUES (47, 'China');
INSERT INTO paises VALUES (48, 'Chipre');
INSERT INTO paises VALUES (49, 'Colombia');
INSERT INTO paises VALUES (50, 'Comores');
INSERT INTO paises VALUES (51, 'Congo');
INSERT INTO paises VALUES (52, 'Corea del Norte');
INSERT INTO paises VALUES (53, 'Corea del Sur');
INSERT INTO paises VALUES (54, 'Costa Rica');
INSERT INTO paises VALUES (55, 'Cote D Ivoire');
INSERT INTO paises VALUES (56, 'Croacia');
INSERT INTO paises VALUES (57, 'Cuba');
INSERT INTO paises VALUES (58, 'Dinamarca');
INSERT INTO paises VALUES (59, 'Djibouti');
INSERT INTO paises VALUES (60, 'Dominica');
INSERT INTO paises VALUES (61, 'East Timor');
INSERT INTO paises VALUES (62, 'Ecuador');
INSERT INTO paises VALUES (63, 'Egipto');
INSERT INTO paises VALUES (64, 'El Salvador');
INSERT INTO paises VALUES (65, 'El Vaticano');
INSERT INTO paises VALUES (66, 'Emiratos Arabes Unidos');
INSERT INTO paises VALUES (67, 'Eritrea');
INSERT INTO paises VALUES (68, 'Eslovaquia');
INSERT INTO paises VALUES (69, 'Eslovenia');
INSERT INTO paises VALUES (70, 'España');
INSERT INTO paises VALUES (71, 'Estados Unidos');
INSERT INTO paises VALUES (72, 'Estonia');
INSERT INTO paises VALUES (73, 'Etiopia');
INSERT INTO paises VALUES (74, 'Fiji');
INSERT INTO paises VALUES (75, 'Filipinas');
INSERT INTO paises VALUES (76, 'Finlandia');
INSERT INTO paises VALUES (77, 'Francia');
INSERT INTO paises VALUES (78, 'French Guiana');
INSERT INTO paises VALUES (79, 'French Polynesia');
INSERT INTO paises VALUES (80, 'French Southern Territories');
INSERT INTO paises VALUES (81, 'Gabon');
INSERT INTO paises VALUES (82, 'Gambia');
INSERT INTO paises VALUES (83, 'Georgia');
INSERT INTO paises VALUES (84, 'Ghana');
INSERT INTO paises VALUES (85, 'Gibraltar');
INSERT INTO paises VALUES (86, 'Granada');
INSERT INTO paises VALUES (87, 'Grecia');
INSERT INTO paises VALUES (88, 'Groenlandia');
INSERT INTO paises VALUES (89, 'Guadalupe');
INSERT INTO paises VALUES (90, 'Guam');
INSERT INTO paises VALUES (91, 'Guatemala');
INSERT INTO paises VALUES (92, 'Guinea');
INSERT INTO paises VALUES (93, 'Guinea Ecuatorial');
INSERT INTO paises VALUES (94, 'Guinea-Bissau');
INSERT INTO paises VALUES (95, 'Guyana');
INSERT INTO paises VALUES (96, 'Haiti');
INSERT INTO paises VALUES (97, 'Heard Island and McDonald Isla');
INSERT INTO paises VALUES (98, 'Holanda');
INSERT INTO paises VALUES (99, 'Honduras');
INSERT INTO paises VALUES (100, 'Hong Kong');
INSERT INTO paises VALUES (101, 'Hungria');
INSERT INTO paises VALUES (102, 'India');
INSERT INTO paises VALUES (103, 'Indonesia');
INSERT INTO paises VALUES (104, 'Iraq');
INSERT INTO paises VALUES (105, 'Irlanda');
INSERT INTO paises VALUES (106, 'Isalas Cocos');
INSERT INTO paises VALUES (107, 'Isla Christmas');
INSERT INTO paises VALUES (108, 'Islandia');
INSERT INTO paises VALUES (109, 'Islas Caiman');
INSERT INTO paises VALUES (110, 'Islas Cook');
INSERT INTO paises VALUES (111, 'Islas Feroe');
INSERT INTO paises VALUES (112, 'Islas Malvinas');
INSERT INTO paises VALUES (113, 'Islas Marshall');
INSERT INTO paises VALUES (114, 'Islas Mauricio');
INSERT INTO paises VALUES (115, 'Islas Salomon');
INSERT INTO paises VALUES (116, 'Islas Sandwhich');
INSERT INTO paises VALUES (117, 'Islas Turks y Caicos');
INSERT INTO paises VALUES (118, 'Islas Wallis y Futuna');
INSERT INTO paises VALUES (119, 'Israel');
INSERT INTO paises VALUES (120, 'Italia');
INSERT INTO paises VALUES (121, 'Jamaica');
INSERT INTO paises VALUES (122, 'Japon');
INSERT INTO paises VALUES (123, 'Jordania');
INSERT INTO paises VALUES (124, 'Kazakhstan');
INSERT INTO paises VALUES (125, 'Kenia');
INSERT INTO paises VALUES (126, 'Kiribati');
INSERT INTO paises VALUES (127, 'Kuwait');
INSERT INTO paises VALUES (128, 'Kyrgyzstan');
INSERT INTO paises VALUES (129, 'Laos');
INSERT INTO paises VALUES (130, 'Latvia');
INSERT INTO paises VALUES (131, 'Lesoto');
INSERT INTO paises VALUES (132, 'Liberia');
INSERT INTO paises VALUES (133, 'Libia');
INSERT INTO paises VALUES (134, 'Liechtenstein');
INSERT INTO paises VALUES (135, 'Lituania');
INSERT INTO paises VALUES (136, 'Luxemburgo');
INSERT INTO paises VALUES (137, 'Libano');
INSERT INTO paises VALUES (138, 'Macao');
INSERT INTO paises VALUES (139, 'Macedonia');
INSERT INTO paises VALUES (140, 'Madagascar');
INSERT INTO paises VALUES (141, 'Malasia');
INSERT INTO paises VALUES (142, 'Malaui');
INSERT INTO paises VALUES (143, 'Maldivas');
INSERT INTO paises VALUES (144, 'Malta');
INSERT INTO paises VALUES (145, 'Mali');
INSERT INTO paises VALUES (146, 'Marruecos');
INSERT INTO paises VALUES (147, 'Martinique');
INSERT INTO paises VALUES (148, 'Mauritania');
INSERT INTO paises VALUES (149, 'Mayotte');
INSERT INTO paises VALUES (150, 'Micronesia');
INSERT INTO paises VALUES (151, 'Moldavia');
INSERT INTO paises VALUES (152, 'Mongolia');
INSERT INTO paises VALUES (153, 'Montserrat');
INSERT INTO paises VALUES (154, 'Mozambique');
INSERT INTO paises VALUES (155, 'Myanmar');
INSERT INTO paises VALUES (156, 'Mexico');
INSERT INTO paises VALUES (157, 'Monaco');
INSERT INTO paises VALUES (158, 'Namibia');
INSERT INTO paises VALUES (159, 'Nauru');
INSERT INTO paises VALUES (160, 'Nepal');
INSERT INTO paises VALUES (161, 'Nicaragua');
INSERT INTO paises VALUES (162, 'Nigeria');
INSERT INTO paises VALUES (163, 'Niue');
INSERT INTO paises VALUES (164, 'Norfolk Island');
INSERT INTO paises VALUES (165, 'Northern Mariana Islands');
INSERT INTO paises VALUES (166, 'Noruega');
INSERT INTO paises VALUES (167, 'Nueva Caledonia');
INSERT INTO paises VALUES (168, 'Nueva Zelanda');
INSERT INTO paises VALUES (169, 'Niger');
INSERT INTO paises VALUES (170, 'Oman');
INSERT INTO paises VALUES (171, 'Pakistan');
INSERT INTO paises VALUES (172, 'Palau');
INSERT INTO paises VALUES (173, 'Palestinian Territory');
INSERT INTO paises VALUES (174, 'Panama');
INSERT INTO paises VALUES (175, 'Papua Nueva Guinea');
INSERT INTO paises VALUES (176, 'Paraguay');
INSERT INTO paises VALUES (177, 'Peru');
INSERT INTO paises VALUES (178, 'Pitcairn');
INSERT INTO paises VALUES (179, 'Polonia');
INSERT INTO paises VALUES (180, 'Portugal');
INSERT INTO paises VALUES (181, 'Puerto Rico');
INSERT INTO paises VALUES (182, 'Qatar');
INSERT INTO paises VALUES (183, 'Reino Unido');
INSERT INTO paises VALUES (184, 'Republica Centroafricana');
INSERT INTO paises VALUES (185, 'Republica Checa');
INSERT INTO paises VALUES (186, 'Republica Democratica del Cong');
INSERT INTO paises VALUES (187, 'Republica Dominicana');
INSERT INTO paises VALUES (188, 'Republica Islamica de Iran');
INSERT INTO paises VALUES (189, 'Ruanda');
INSERT INTO paises VALUES (190, 'Rumania');
INSERT INTO paises VALUES (191, 'Rusian');
INSERT INTO paises VALUES (192, 'Saint Kitts and Nevis');
INSERT INTO paises VALUES (193, 'Saint Pierre y Miquelon');
INSERT INTO paises VALUES (194, 'Samoa');
INSERT INTO paises VALUES (195, 'San Marino');
INSERT INTO paises VALUES (196, 'San Vicente y Las Granadinas');
INSERT INTO paises VALUES (197, 'Santa Elena');
INSERT INTO paises VALUES (198, 'Santa Lucia');
INSERT INTO paises VALUES (199, 'Sao Tome and Principe');
INSERT INTO paises VALUES (200, 'Senegal');
INSERT INTO paises VALUES (201, 'Serbia y Montenegro');
INSERT INTO paises VALUES (202, 'Seychelles');
INSERT INTO paises VALUES (203, 'Sierra Leona');
INSERT INTO paises VALUES (204, 'Singapur');
INSERT INTO paises VALUES (205, 'Siria');
INSERT INTO paises VALUES (206, 'Somalia');
INSERT INTO paises VALUES (207, 'Sri Lanka');
INSERT INTO paises VALUES (208, 'Suazilandia');
INSERT INTO paises VALUES (209, 'Sudafrica');
INSERT INTO paises VALUES (210, 'Sudan');
INSERT INTO paises VALUES (211, 'Suecia');
INSERT INTO paises VALUES (212, 'Suiza');
INSERT INTO paises VALUES (213, 'Surinam');
INSERT INTO paises VALUES (214, 'Svalbard and Jan Mayen');
INSERT INTO paises VALUES (215, 'Tailandia');
INSERT INTO paises VALUES (216, 'Taiwan');
INSERT INTO paises VALUES (217, 'Tajikistan');
INSERT INTO paises VALUES (218, 'Tanzania');
INSERT INTO paises VALUES (219, 'Togo');
INSERT INTO paises VALUES (220, 'Tonga');
INSERT INTO paises VALUES (221, 'Toquelau');
INSERT INTO paises VALUES (222, 'Trinidad y Tobago');
INSERT INTO paises VALUES (223, 'Turkmenistan');
INSERT INTO paises VALUES (224, 'Turquia');
INSERT INTO paises VALUES (225, 'Tuvalu');
INSERT INTO paises VALUES (226, 'Tunez');
INSERT INTO paises VALUES (227, 'Ucrania');
INSERT INTO paises VALUES (228, 'Uganda');
INSERT INTO paises VALUES (229, 'United States Minor Outlying I');
INSERT INTO paises VALUES (230, 'Uruguay');
INSERT INTO paises VALUES (231, 'Uzbekistan');
INSERT INTO paises VALUES (232, 'Vanuatu');
INSERT INTO paises VALUES (233, 'Venezuela');
INSERT INTO paises VALUES (234, 'Vietnam');
INSERT INTO paises VALUES (235, 'Virgin Islands British');
INSERT INTO paises VALUES (236, 'Virgin Islands U.S.');
INSERT INTO paises VALUES (237, 'Western Sahara');
INSERT INTO paises VALUES (238, 'Yemen');
INSERT INTO paises VALUES (239, 'Zaire');
INSERT INTO paises VALUES (240, 'Zambia');
INSERT INTO paises VALUES (241, 'Zimbabue');


--
-- TOC entry 2144 (class 0 OID 21436)
-- Dependencies: 179
-- Data for Name: perfiles; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO perfiles VALUES (1, 'Abogado Coordinador', 'Representa el Abogado Jefe y tiene los permisos para cerrar casos así como realizar la asignación de expedientes en un determinado proceso a otros abogados.');
INSERT INTO perfiles VALUES (2, 'Abogado Asignado', 'Representa al Abogado al cual le es asignado un expediente, tiene permisos de llevar a cabo todos los cambios en las etapas de un expediente en el proceso en el cual le fué asignado dicho expediente.');
INSERT INTO perfiles VALUES (3, 'Administrador', 'Tiene todos los derechos de Superusuario');


--
-- TOC entry 2145 (class 0 OID 21441)
-- Dependencies: 181
-- Data for Name: personas; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO personas VALUES (1, 'José Gabriel', 'Gonzalez', 'V', 17693788, 4166075731, 4265124336, 233, 4153, 'jgabrielsinner10@gmail.com');


--
-- TOC entry 2146 (class 0 OID 21446)
-- Dependencies: 183
-- Data for Name: procesos; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2147 (class 0 OID 21451)
-- Dependencies: 185
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO usuarios VALUES (1, '17693788', 'b87eedb67d0ac6a5b410031d35839371d27666ade08c55ba71cc5e30b775765d1d0d7cbe642b7fe27b493131e7f24e7953efdbf65d29cf71f9ecaa152e582eb9', '3c9909afec25354d551dae21590bb26e38d53f2173b8d3dc3eee4c047e7ab1c1eb8b85103e3be7ba613b31bb5c9c36214dc9f14a42fd7a2fdb84856bca5c44c2', 'SI', 1, 1, '2012-05-16', NULL);


--
-- TOC entry 2114 (class 2606 OID 26188)
-- Dependencies: 188 188
-- Name: bitaco_mov_id_pk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY bitacoras
    ADD CONSTRAINT bitaco_mov_id_pk PRIMARY KEY (id_bitacora);


--
-- TOC entry 2094 (class 2606 OID 26007)
-- Dependencies: 181 181
-- Name: cedula_de_identidad_uk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY personas
    ADD CONSTRAINT cedula_de_identidad_uk UNIQUE (cedula_de_identidad);


--
-- TOC entry 2058 (class 2606 OID 26009)
-- Dependencies: 161 161
-- Name: consulta_id_pk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY consultas
    ADD CONSTRAINT consulta_id_pk PRIMARY KEY (id_consulta);


--
-- TOC entry 2060 (class 2606 OID 26011)
-- Dependencies: 163 163
-- Name: control_mov_id_pk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY control_movimientos
    ADD CONSTRAINT control_mov_id_pk PRIMARY KEY (id_control_movimientos);


--
-- TOC entry 2062 (class 2606 OID 26013)
-- Dependencies: 163 163 163 163
-- Name: control_movimiento_uk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY control_movimientos
    ADD CONSTRAINT control_movimiento_uk UNIQUE (id_expidiente, id_proceso, id_etapa);


--
-- TOC entry 2064 (class 2606 OID 26015)
-- Dependencies: 165 165
-- Name: estado_pk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY estados
    ADD CONSTRAINT estado_pk PRIMARY KEY (id_estado);


--
-- TOC entry 2066 (class 2606 OID 26017)
-- Dependencies: 167 167
-- Name: etaba_abrev_uk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY etapas
    ADD CONSTRAINT etaba_abrev_uk UNIQUE (etapa_abrev);


--
-- TOC entry 2068 (class 2606 OID 26019)
-- Dependencies: 167 167
-- Name: etapa_consecutivo_uk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY etapas
    ADD CONSTRAINT etapa_consecutivo_uk UNIQUE (nro_consecutivo_etapa);


--
-- TOC entry 2070 (class 2606 OID 26021)
-- Dependencies: 167 167
-- Name: etapa_desc_uk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY etapas
    ADD CONSTRAINT etapa_desc_uk UNIQUE (etapa);


--
-- TOC entry 2072 (class 2606 OID 26023)
-- Dependencies: 167 167
-- Name: etapa_id_pk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY etapas
    ADD CONSTRAINT etapa_id_pk PRIMARY KEY (id_etapa);


--
-- TOC entry 2074 (class 2606 OID 26025)
-- Dependencies: 169 169
-- Name: id_expediente_pk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY expedientes
    ADD CONSTRAINT id_expediente_pk PRIMARY KEY (id_expediente);


--
-- TOC entry 2076 (class 2606 OID 26027)
-- Dependencies: 171 171
-- Name: id_interesado_pk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY interesados
    ADD CONSTRAINT id_interesado_pk PRIMARY KEY (id_interesado);


--
-- TOC entry 2090 (class 2606 OID 26029)
-- Dependencies: 179 179
-- Name: id_perfil_pk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY perfiles
    ADD CONSTRAINT id_perfil_pk PRIMARY KEY (id_perfil);


--
-- TOC entry 2106 (class 2606 OID 26031)
-- Dependencies: 185 185
-- Name: id_usuario_pk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY usuarios
    ADD CONSTRAINT id_usuario_pk PRIMARY KEY (id_usuario);


--
-- TOC entry 2078 (class 2606 OID 26033)
-- Dependencies: 173 173
-- Name: log_usuario_id_pk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY logs_usuarios
    ADD CONSTRAINT log_usuario_id_pk PRIMARY KEY (id_log_usuario);


--
-- TOC entry 2080 (class 2606 OID 26039)
-- Dependencies: 175 175
-- Name: organismo_id_pk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY organismos
    ADD CONSTRAINT organismo_id_pk PRIMARY KEY (id_organismo);


--
-- TOC entry 2082 (class 2606 OID 26041)
-- Dependencies: 175 175
-- Name: organismo_nombre_uk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY organismos
    ADD CONSTRAINT organismo_nombre_uk UNIQUE (nombre_organismo);


--
-- TOC entry 2084 (class 2606 OID 26043)
-- Dependencies: 175 175
-- Name: organismo_rif_uk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY organismos
    ADD CONSTRAINT organismo_rif_uk UNIQUE (rif);


--
-- TOC entry 2086 (class 2606 OID 26045)
-- Dependencies: 177 177
-- Name: pais_pk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY paises
    ADD CONSTRAINT pais_pk PRIMARY KEY (id_pais);


--
-- TOC entry 2088 (class 2606 OID 26047)
-- Dependencies: 177 177
-- Name: pais_uk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY paises
    ADD CONSTRAINT pais_uk UNIQUE (pais);


--
-- TOC entry 2092 (class 2606 OID 26049)
-- Dependencies: 179 179
-- Name: perfil; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY perfiles
    ADD CONSTRAINT perfil UNIQUE (perfil);


--
-- TOC entry 2096 (class 2606 OID 26051)
-- Dependencies: 181 181
-- Name: personas_pk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY personas
    ADD CONSTRAINT personas_pk PRIMARY KEY (id_persona);


--
-- TOC entry 2098 (class 2606 OID 26053)
-- Dependencies: 183 183
-- Name: proceso_abrev_uk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY procesos
    ADD CONSTRAINT proceso_abrev_uk UNIQUE (proceso_abrev);


--
-- TOC entry 2100 (class 2606 OID 26055)
-- Dependencies: 183 183
-- Name: proceso_consecutivo_uk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY procesos
    ADD CONSTRAINT proceso_consecutivo_uk UNIQUE (nro_consecutivo_proceso);


--
-- TOC entry 2102 (class 2606 OID 26057)
-- Dependencies: 183 183
-- Name: proceso_desc_uk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY procesos
    ADD CONSTRAINT proceso_desc_uk UNIQUE (proceso_abrev);


--
-- TOC entry 2104 (class 2606 OID 26059)
-- Dependencies: 183 183
-- Name: proceso_id_pk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY procesos
    ADD CONSTRAINT proceso_id_pk PRIMARY KEY (id_proceso);


--
-- TOC entry 2108 (class 2606 OID 26061)
-- Dependencies: 185 185
-- Name: usuario_encrypt_uk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY usuarios
    ADD CONSTRAINT usuario_encrypt_uk UNIQUE (usuario_encrypt);


--
-- TOC entry 2110 (class 2606 OID 26063)
-- Dependencies: 185 185
-- Name: usuario_persona_uk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY usuarios
    ADD CONSTRAINT usuario_persona_uk UNIQUE (id_persona);


--
-- TOC entry 2112 (class 2606 OID 26065)
-- Dependencies: 185 185
-- Name: usuario_uk; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY usuarios
    ADD CONSTRAINT usuario_uk UNIQUE (usuario);


--
-- TOC entry 2134 (class 2606 OID 26189)
-- Dependencies: 2073 188 169
-- Name: bitaco_expediente_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY bitacoras
    ADD CONSTRAINT bitaco_expediente_fk FOREIGN KEY (id_expidiente) REFERENCES expedientes(id_expediente);


--
-- TOC entry 2127 (class 2606 OID 26066)
-- Dependencies: 171 181 2093
-- Name: cedula_de_identidad_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY interesados
    ADD CONSTRAINT cedula_de_identidad_fk FOREIGN KEY (cedula_de_identidad) REFERENCES personas(cedula_de_identidad);


--
-- TOC entry 2115 (class 2606 OID 26071)
-- Dependencies: 169 2073 161
-- Name: consulta_expediente_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY consultas
    ADD CONSTRAINT consulta_expediente_fk FOREIGN KEY (id_expediente) REFERENCES expedientes(id_expediente);


--
-- TOC entry 2116 (class 2606 OID 26076)
-- Dependencies: 2105 185 163
-- Name: control_abog_asignado_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY control_movimientos
    ADD CONSTRAINT control_abog_asignado_fk FOREIGN KEY (id_abogado_asign) REFERENCES usuarios(id_usuario);


--
-- TOC entry 2117 (class 2606 OID 26081)
-- Dependencies: 185 163 2105
-- Name: control_abog_coordinador_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY control_movimientos
    ADD CONSTRAINT control_abog_coordinador_fk FOREIGN KEY (id_abogado_coord) REFERENCES usuarios(id_usuario);


--
-- TOC entry 2118 (class 2606 OID 26086)
-- Dependencies: 2071 163 167
-- Name: control_etapa_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY control_movimientos
    ADD CONSTRAINT control_etapa_fk FOREIGN KEY (id_etapa) REFERENCES etapas(id_etapa);


--
-- TOC entry 2119 (class 2606 OID 26091)
-- Dependencies: 2073 169 163
-- Name: control_expediente_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY control_movimientos
    ADD CONSTRAINT control_expediente_fk FOREIGN KEY (id_expidiente) REFERENCES expedientes(id_expediente);


--
-- TOC entry 2120 (class 2606 OID 26096)
-- Dependencies: 163 2103 183
-- Name: control_proceso_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY control_movimientos
    ADD CONSTRAINT control_proceso_fk FOREIGN KEY (id_proceso) REFERENCES procesos(id_proceso);


--
-- TOC entry 2121 (class 2606 OID 26101)
-- Dependencies: 2085 165 177
-- Name: estado_pais_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY estados
    ADD CONSTRAINT estado_pais_fk FOREIGN KEY (id_pais) REFERENCES paises(id_pais);


--
-- TOC entry 2122 (class 2606 OID 26106)
-- Dependencies: 183 2103 167
-- Name: etapa_de_proceso_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY etapas
    ADD CONSTRAINT etapa_de_proceso_fk FOREIGN KEY (id_proceso) REFERENCES procesos(id_proceso);


--
-- TOC entry 2123 (class 2606 OID 26111)
-- Dependencies: 2071 169 167
-- Name: id_etapa_actual_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY expedientes
    ADD CONSTRAINT id_etapa_actual_fk FOREIGN KEY (id_etapa_actual) REFERENCES etapas(id_etapa);


--
-- TOC entry 2128 (class 2606 OID 26116)
-- Dependencies: 2073 171 169
-- Name: id_expediente_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY interesados
    ADD CONSTRAINT id_expediente_fk FOREIGN KEY (id_expediente) REFERENCES expedientes(id_expediente);


--
-- TOC entry 2124 (class 2606 OID 26121)
-- Dependencies: 2079 169 175
-- Name: id_organismo_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY expedientes
    ADD CONSTRAINT id_organismo_fk FOREIGN KEY (id_organismo) REFERENCES organismos(id_organismo);


--
-- TOC entry 2125 (class 2606 OID 26126)
-- Dependencies: 183 2103 169
-- Name: id_proceso_actual_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY expedientes
    ADD CONSTRAINT id_proceso_actual_fk FOREIGN KEY (id_proceso_actual) REFERENCES procesos(id_proceso);


--
-- TOC entry 2126 (class 2606 OID 26131)
-- Dependencies: 185 2105 169
-- Name: id_usuario_reg_inicial_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY expedientes
    ADD CONSTRAINT id_usuario_reg_inicial_fk FOREIGN KEY (id_usuario_ini) REFERENCES usuarios(id_usuario);


--
-- TOC entry 2129 (class 2606 OID 26136)
-- Dependencies: 2105 185 173
-- Name: log_usuario_reg_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY logs_usuarios
    ADD CONSTRAINT log_usuario_reg_fk FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario);


--
-- TOC entry 2130 (class 2606 OID 26156)
-- Dependencies: 2063 165 181
-- Name: persona_estado_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY personas
    ADD CONSTRAINT persona_estado_fk FOREIGN KEY (id_estado) REFERENCES estados(id_estado);


--
-- TOC entry 2131 (class 2606 OID 26161)
-- Dependencies: 2085 177 181
-- Name: persona_pais_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY personas
    ADD CONSTRAINT persona_pais_fk FOREIGN KEY (id_pais) REFERENCES paises(id_pais);


--
-- TOC entry 2132 (class 2606 OID 26166)
-- Dependencies: 2089 179 185
-- Name: usuario_perfil_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY usuarios
    ADD CONSTRAINT usuario_perfil_fk FOREIGN KEY (id_perfil) REFERENCES perfiles(id_perfil);


--
-- TOC entry 2133 (class 2606 OID 26171)
-- Dependencies: 185 181 2095
-- Name: usuario_persona_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY usuarios
    ADD CONSTRAINT usuario_persona_fk FOREIGN KEY (id_persona) REFERENCES personas(id_persona);


--
-- TOC entry 2153 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: -
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2012-05-17 07:14:19 VET

--
-- PostgreSQL database dump complete
--

