--
-- PostgreSQL database dump
--

\restrict Pgg5kED8wvkNNZuvOrqEwoH5zqA7QlQyX5zvUs9vOquNXJ0cFs1yzHdZOQSAjDv

-- Dumped from database version 16.14
-- Dumped by pg_dump version 16.14

-- Started on 2026-07-01 21:47:07

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = on;

--
-- TOC entry 6 (class 2615 OID 30566)
-- Name: library; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA library;


SET default_table_access_method = heap;

--
-- TOC entry 235 (class 1259 OID 30710)
-- Name: audit_logs; Type: TABLE; Schema: library; Owner: -
--

CREATE TABLE library.audit_logs (
    id bigint NOT NULL,
    user_id bigint,
    action character varying(100) NOT NULL,
    entity_name character varying(100) NOT NULL,
    entity_id bigint,
    old_values jsonb,
    new_values jsonb,
    ip_address inet,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- TOC entry 234 (class 1259 OID 30709)
-- Name: audit_logs_id_seq; Type: SEQUENCE; Schema: library; Owner: -
--

CREATE SEQUENCE library.audit_logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5099 (class 0 OID 0)
-- Dependencies: 234
-- Name: audit_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: library; Owner: -
--

ALTER SEQUENCE library.audit_logs_id_seq OWNED BY library.audit_logs.id;


--
-- TOC entry 221 (class 1259 OID 30597)
-- Name: authors; Type: TABLE; Schema: library; Owner: -
--

CREATE TABLE library.authors (
    id bigint NOT NULL,
    full_name character varying(255) NOT NULL,
    birth_year smallint,
    death_year smallint,
    country character varying(100),
    biography text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_birth_year CHECK (((birth_year IS NULL) OR ((birth_year >= 1000) AND (birth_year <= (EXTRACT(year FROM CURRENT_DATE))::integer))))
);


--
-- TOC entry 220 (class 1259 OID 30596)
-- Name: authors_id_seq; Type: SEQUENCE; Schema: library; Owner: -
--

CREATE SEQUENCE library.authors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5100 (class 0 OID 0)
-- Dependencies: 220
-- Name: authors_id_seq; Type: SEQUENCE OWNED BY; Schema: library; Owner: -
--

ALTER SEQUENCE library.authors_id_seq OWNED BY library.authors.id;


--
-- TOC entry 245 (class 1259 OID 30781)
-- Name: book_conditions; Type: TABLE; Schema: library; Owner: -
--

CREATE TABLE library.book_conditions (
    id smallint NOT NULL,
    name character varying(40),
    description character varying(255)
);


--
-- TOC entry 244 (class 1259 OID 30780)
-- Name: book_conditions_id_seq; Type: SEQUENCE; Schema: library; Owner: -
--

CREATE SEQUENCE library.book_conditions_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5101 (class 0 OID 0)
-- Dependencies: 244
-- Name: book_conditions_id_seq; Type: SEQUENCE OWNED BY; Schema: library; Owner: -
--

ALTER SEQUENCE library.book_conditions_id_seq OWNED BY library.book_conditions.id;


--
-- TOC entry 227 (class 1259 OID 30628)
-- Name: books; Type: TABLE; Schema: library; Owner: -
--

CREATE TABLE library.books (
    id bigint NOT NULL,
    title character varying(500) NOT NULL,
    isbn character varying(20),
    publication_year smallint,
    description text,
    category_id bigint NOT NULL,
    author_id bigint NOT NULL,
    publisher_id bigint NOT NULL,
    language character varying(50),
    page_count integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone,
    language_id smallint,
    CONSTRAINT chk_books_pages CHECK ((page_count > 0)),
    CONSTRAINT chk_books_year CHECK (((publication_year >= 1500) AND (publication_year <= (EXTRACT(year FROM CURRENT_DATE))::integer)))
);


--
-- TOC entry 226 (class 1259 OID 30627)
-- Name: books_id_seq; Type: SEQUENCE; Schema: library; Owner: -
--

CREATE SEQUENCE library.books_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5102 (class 0 OID 0)
-- Dependencies: 226
-- Name: books_id_seq; Type: SEQUENCE OWNED BY; Schema: library; Owner: -
--

ALTER SEQUENCE library.books_id_seq OWNED BY library.books.id;


--
-- TOC entry 225 (class 1259 OID 30617)
-- Name: categories; Type: TABLE; Schema: library; Owner: -
--

CREATE TABLE library.categories (
    id bigint NOT NULL,
    name character varying(150) NOT NULL,
    description text
);


--
-- TOC entry 224 (class 1259 OID 30616)
-- Name: categories_id_seq; Type: SEQUENCE; Schema: library; Owner: -
--

CREATE SEQUENCE library.categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5103 (class 0 OID 0)
-- Dependencies: 224
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: library; Owner: -
--

ALTER SEQUENCE library.categories_id_seq OWNED BY library.categories.id;


--
-- TOC entry 229 (class 1259 OID 30656)
-- Name: copies; Type: TABLE; Schema: library; Owner: -
--

CREATE TABLE library.copies (
    id bigint NOT NULL,
    book_id bigint NOT NULL,
    inventory_number character varying(30) NOT NULL,
    barcode character varying(50),
    location character varying(100),
    acquisition_date date,
    condition character varying(50),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    status_id smallint NOT NULL
);


--
-- TOC entry 228 (class 1259 OID 30655)
-- Name: copies_id_seq; Type: SEQUENCE; Schema: library; Owner: -
--

CREATE SEQUENCE library.copies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5104 (class 0 OID 0)
-- Dependencies: 228
-- Name: copies_id_seq; Type: SEQUENCE OWNED BY; Schema: library; Owner: -
--

ALTER SEQUENCE library.copies_id_seq OWNED BY library.copies.id;


--
-- TOC entry 237 (class 1259 OID 30729)
-- Name: copy_statuses; Type: TABLE; Schema: library; Owner: -
--

CREATE TABLE library.copy_statuses (
    id smallint NOT NULL,
    name character varying(30) NOT NULL,
    description character varying(255)
);


--
-- TOC entry 236 (class 1259 OID 30728)
-- Name: copy_statuses_id_seq; Type: SEQUENCE; Schema: library; Owner: -
--

CREATE SEQUENCE library.copy_statuses_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5105 (class 0 OID 0)
-- Dependencies: 236
-- Name: copy_statuses_id_seq; Type: SEQUENCE OWNED BY; Schema: library; Owner: -
--

ALTER SEQUENCE library.copy_statuses_id_seq OWNED BY library.copy_statuses.id;


--
-- TOC entry 247 (class 1259 OID 30790)
-- Name: countries; Type: TABLE; Schema: library; Owner: -
--

CREATE TABLE library.countries (
    id smallint NOT NULL,
    name character varying(100),
    iso_code character(2)
);


--
-- TOC entry 246 (class 1259 OID 30789)
-- Name: countries_id_seq; Type: SEQUENCE; Schema: library; Owner: -
--

CREATE SEQUENCE library.countries_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5106 (class 0 OID 0)
-- Dependencies: 246
-- Name: countries_id_seq; Type: SEQUENCE OWNED BY; Schema: library; Owner: -
--

ALTER SEQUENCE library.countries_id_seq OWNED BY library.countries.id;


--
-- TOC entry 243 (class 1259 OID 30772)
-- Name: languages; Type: TABLE; Schema: library; Owner: -
--

CREATE TABLE library.languages (
    id smallint NOT NULL,
    code character varying(5) NOT NULL,
    name character varying(100) NOT NULL
);


--
-- TOC entry 242 (class 1259 OID 30771)
-- Name: languages_id_seq; Type: SEQUENCE; Schema: library; Owner: -
--

CREATE SEQUENCE library.languages_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5107 (class 0 OID 0)
-- Dependencies: 242
-- Name: languages_id_seq; Type: SEQUENCE OWNED BY; Schema: library; Owner: -
--

ALTER SEQUENCE library.languages_id_seq OWNED BY library.languages.id;


--
-- TOC entry 239 (class 1259 OID 30738)
-- Name: loan_statuses; Type: TABLE; Schema: library; Owner: -
--

CREATE TABLE library.loan_statuses (
    id smallint NOT NULL,
    name character varying(30) NOT NULL,
    description character varying(255)
);


--
-- TOC entry 238 (class 1259 OID 30737)
-- Name: loan_statuses_id_seq; Type: SEQUENCE; Schema: library; Owner: -
--

CREATE SEQUENCE library.loan_statuses_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5108 (class 0 OID 0)
-- Dependencies: 238
-- Name: loan_statuses_id_seq; Type: SEQUENCE OWNED BY; Schema: library; Owner: -
--

ALTER SEQUENCE library.loan_statuses_id_seq OWNED BY library.loan_statuses.id;


--
-- TOC entry 231 (class 1259 OID 30672)
-- Name: loans; Type: TABLE; Schema: library; Owner: -
--

CREATE TABLE library.loans (
    id bigint NOT NULL,
    copy_id bigint NOT NULL,
    user_id bigint NOT NULL,
    loan_date date NOT NULL,
    due_date date NOT NULL,
    return_date date,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    status_id smallint NOT NULL,
    CONSTRAINT chk_loans_dates CHECK ((due_date >= loan_date))
);


--
-- TOC entry 230 (class 1259 OID 30671)
-- Name: loans_id_seq; Type: SEQUENCE; Schema: library; Owner: -
--

CREATE SEQUENCE library.loans_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5109 (class 0 OID 0)
-- Dependencies: 230
-- Name: loans_id_seq; Type: SEQUENCE OWNED BY; Schema: library; Owner: -
--

ALTER SEQUENCE library.loans_id_seq OWNED BY library.loans.id;


--
-- TOC entry 249 (class 1259 OID 30797)
-- Name: locations; Type: TABLE; Schema: library; Owner: -
--

CREATE TABLE library.locations (
    id integer NOT NULL,
    building character varying(100),
    reading_room character varying(100),
    shelf character varying(50),
    rack character varying(50)
);


--
-- TOC entry 248 (class 1259 OID 30796)
-- Name: locations_id_seq; Type: SEQUENCE; Schema: library; Owner: -
--

CREATE SEQUENCE library.locations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5110 (class 0 OID 0)
-- Dependencies: 248
-- Name: locations_id_seq; Type: SEQUENCE OWNED BY; Schema: library; Owner: -
--

ALTER SEQUENCE library.locations_id_seq OWNED BY library.locations.id;


--
-- TOC entry 223 (class 1259 OID 30607)
-- Name: publishers; Type: TABLE; Schema: library; Owner: -
--

CREATE TABLE library.publishers (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    city character varying(100),
    website character varying(255),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- TOC entry 222 (class 1259 OID 30606)
-- Name: publishers_id_seq; Type: SEQUENCE; Schema: library; Owner: -
--

CREATE SEQUENCE library.publishers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5111 (class 0 OID 0)
-- Dependencies: 222
-- Name: publishers_id_seq; Type: SEQUENCE OWNED BY; Schema: library; Owner: -
--

ALTER SEQUENCE library.publishers_id_seq OWNED BY library.publishers.id;


--
-- TOC entry 241 (class 1259 OID 30747)
-- Name: reservation_statuses; Type: TABLE; Schema: library; Owner: -
--

CREATE TABLE library.reservation_statuses (
    id smallint NOT NULL,
    name character varying(30) NOT NULL,
    description character varying(255)
);


--
-- TOC entry 240 (class 1259 OID 30746)
-- Name: reservation_statuses_id_seq; Type: SEQUENCE; Schema: library; Owner: -
--

CREATE SEQUENCE library.reservation_statuses_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5112 (class 0 OID 0)
-- Dependencies: 240
-- Name: reservation_statuses_id_seq; Type: SEQUENCE OWNED BY; Schema: library; Owner: -
--

ALTER SEQUENCE library.reservation_statuses_id_seq OWNED BY library.reservation_statuses.id;


--
-- TOC entry 233 (class 1259 OID 30692)
-- Name: reservations; Type: TABLE; Schema: library; Owner: -
--

CREATE TABLE library.reservations (
    id bigint NOT NULL,
    copy_id bigint NOT NULL,
    user_id bigint NOT NULL,
    reservation_date date NOT NULL,
    expiration_date date,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    status_id smallint NOT NULL
);


--
-- TOC entry 232 (class 1259 OID 30691)
-- Name: reservations_id_seq; Type: SEQUENCE; Schema: library; Owner: -
--

CREATE SEQUENCE library.reservations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5113 (class 0 OID 0)
-- Dependencies: 232
-- Name: reservations_id_seq; Type: SEQUENCE OWNED BY; Schema: library; Owner: -
--

ALTER SEQUENCE library.reservations_id_seq OWNED BY library.reservations.id;


--
-- TOC entry 217 (class 1259 OID 30568)
-- Name: roles; Type: TABLE; Schema: library; Owner: -
--

CREATE TABLE library.roles (
    id bigint NOT NULL,
    name character varying(50) NOT NULL,
    description character varying(255),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- TOC entry 216 (class 1259 OID 30567)
-- Name: roles_id_seq; Type: SEQUENCE; Schema: library; Owner: -
--

CREATE SEQUENCE library.roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5114 (class 0 OID 0)
-- Dependencies: 216
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: library; Owner: -
--

ALTER SEQUENCE library.roles_id_seq OWNED BY library.roles.id;


--
-- TOC entry 219 (class 1259 OID 30578)
-- Name: users; Type: TABLE; Schema: library; Owner: -
--

CREATE TABLE library.users (
    id bigint NOT NULL,
    role_id bigint NOT NULL,
    username character varying(50) NOT NULL,
    email character varying(255) NOT NULL,
    password_hash character varying(255) NOT NULL,
    full_name character varying(255) NOT NULL,
    reader_ticket_number character varying(20) NOT NULL,
    phone character varying(20),
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone
);


--
-- TOC entry 218 (class 1259 OID 30577)
-- Name: users_id_seq; Type: SEQUENCE; Schema: library; Owner: -
--

CREATE SEQUENCE library.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5115 (class 0 OID 0)
-- Dependencies: 218
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: library; Owner: -
--

ALTER SEQUENCE library.users_id_seq OWNED BY library.users.id;


--
-- TOC entry 4834 (class 2604 OID 30713)
-- Name: audit_logs id; Type: DEFAULT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.audit_logs ALTER COLUMN id SET DEFAULT nextval('library.audit_logs_id_seq'::regclass);


--
-- TOC entry 4821 (class 2604 OID 30600)
-- Name: authors id; Type: DEFAULT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.authors ALTER COLUMN id SET DEFAULT nextval('library.authors_id_seq'::regclass);


--
-- TOC entry 4840 (class 2604 OID 30784)
-- Name: book_conditions id; Type: DEFAULT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.book_conditions ALTER COLUMN id SET DEFAULT nextval('library.book_conditions_id_seq'::regclass);


--
-- TOC entry 4826 (class 2604 OID 30631)
-- Name: books id; Type: DEFAULT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.books ALTER COLUMN id SET DEFAULT nextval('library.books_id_seq'::regclass);


--
-- TOC entry 4825 (class 2604 OID 30620)
-- Name: categories id; Type: DEFAULT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.categories ALTER COLUMN id SET DEFAULT nextval('library.categories_id_seq'::regclass);


--
-- TOC entry 4828 (class 2604 OID 30659)
-- Name: copies id; Type: DEFAULT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.copies ALTER COLUMN id SET DEFAULT nextval('library.copies_id_seq'::regclass);


--
-- TOC entry 4836 (class 2604 OID 30732)
-- Name: copy_statuses id; Type: DEFAULT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.copy_statuses ALTER COLUMN id SET DEFAULT nextval('library.copy_statuses_id_seq'::regclass);


--
-- TOC entry 4841 (class 2604 OID 30793)
-- Name: countries id; Type: DEFAULT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.countries ALTER COLUMN id SET DEFAULT nextval('library.countries_id_seq'::regclass);


--
-- TOC entry 4839 (class 2604 OID 30775)
-- Name: languages id; Type: DEFAULT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.languages ALTER COLUMN id SET DEFAULT nextval('library.languages_id_seq'::regclass);


--
-- TOC entry 4837 (class 2604 OID 30741)
-- Name: loan_statuses id; Type: DEFAULT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.loan_statuses ALTER COLUMN id SET DEFAULT nextval('library.loan_statuses_id_seq'::regclass);


--
-- TOC entry 4830 (class 2604 OID 30675)
-- Name: loans id; Type: DEFAULT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.loans ALTER COLUMN id SET DEFAULT nextval('library.loans_id_seq'::regclass);


--
-- TOC entry 4842 (class 2604 OID 30800)
-- Name: locations id; Type: DEFAULT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.locations ALTER COLUMN id SET DEFAULT nextval('library.locations_id_seq'::regclass);


--
-- TOC entry 4823 (class 2604 OID 30610)
-- Name: publishers id; Type: DEFAULT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.publishers ALTER COLUMN id SET DEFAULT nextval('library.publishers_id_seq'::regclass);


--
-- TOC entry 4838 (class 2604 OID 30750)
-- Name: reservation_statuses id; Type: DEFAULT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.reservation_statuses ALTER COLUMN id SET DEFAULT nextval('library.reservation_statuses_id_seq'::regclass);


--
-- TOC entry 4832 (class 2604 OID 30695)
-- Name: reservations id; Type: DEFAULT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.reservations ALTER COLUMN id SET DEFAULT nextval('library.reservations_id_seq'::regclass);


--
-- TOC entry 4816 (class 2604 OID 30571)
-- Name: roles id; Type: DEFAULT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.roles ALTER COLUMN id SET DEFAULT nextval('library.roles_id_seq'::regclass);


--
-- TOC entry 4818 (class 2604 OID 30581)
-- Name: users id; Type: DEFAULT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.users ALTER COLUMN id SET DEFAULT nextval('library.users_id_seq'::regclass);


--
-- TOC entry 5079 (class 0 OID 30710)
-- Dependencies: 235
-- Data for Name: audit_logs; Type: TABLE DATA; Schema: library; Owner: -
--

INSERT INTO library.audit_logs (id, user_id, action, entity_name, entity_id, old_values, new_values, ip_address, created_at) VALUES (1, 1, 'CREATE', 'Book', 6, NULL, '{"title": "Новая книга"}', '127.0.0.1', '2026-07-01 20:43:57.308722');
INSERT INTO library.audit_logs (id, user_id, action, entity_name, entity_id, old_values, new_values, ip_address, created_at) VALUES (2, 2, 'UPDATE', 'Copy', 3, '{"status": "Available"}', '{"status": "Loaned"}', '127.0.0.1', '2026-07-01 20:43:57.308722');
INSERT INTO library.audit_logs (id, user_id, action, entity_name, entity_id, old_values, new_values, ip_address, created_at) VALUES (3, 1, 'DELETE', 'Reservation', 3, '{"status": "Cancelled"}', NULL, '127.0.0.1', '2026-07-01 20:43:57.308722');


--
-- TOC entry 5065 (class 0 OID 30597)
-- Dependencies: 221
-- Data for Name: authors; Type: TABLE DATA; Schema: library; Owner: -
--

INSERT INTO library.authors (id, full_name, birth_year, death_year, country, biography, created_at) VALUES (1, 'Роберт Мартин', 1952, NULL, 'США', 'Автор книг по разработке программного обеспечения', '2026-07-01 20:42:50.607834');
INSERT INTO library.authors (id, full_name, birth_year, death_year, country, biography, created_at) VALUES (2, 'Мартин Фаулер', 1963, NULL, 'Великобритания', 'Эксперт в области архитектуры ПО', '2026-07-01 20:42:50.607834');
INSERT INTO library.authors (id, full_name, birth_year, death_year, country, biography, created_at) VALUES (3, 'Эндрю Троелсен', 1970, NULL, 'США', 'Автор книг по C#', '2026-07-01 20:42:50.607834');
INSERT INTO library.authors (id, full_name, birth_year, death_year, country, biography, created_at) VALUES (4, 'Кристофер Дейт', 1941, NULL, 'Великобритания', 'Специалист по базам данных', '2026-07-01 20:42:50.607834');
INSERT INTO library.authors (id, full_name, birth_year, death_year, country, biography, created_at) VALUES (5, 'Лев Толстой', 1828, 1910, 'Россия', 'Русский писатель', '2026-07-01 20:42:50.607834');


--
-- TOC entry 5089 (class 0 OID 30781)
-- Dependencies: 245
-- Data for Name: book_conditions; Type: TABLE DATA; Schema: library; Owner: -
--



--
-- TOC entry 5071 (class 0 OID 30628)
-- Dependencies: 227
-- Data for Name: books; Type: TABLE DATA; Schema: library; Owner: -
--

INSERT INTO library.books (id, title, isbn, publication_year, description, category_id, author_id, publisher_id, language, page_count, created_at, updated_at, language_id) VALUES (1, 'Чистая архитектура', '9785446116186', 2022, 'Архитектура программного обеспечения', 1, 1, 1, 'Русский', 352, '2026-07-01 20:43:30.356551', NULL, NULL);
INSERT INTO library.books (id, title, isbn, publication_year, description, category_id, author_id, publisher_id, language, page_count, created_at, updated_at, language_id) VALUES (2, 'Архитектура корпоративных приложений', '9785845905796', 2019, 'Корпоративные приложения', 2, 2, 3, 'Русский', 544, '2026-07-01 20:43:30.356551', NULL, NULL);
INSERT INTO library.books (id, title, isbn, publication_year, description, category_id, author_id, publisher_id, language, page_count, created_at, updated_at, language_id) VALUES (3, 'Язык программирования C#', '9786010842726', 2023, 'C# и .NET', 1, 3, 2, 'Русский', 1100, '2026-07-01 20:43:30.356551', NULL, NULL);
INSERT INTO library.books (id, title, isbn, publication_year, description, category_id, author_id, publisher_id, language, page_count, created_at, updated_at, language_id) VALUES (4, 'Введение в системы баз данных', '9785845920850', 2021, 'Реляционные базы данных', 2, 4, 3, 'Русский', 1328, '2026-07-01 20:43:30.356551', NULL, NULL);
INSERT INTO library.books (id, title, isbn, publication_year, description, category_id, author_id, publisher_id, language, page_count, created_at, updated_at, language_id) VALUES (5, 'Война и мир', '9785170908767', 2018, 'Роман', 5, 5, 1, 'Русский', 1225, '2026-07-01 20:43:30.356551', NULL, NULL);


--
-- TOC entry 5069 (class 0 OID 30617)
-- Dependencies: 225
-- Data for Name: categories; Type: TABLE DATA; Schema: library; Owner: -
--

INSERT INTO library.categories (id, name, description) VALUES (1, 'Программирование', 'Книги по программированию');
INSERT INTO library.categories (id, name, description) VALUES (2, 'Информационные технологии', 'ИТ литература');
INSERT INTO library.categories (id, name, description) VALUES (3, 'Математика', 'Научная литература');
INSERT INTO library.categories (id, name, description) VALUES (4, 'История', 'Историческая литература');
INSERT INTO library.categories (id, name, description) VALUES (5, 'Художественная литература', 'Художественные произведения');


--
-- TOC entry 5073 (class 0 OID 30656)
-- Dependencies: 229
-- Data for Name: copies; Type: TABLE DATA; Schema: library; Owner: -
--

INSERT INTO library.copies (id, book_id, inventory_number, barcode, location, acquisition_date, condition, created_at, status_id) VALUES (1, 1, 'INV000001', '460000000001', 'Фонд А-101', '2024-01-15', 'Good', '2026-07-01 20:43:36.376143', 1);
INSERT INTO library.copies (id, book_id, inventory_number, barcode, location, acquisition_date, condition, created_at, status_id) VALUES (2, 1, 'INV000002', '460000000002', 'Фонд А-101', '2024-01-15', 'Good', '2026-07-01 20:43:36.376143', 2);
INSERT INTO library.copies (id, book_id, inventory_number, barcode, location, acquisition_date, condition, created_at, status_id) VALUES (3, 2, 'INV000003', '460000000003', 'Фонд А-102', '2024-02-11', 'Excellent', '2026-07-01 20:43:36.376143', 1);
INSERT INTO library.copies (id, book_id, inventory_number, barcode, location, acquisition_date, condition, created_at, status_id) VALUES (4, 3, 'INV000004', '460000000004', 'Фонд Б-201', '2024-03-08', 'Excellent', '2026-07-01 20:43:36.376143', 3);
INSERT INTO library.copies (id, book_id, inventory_number, barcode, location, acquisition_date, condition, created_at, status_id) VALUES (5, 4, 'INV000005', '460000000005', 'Фонд В-301', '2024-04-17', 'Good', '2026-07-01 20:43:36.376143', 1);
INSERT INTO library.copies (id, book_id, inventory_number, barcode, location, acquisition_date, condition, created_at, status_id) VALUES (6, 5, 'INV000006', '460000000006', 'Основное хранение', '2023-12-01', 'Fair', '2026-07-01 20:43:36.376143', 2);
INSERT INTO library.copies (id, book_id, inventory_number, barcode, location, acquisition_date, condition, created_at, status_id) VALUES (7, 5, 'INV000007', '460000000007', 'Основное хранение', '2024-01-10', 'Excellent', '2026-07-01 20:43:36.376143', 1);


--
-- TOC entry 5081 (class 0 OID 30729)
-- Dependencies: 237
-- Data for Name: copy_statuses; Type: TABLE DATA; Schema: library; Owner: -
--

INSERT INTO library.copy_statuses (id, name, description) VALUES (1, 'Available', 'Экземпляр доступен');
INSERT INTO library.copy_statuses (id, name, description) VALUES (2, 'Loaned', 'Выдан читателю');
INSERT INTO library.copy_statuses (id, name, description) VALUES (3, 'Reserved', 'Зарезервирован');
INSERT INTO library.copy_statuses (id, name, description) VALUES (4, 'Lost', 'Утерян');
INSERT INTO library.copy_statuses (id, name, description) VALUES (5, 'Repair', 'На реставрации');


--
-- TOC entry 5091 (class 0 OID 30790)
-- Dependencies: 247
-- Data for Name: countries; Type: TABLE DATA; Schema: library; Owner: -
--



--
-- TOC entry 5087 (class 0 OID 30772)
-- Dependencies: 243
-- Data for Name: languages; Type: TABLE DATA; Schema: library; Owner: -
--



--
-- TOC entry 5083 (class 0 OID 30738)
-- Dependencies: 239
-- Data for Name: loan_statuses; Type: TABLE DATA; Schema: library; Owner: -
--

INSERT INTO library.loan_statuses (id, name, description) VALUES (1, 'Active', 'Книга выдана');
INSERT INTO library.loan_statuses (id, name, description) VALUES (2, 'Returned', 'Возвращена');
INSERT INTO library.loan_statuses (id, name, description) VALUES (3, 'Overdue', 'Просрочена');


--
-- TOC entry 5075 (class 0 OID 30672)
-- Dependencies: 231
-- Data for Name: loans; Type: TABLE DATA; Schema: library; Owner: -
--

INSERT INTO library.loans (id, copy_id, user_id, loan_date, due_date, return_date, created_at, status_id) VALUES (1, 2, 3, '2026-06-15', '2026-07-15', NULL, '2026-07-01 20:43:42.585265', 1);
INSERT INTO library.loans (id, copy_id, user_id, loan_date, due_date, return_date, created_at, status_id) VALUES (2, 6, 4, '2026-05-01', '2026-06-01', NULL, '2026-07-01 20:43:42.585265', 3);
INSERT INTO library.loans (id, copy_id, user_id, loan_date, due_date, return_date, created_at, status_id) VALUES (3, 1, 5, '2026-04-01', '2026-05-01', '2026-04-28', '2026-07-01 20:43:42.585265', 2);


--
-- TOC entry 5093 (class 0 OID 30797)
-- Dependencies: 249
-- Data for Name: locations; Type: TABLE DATA; Schema: library; Owner: -
--



--
-- TOC entry 5067 (class 0 OID 30607)
-- Dependencies: 223
-- Data for Name: publishers; Type: TABLE DATA; Schema: library; Owner: -
--

INSERT INTO library.publishers (id, name, city, website, created_at) VALUES (1, 'Питер', 'Санкт-Петербург', 'https://piter.com', '2026-07-01 20:43:03.979108');
INSERT INTO library.publishers (id, name, city, website, created_at) VALUES (2, 'Диалектика', 'Киев', 'https://dialektika.com', '2026-07-01 20:43:03.979108');
INSERT INTO library.publishers (id, name, city, website, created_at) VALUES (3, 'Вильямс', 'Москва', 'https://williamspublishing.com', '2026-07-01 20:43:03.979108');


--
-- TOC entry 5085 (class 0 OID 30747)
-- Dependencies: 241
-- Data for Name: reservation_statuses; Type: TABLE DATA; Schema: library; Owner: -
--

INSERT INTO library.reservation_statuses (id, name, description) VALUES (1, 'Waiting', 'Ожидает');
INSERT INTO library.reservation_statuses (id, name, description) VALUES (2, 'Ready', 'Готово к выдаче');
INSERT INTO library.reservation_statuses (id, name, description) VALUES (3, 'Completed', 'Получено');
INSERT INTO library.reservation_statuses (id, name, description) VALUES (4, 'Cancelled', 'Отменено');


--
-- TOC entry 5077 (class 0 OID 30692)
-- Dependencies: 233
-- Data for Name: reservations; Type: TABLE DATA; Schema: library; Owner: -
--

INSERT INTO library.reservations (id, copy_id, user_id, reservation_date, expiration_date, created_at, status_id) VALUES (1, 4, 3, '2026-06-20', '2026-07-05', '2026-07-01 20:43:50.896334', 1);
INSERT INTO library.reservations (id, copy_id, user_id, reservation_date, expiration_date, created_at, status_id) VALUES (2, 5, 4, '2026-06-10', '2026-06-30', '2026-07-01 20:43:50.896334', 2);
INSERT INTO library.reservations (id, copy_id, user_id, reservation_date, expiration_date, created_at, status_id) VALUES (3, 7, 5, '2026-05-01', '2026-05-15', '2026-07-01 20:43:50.896334', 4);


--
-- TOC entry 5061 (class 0 OID 30568)
-- Dependencies: 217
-- Data for Name: roles; Type: TABLE DATA; Schema: library; Owner: -
--

INSERT INTO library.roles (id, name, description, created_at) VALUES (1, 'Administrator', 'Полный доступ к системе', '2026-07-01 20:40:21.243796');
INSERT INTO library.roles (id, name, description, created_at) VALUES (2, 'Librarian', 'Работа с библиотечным фондом', '2026-07-01 20:40:21.243796');
INSERT INTO library.roles (id, name, description, created_at) VALUES (3, 'Reader', 'Читатель библиотеки', '2026-07-01 20:40:21.243796');


--
-- TOC entry 5063 (class 0 OID 30578)
-- Dependencies: 219
-- Data for Name: users; Type: TABLE DATA; Schema: library; Owner: -
--

INSERT INTO library.users (id, role_id, username, email, password_hash, full_name, reader_ticket_number, phone, is_active, created_at, updated_at) VALUES (1, 1, 'admin', 'admin@library.local', 'admin', 'Администратор системы', '000001', '79990000001', true, '2026-07-01 20:43:16.885888', NULL);
INSERT INTO library.users (id, role_id, username, email, password_hash, full_name, reader_ticket_number, phone, is_active, created_at, updated_at) VALUES (2, 2, 'librarian', 'librarian@library.local', 'librarian', 'Мария Петрова', '000002', '79990000002', true, '2026-07-01 20:43:16.885888', NULL);
INSERT INTO library.users (id, role_id, username, email, password_hash, full_name, reader_ticket_number, phone, is_active, created_at, updated_at) VALUES (3, 3, 'reader1', 'reader1@mail.ru', 'reader1', 'Иван Иванов', '100001', '79990000003', true, '2026-07-01 20:43:16.885888', NULL);
INSERT INTO library.users (id, role_id, username, email, password_hash, full_name, reader_ticket_number, phone, is_active, created_at, updated_at) VALUES (4, 3, 'reader2', 'reader2@mail.ru', 'reader2', 'Анна Смирнова', '100002', '79990000004', true, '2026-07-01 20:43:16.885888', NULL);
INSERT INTO library.users (id, role_id, username, email, password_hash, full_name, reader_ticket_number, phone, is_active, created_at, updated_at) VALUES (5, 3, 'reader3', 'reader3@mail.ru', 'reader3', 'Павел Соколов', '100003', '79990000005', true, '2026-07-01 20:43:16.885888', NULL);


--
-- TOC entry 5116 (class 0 OID 0)
-- Dependencies: 234
-- Name: audit_logs_id_seq; Type: SEQUENCE SET; Schema: library; Owner: -
--

SELECT pg_catalog.setval('library.audit_logs_id_seq', 3, true);


--
-- TOC entry 5117 (class 0 OID 0)
-- Dependencies: 220
-- Name: authors_id_seq; Type: SEQUENCE SET; Schema: library; Owner: -
--

SELECT pg_catalog.setval('library.authors_id_seq', 5, true);


--
-- TOC entry 5118 (class 0 OID 0)
-- Dependencies: 244
-- Name: book_conditions_id_seq; Type: SEQUENCE SET; Schema: library; Owner: -
--

SELECT pg_catalog.setval('library.book_conditions_id_seq', 1, false);


--
-- TOC entry 5119 (class 0 OID 0)
-- Dependencies: 226
-- Name: books_id_seq; Type: SEQUENCE SET; Schema: library; Owner: -
--

SELECT pg_catalog.setval('library.books_id_seq', 5, true);


--
-- TOC entry 5120 (class 0 OID 0)
-- Dependencies: 224
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: library; Owner: -
--

SELECT pg_catalog.setval('library.categories_id_seq', 5, true);


--
-- TOC entry 5121 (class 0 OID 0)
-- Dependencies: 228
-- Name: copies_id_seq; Type: SEQUENCE SET; Schema: library; Owner: -
--

SELECT pg_catalog.setval('library.copies_id_seq', 7, true);


--
-- TOC entry 5122 (class 0 OID 0)
-- Dependencies: 236
-- Name: copy_statuses_id_seq; Type: SEQUENCE SET; Schema: library; Owner: -
--

SELECT pg_catalog.setval('library.copy_statuses_id_seq', 6, true);


--
-- TOC entry 5123 (class 0 OID 0)
-- Dependencies: 246
-- Name: countries_id_seq; Type: SEQUENCE SET; Schema: library; Owner: -
--

SELECT pg_catalog.setval('library.countries_id_seq', 1, false);


--
-- TOC entry 5124 (class 0 OID 0)
-- Dependencies: 242
-- Name: languages_id_seq; Type: SEQUENCE SET; Schema: library; Owner: -
--

SELECT pg_catalog.setval('library.languages_id_seq', 1, false);


--
-- TOC entry 5125 (class 0 OID 0)
-- Dependencies: 238
-- Name: loan_statuses_id_seq; Type: SEQUENCE SET; Schema: library; Owner: -
--

SELECT pg_catalog.setval('library.loan_statuses_id_seq', 3, true);


--
-- TOC entry 5126 (class 0 OID 0)
-- Dependencies: 230
-- Name: loans_id_seq; Type: SEQUENCE SET; Schema: library; Owner: -
--

SELECT pg_catalog.setval('library.loans_id_seq', 3, true);


--
-- TOC entry 5127 (class 0 OID 0)
-- Dependencies: 248
-- Name: locations_id_seq; Type: SEQUENCE SET; Schema: library; Owner: -
--

SELECT pg_catalog.setval('library.locations_id_seq', 1, false);


--
-- TOC entry 5128 (class 0 OID 0)
-- Dependencies: 222
-- Name: publishers_id_seq; Type: SEQUENCE SET; Schema: library; Owner: -
--

SELECT pg_catalog.setval('library.publishers_id_seq', 3, true);


--
-- TOC entry 5129 (class 0 OID 0)
-- Dependencies: 240
-- Name: reservation_statuses_id_seq; Type: SEQUENCE SET; Schema: library; Owner: -
--

SELECT pg_catalog.setval('library.reservation_statuses_id_seq', 4, true);


--
-- TOC entry 5130 (class 0 OID 0)
-- Dependencies: 232
-- Name: reservations_id_seq; Type: SEQUENCE SET; Schema: library; Owner: -
--

SELECT pg_catalog.setval('library.reservations_id_seq', 3, true);


--
-- TOC entry 5131 (class 0 OID 0)
-- Dependencies: 216
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: library; Owner: -
--

SELECT pg_catalog.setval('library.roles_id_seq', 3, true);


--
-- TOC entry 5132 (class 0 OID 0)
-- Dependencies: 218
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: library; Owner: -
--

SELECT pg_catalog.setval('library.users_id_seq', 5, true);


--
-- TOC entry 4879 (class 2606 OID 30718)
-- Name: audit_logs audit_logs_pkey; Type: CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.audit_logs
    ADD CONSTRAINT audit_logs_pkey PRIMARY KEY (id);


--
-- TOC entry 4857 (class 2606 OID 30605)
-- Name: authors authors_pkey; Type: CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.authors
    ADD CONSTRAINT authors_pkey PRIMARY KEY (id);


--
-- TOC entry 4897 (class 2606 OID 30788)
-- Name: book_conditions book_conditions_name_key; Type: CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.book_conditions
    ADD CONSTRAINT book_conditions_name_key UNIQUE (name);


--
-- TOC entry 4899 (class 2606 OID 30786)
-- Name: book_conditions book_conditions_pkey; Type: CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.book_conditions
    ADD CONSTRAINT book_conditions_pkey PRIMARY KEY (id);


--
-- TOC entry 4865 (class 2606 OID 30636)
-- Name: books books_pkey; Type: CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.books
    ADD CONSTRAINT books_pkey PRIMARY KEY (id);


--
-- TOC entry 4861 (class 2606 OID 30626)
-- Name: categories categories_name_key; Type: CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.categories
    ADD CONSTRAINT categories_name_key UNIQUE (name);


--
-- TOC entry 4863 (class 2606 OID 30624)
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- TOC entry 4870 (class 2606 OID 30662)
-- Name: copies copies_pkey; Type: CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.copies
    ADD CONSTRAINT copies_pkey PRIMARY KEY (id);


--
-- TOC entry 4881 (class 2606 OID 30736)
-- Name: copy_statuses copy_statuses_name_key; Type: CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.copy_statuses
    ADD CONSTRAINT copy_statuses_name_key UNIQUE (name);


--
-- TOC entry 4883 (class 2606 OID 30734)
-- Name: copy_statuses copy_statuses_pkey; Type: CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.copy_statuses
    ADD CONSTRAINT copy_statuses_pkey PRIMARY KEY (id);


--
-- TOC entry 4901 (class 2606 OID 30795)
-- Name: countries countries_pkey; Type: CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.countries
    ADD CONSTRAINT countries_pkey PRIMARY KEY (id);


--
-- TOC entry 4893 (class 2606 OID 30779)
-- Name: languages languages_code_key; Type: CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.languages
    ADD CONSTRAINT languages_code_key UNIQUE (code);


--
-- TOC entry 4895 (class 2606 OID 30777)
-- Name: languages languages_pkey; Type: CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.languages
    ADD CONSTRAINT languages_pkey PRIMARY KEY (id);


--
-- TOC entry 4885 (class 2606 OID 30745)
-- Name: loan_statuses loan_statuses_name_key; Type: CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.loan_statuses
    ADD CONSTRAINT loan_statuses_name_key UNIQUE (name);


--
-- TOC entry 4887 (class 2606 OID 30743)
-- Name: loan_statuses loan_statuses_pkey; Type: CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.loan_statuses
    ADD CONSTRAINT loan_statuses_pkey PRIMARY KEY (id);


--
-- TOC entry 4875 (class 2606 OID 30678)
-- Name: loans loans_pkey; Type: CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.loans
    ADD CONSTRAINT loans_pkey PRIMARY KEY (id);


--
-- TOC entry 4903 (class 2606 OID 30802)
-- Name: locations locations_pkey; Type: CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);


--
-- TOC entry 4859 (class 2606 OID 30615)
-- Name: publishers publishers_pkey; Type: CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.publishers
    ADD CONSTRAINT publishers_pkey PRIMARY KEY (id);


--
-- TOC entry 4889 (class 2606 OID 30754)
-- Name: reservation_statuses reservation_statuses_name_key; Type: CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.reservation_statuses
    ADD CONSTRAINT reservation_statuses_name_key UNIQUE (name);


--
-- TOC entry 4891 (class 2606 OID 30752)
-- Name: reservation_statuses reservation_statuses_pkey; Type: CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.reservation_statuses
    ADD CONSTRAINT reservation_statuses_pkey PRIMARY KEY (id);


--
-- TOC entry 4877 (class 2606 OID 30698)
-- Name: reservations reservations_pkey; Type: CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.reservations
    ADD CONSTRAINT reservations_pkey PRIMARY KEY (id);


--
-- TOC entry 4848 (class 2606 OID 30576)
-- Name: roles roles_name_key; Type: CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.roles
    ADD CONSTRAINT roles_name_key UNIQUE (name);


--
-- TOC entry 4850 (class 2606 OID 30574)
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- TOC entry 4852 (class 2606 OID 30587)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 4866 (class 1259 OID 30654)
-- Name: ix_books_author; Type: INDEX; Schema: library; Owner: -
--

CREATE INDEX ix_books_author ON library.books USING btree (author_id);


--
-- TOC entry 4867 (class 1259 OID 30653)
-- Name: ix_books_title; Type: INDEX; Schema: library; Owner: -
--

CREATE INDEX ix_books_title ON library.books USING btree (title);


--
-- TOC entry 4873 (class 1259 OID 30690)
-- Name: ix_loans_user; Type: INDEX; Schema: library; Owner: -
--

CREATE INDEX ix_loans_user ON library.loans USING btree (user_id);


--
-- TOC entry 4868 (class 1259 OID 30652)
-- Name: ux_books_isbn; Type: INDEX; Schema: library; Owner: -
--

CREATE UNIQUE INDEX ux_books_isbn ON library.books USING btree (isbn);


--
-- TOC entry 4871 (class 1259 OID 30669)
-- Name: ux_copy_barcode; Type: INDEX; Schema: library; Owner: -
--

CREATE UNIQUE INDEX ux_copy_barcode ON library.copies USING btree (barcode);


--
-- TOC entry 4872 (class 1259 OID 30668)
-- Name: ux_copy_inventory; Type: INDEX; Schema: library; Owner: -
--

CREATE UNIQUE INDEX ux_copy_inventory ON library.copies USING btree (inventory_number);


--
-- TOC entry 4853 (class 1259 OID 30594)
-- Name: ux_users_email; Type: INDEX; Schema: library; Owner: -
--

CREATE UNIQUE INDEX ux_users_email ON library.users USING btree (email);


--
-- TOC entry 4854 (class 1259 OID 30595)
-- Name: ux_users_ticket; Type: INDEX; Schema: library; Owner: -
--

CREATE UNIQUE INDEX ux_users_ticket ON library.users USING btree (reader_ticket_number);


--
-- TOC entry 4855 (class 1259 OID 30593)
-- Name: ux_users_username; Type: INDEX; Schema: library; Owner: -
--

CREATE UNIQUE INDEX ux_users_username ON library.users USING btree (username);


--
-- TOC entry 4916 (class 2606 OID 30719)
-- Name: audit_logs fk_audit_user; Type: FK CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.audit_logs
    ADD CONSTRAINT fk_audit_user FOREIGN KEY (user_id) REFERENCES library.users(id);


--
-- TOC entry 4905 (class 2606 OID 30642)
-- Name: books fk_book_author; Type: FK CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.books
    ADD CONSTRAINT fk_book_author FOREIGN KEY (author_id) REFERENCES library.authors(id);


--
-- TOC entry 4906 (class 2606 OID 30637)
-- Name: books fk_book_category; Type: FK CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.books
    ADD CONSTRAINT fk_book_category FOREIGN KEY (category_id) REFERENCES library.categories(id);


--
-- TOC entry 4907 (class 2606 OID 30647)
-- Name: books fk_book_publisher; Type: FK CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.books
    ADD CONSTRAINT fk_book_publisher FOREIGN KEY (publisher_id) REFERENCES library.publishers(id);


--
-- TOC entry 4908 (class 2606 OID 30663)
-- Name: copies fk_copy_book; Type: FK CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.copies
    ADD CONSTRAINT fk_copy_book FOREIGN KEY (book_id) REFERENCES library.books(id);


--
-- TOC entry 4909 (class 2606 OID 30756)
-- Name: copies fk_copy_status; Type: FK CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.copies
    ADD CONSTRAINT fk_copy_status FOREIGN KEY (status_id) REFERENCES library.copy_statuses(id);


--
-- TOC entry 4910 (class 2606 OID 30679)
-- Name: loans fk_loan_copy; Type: FK CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.loans
    ADD CONSTRAINT fk_loan_copy FOREIGN KEY (copy_id) REFERENCES library.copies(id);


--
-- TOC entry 4911 (class 2606 OID 30761)
-- Name: loans fk_loan_status; Type: FK CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.loans
    ADD CONSTRAINT fk_loan_status FOREIGN KEY (status_id) REFERENCES library.loan_statuses(id);


--
-- TOC entry 4912 (class 2606 OID 30684)
-- Name: loans fk_loan_user; Type: FK CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.loans
    ADD CONSTRAINT fk_loan_user FOREIGN KEY (user_id) REFERENCES library.users(id);


--
-- TOC entry 4913 (class 2606 OID 30699)
-- Name: reservations fk_res_copy; Type: FK CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.reservations
    ADD CONSTRAINT fk_res_copy FOREIGN KEY (copy_id) REFERENCES library.copies(id);


--
-- TOC entry 4914 (class 2606 OID 30704)
-- Name: reservations fk_res_user; Type: FK CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.reservations
    ADD CONSTRAINT fk_res_user FOREIGN KEY (user_id) REFERENCES library.users(id);


--
-- TOC entry 4915 (class 2606 OID 30766)
-- Name: reservations fk_reservation_status; Type: FK CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.reservations
    ADD CONSTRAINT fk_reservation_status FOREIGN KEY (status_id) REFERENCES library.reservation_statuses(id);


--
-- TOC entry 4904 (class 2606 OID 30588)
-- Name: users fk_users_role; Type: FK CONSTRAINT; Schema: library; Owner: -
--

ALTER TABLE ONLY library.users
    ADD CONSTRAINT fk_users_role FOREIGN KEY (role_id) REFERENCES library.roles(id);


-- Completed on 2026-07-01 21:47:07

--
-- PostgreSQL database dump complete
--

\unrestrict Pgg5kED8wvkNNZuvOrqEwoH5zqA7QlQyX5zvUs9vOquNXJ0cFs1yzHdZOQSAjDv

