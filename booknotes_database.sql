--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.24
-- Dumped by pg_dump version 9.6.24

-- Started on 2024-04-27 17:41:12

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE booknotes;
--
-- TOC entry 2169 (class 1262 OID 16530)
-- Name: booknotes; Type: DATABASE; Schema: -; Owner: webdev1
--

CREATE DATABASE booknotes WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'English_United States.1252' LC_CTYPE = 'English_United States.1252';


ALTER DATABASE booknotes OWNER TO webdev1;

\connect booknotes

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 1 (class 3079 OID 12387)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2172 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 192 (class 1259 OID 16861)
-- Name: authors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authors (
    author_id integer NOT NULL,
    author_name text,
    date_added timestamp without time zone DEFAULT now()
);


ALTER TABLE public.authors OWNER TO postgres;

--
-- TOC entry 191 (class 1259 OID 16859)
-- Name: authors_author_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.authors_author_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.authors_author_id_seq OWNER TO postgres;

--
-- TOC entry 2173 (class 0 OID 0)
-- Dependencies: 191
-- Name: authors_author_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.authors_author_id_seq OWNED BY public.authors.author_id;


--
-- TOC entry 190 (class 1259 OID 16849)
-- Name: books; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.books (
    book_id integer NOT NULL,
    book_title text,
    book_subtitle text,
    book_edition text,
    author_id integer,
    publisher_id integer,
    category_id integer,
    publication_year text,
    book_isbn numeric,
    book_cover_image text,
    date_read text,
    book_notes text,
    date_added timestamp without time zone DEFAULT now()
);


ALTER TABLE public.books OWNER TO postgres;

--
-- TOC entry 189 (class 1259 OID 16847)
-- Name: books_book_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.books_book_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.books_book_id_seq OWNER TO postgres;

--
-- TOC entry 2174 (class 0 OID 0)
-- Dependencies: 189
-- Name: books_book_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.books_book_id_seq OWNED BY public.books.book_id;


--
-- TOC entry 188 (class 1259 OID 16837)
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    category_id integer NOT NULL,
    category_name text,
    date_added timestamp without time zone DEFAULT now()
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- TOC entry 187 (class 1259 OID 16835)
-- Name: categories_category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categories_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categories_category_id_seq OWNER TO postgres;

--
-- TOC entry 2175 (class 0 OID 0)
-- Dependencies: 187
-- Name: categories_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_category_id_seq OWNED BY public.categories.category_id;


--
-- TOC entry 186 (class 1259 OID 16825)
-- Name: publishers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.publishers (
    publisher_id integer NOT NULL,
    publisher_name text,
    date_added timestamp without time zone DEFAULT now()
);


ALTER TABLE public.publishers OWNER TO postgres;

--
-- TOC entry 185 (class 1259 OID 16823)
-- Name: publishers_publisher_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.publishers_publisher_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.publishers_publisher_id_seq OWNER TO postgres;

--
-- TOC entry 2176 (class 0 OID 0)
-- Dependencies: 185
-- Name: publishers_publisher_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.publishers_publisher_id_seq OWNED BY public.publishers.publisher_id;


--
-- TOC entry 2029 (class 2604 OID 16864)
-- Name: authors author_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authors ALTER COLUMN author_id SET DEFAULT nextval('public.authors_author_id_seq'::regclass);


--
-- TOC entry 2027 (class 2604 OID 16852)
-- Name: books book_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books ALTER COLUMN book_id SET DEFAULT nextval('public.books_book_id_seq'::regclass);


--
-- TOC entry 2025 (class 2604 OID 16840)
-- Name: categories category_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN category_id SET DEFAULT nextval('public.categories_category_id_seq'::regclass);


--
-- TOC entry 2023 (class 2604 OID 16828)
-- Name: publishers publisher_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publishers ALTER COLUMN publisher_id SET DEFAULT nextval('public.publishers_publisher_id_seq'::regclass);


--
-- TOC entry 2163 (class 0 OID 16861)
-- Dependencies: 192
-- Data for Name: authors; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.authors (author_id, author_name, date_added) VALUES (1, 'Thomas Cleary', '2024-04-25 13:23:09.503322');
INSERT INTO public.authors (author_id, author_name, date_added) VALUES (2, 'Jean Shinoda Bolen', '2024-04-25 13:23:09.503322');
INSERT INTO public.authors (author_id, author_name, date_added) VALUES (3, 'Vance Packard', '2024-04-25 13:23:09.503322');
INSERT INTO public.authors (author_id, author_name, date_added) VALUES (4, 'José Silva and Philip Miele', '2024-04-25 13:23:09.503322');
INSERT INTO public.authors (author_id, author_name, date_added) VALUES (5, 'Niccolo Machiavelli', '2024-04-25 13:23:09.503322');
INSERT INTO public.authors (author_id, author_name, date_added) VALUES (6, 'Emile Coué & C.H. Brooks', '2024-04-25 13:23:09.503322');
INSERT INTO public.authors (author_id, author_name, date_added) VALUES (7, 'Anatole France', '2024-04-25 13:23:09.503322');
INSERT INTO public.authors (author_id, author_name, date_added) VALUES (8, 'Napoleon Hill', '2024-04-25 13:23:09.503322');
INSERT INTO public.authors (author_id, author_name, date_added) VALUES (9, 'Dale Carnegie', '2024-04-25 13:23:09.503322');
INSERT INTO public.authors (author_id, author_name, date_added) VALUES (10, 'William Irwin Thompson', '2024-04-25 13:23:09.503322');
INSERT INTO public.authors (author_id, author_name, date_added) VALUES (11, 'Masaru Emoto', '2024-04-25 13:23:09.503322');
INSERT INTO public.authors (author_id, author_name, date_added) VALUES (12, 'George S. Clason', '2024-04-25 13:23:09.503322');
INSERT INTO public.authors (author_id, author_name, date_added) VALUES (13, 'Clyde W. Ford', '2024-04-25 13:23:09.503322');
INSERT INTO public.authors (author_id, author_name, date_added) VALUES (14, 'John Kehoe', '2024-04-25 13:23:09.503322');
INSERT INTO public.authors (author_id, author_name, date_added) VALUES (15, 'Paul Zane Pilzer', '2024-04-25 13:23:09.503322');
INSERT INTO public.authors (author_id, author_name, date_added) VALUES (16, 'Barbara Thiering', '2024-04-25 13:23:09.503322');
INSERT INTO public.authors (author_id, author_name, date_added) VALUES (17, 'Jeff A. Benner', '2024-04-25 13:23:09.503322');
INSERT INTO public.authors (author_id, author_name, date_added) VALUES (18, 'Master Lam Kam Chuen', '2024-04-25 13:23:09.503322');
INSERT INTO public.authors (author_id, author_name, date_added) VALUES (19, 'Daniel Reid', '2024-04-25 13:23:09.503322');
INSERT INTO public.authors (author_id, author_name, date_added) VALUES (20, 'Mark Cohen', '2024-04-25 13:23:09.503322');
INSERT INTO public.authors (author_id, author_name, date_added) VALUES (21, 'Esther and Jerry Hicks', '2024-04-25 13:23:09.503322');
INSERT INTO public.authors (author_id, author_name, date_added) VALUES (22, 'June Singer', '2024-04-25 13:23:09.503322');
INSERT INTO public.authors (author_id, author_name, date_added) VALUES (23, 'Stephen Hoeller', '2024-04-25 13:23:09.503322');
INSERT INTO public.authors (author_id, author_name, date_added) VALUES (24, 'Hans Jonas', '2024-04-25 13:23:09.503322');
INSERT INTO public.authors (author_id, author_name, date_added) VALUES (25, 'Kevin Yank', '2024-04-25 13:23:09.503322');
INSERT INTO public.authors (author_id, author_name, date_added) VALUES (26, 'Chogyam Trungpa', '2024-04-25 13:23:09.503322');
INSERT INTO public.authors (author_id, author_name, date_added) VALUES (27, 'Edwin A. Abbott', '2024-04-25 13:23:09.503322');
INSERT INTO public.authors (author_id, author_name, date_added) VALUES (28, 'Joyce Farrell', '2024-04-25 13:23:09.503322');
INSERT INTO public.authors (author_id, author_name, date_added) VALUES (29, 'Patrick McNeil', '2024-04-25 13:23:09.503322');
INSERT INTO public.authors (author_id, author_name, date_added) VALUES (30, 'Elaine Pagels', '2024-04-25 13:23:09.503322');


--
-- TOC entry 2177 (class 0 OID 0)
-- Dependencies: 191
-- Name: authors_author_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.authors_author_id_seq', 31, true);


--
-- TOC entry 2161 (class 0 OID 16849)
-- Dependencies: 190
-- Data for Name: books; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.books (book_id, book_title, book_subtitle, book_edition, author_id, publisher_id, category_id, publication_year, book_isbn, book_cover_image, date_read, book_notes, date_added) VALUES (1, 'Practical Taoism', '', '', 1, 13, 11, '1996', 1570622000, 'https://covers.openlibrary.org/b/isbn/9781570622007.jpg', '2022-06-01', 'Vel eligendi sint culpa. Et sed explicabo omnis deleniti. Laboriosam minima consequatur tenetur quia aut voluptates.
Est quaerat enim eos commodi vero. Velit adipisci temporibus atque ut quo nostrum. Consequatur culpa omnis dolor minima deleniti.', '2024-04-25 13:30:54.693559');
INSERT INTO public.books (book_id, book_title, book_subtitle, book_edition, author_id, publisher_id, category_id, publication_year, book_isbn, book_cover_image, date_read, book_notes, date_added) VALUES (9, 'The Inner Teachings of Taoism', '', '', 1, 13, 11, '1986', 9781570627101, 'https://covers.openlibrary.org/b/isbn/9781570627101.jpg', '2023-04-26', 'Vel eligendi sint culpa. Et sed explicabo omnis deleniti. Laboriosam minima consequatur tenetur quia aut voluptates.
Est quaerat enim eos commodi vero. Velit adipisci temporibus atque ut quo nostrum. Consequatur culpa omnis dolor minima deleniti.
Aperiam autem consectetur iusto sunt. Minus et molestiae ducimus sunt. Laudantium sint debitis est. Itaque rerum dolor veritatis dolores repellendus eos ratione eveniet. Ut in ratione quas distinctio neque aperiam impedit.', '2024-04-25 13:30:54.693559');
INSERT INTO public.books (book_id, book_title, book_subtitle, book_edition, author_id, publisher_id, category_id, publication_year, book_isbn, book_cover_image, date_read, book_notes, date_added) VALUES (10, 'The Gnostic Paul', 'Gnostic Exegesis of the Pauline Letters', '', 30, 10, 5, '1992', 9781563380396, 'https://covers.openlibrary.org/b/isbn/9781563380396.jpg', '2023-10-12', 'Vel eligendi sint culpa. Et sed explicabo omnis deleniti. Laboriosam minima consequatur tenetur quia aut voluptates.
Est quaerat enim eos commodi vero. Velit adipisci temporibus atque ut quo nostrum. Consequatur culpa omnis dolor minima deleniti.
Aperiam autem consectetur iusto sunt. Minus et molestiae ducimus sunt. Laudantium sint debitis est. Itaque rerum dolor veritatis dolores repellendus eos ratione eveniet. Ut in ratione quas distinctio neque aperiam impedit.', '2024-04-25 13:30:54.693559');
INSERT INTO public.books (book_id, book_title, book_subtitle, book_edition, author_id, publisher_id, category_id, publication_year, book_isbn, book_cover_image, date_read, book_notes, date_added) VALUES (11, 'The Silva Mind Control Method', '', '', 4, 16, 2, '1978', 671452843, 'https://covers.openlibrary.org/b/isbn/0671452843.jpg', '2024-04-03', 'Vel eligendi sint culpa. Et sed explicabo omnis deleniti. Laboriosam minima consequatur tenetur quia aut voluptates.
Est quaerat enim eos commodi vero. Velit adipisci temporibus atque ut quo nostrum. Consequatur culpa omnis dolor minima deleniti.
Aperiam autem consectetur iusto sunt. Minus et molestiae ducimus sunt. Laudantium sint debitis est. Itaque rerum dolor veritatis dolores repellendus eos ratione eveniet. Ut in ratione quas distinctio neque aperiam impedit.', '2024-04-25 13:30:54.693559');
INSERT INTO public.books (book_id, book_title, book_subtitle, book_edition, author_id, publisher_id, category_id, publication_year, book_isbn, book_cover_image, date_read, book_notes, date_added) VALUES (15, 'Think and Grow Rich', '', '', 8, 20, 2, '1983', 449214923, 'https://covers.openlibrary.org/b/isbn/0449214923.jpg', '2023-09-21', 'Vel eligendi sint culpa. Et sed explicabo omnis deleniti. Laboriosam minima consequatur tenetur quia aut voluptates.
Est quaerat enim eos commodi vero. Velit adipisci temporibus atque ut quo nostrum. Consequatur culpa omnis dolor minima deleniti.
Aperiam autem consectetur iusto sunt. Minus et molestiae ducimus sunt. Laudantium sint debitis est. Itaque rerum dolor veritatis dolores repellendus eos ratione eveniet. Ut in ratione quas distinctio neque aperiam impedit.', '2024-04-25 13:30:54.693559');
INSERT INTO public.books (book_id, book_title, book_subtitle, book_edition, author_id, publisher_id, category_id, publication_year, book_isbn, book_cover_image, date_read, book_notes, date_added) VALUES (2, 'Gods in Everyman', 'A New Psychology of Mens Lives and Loves', '', 2, 13, 2, '1990', 62500988, 'https://covers.openlibrary.org/b/isbn/0062500988.jpg', '2023-11-01', 'Vel eligendi sint culpa. Et sed explicabo omnis deleniti. Laboriosam minima consequatur tenetur quia aut voluptates.
Est quaerat enim eos commodi vero. Velit adipisci temporibus atque ut quo nostrum. Consequatur culpa omnis dolor minima deleniti.
', '2024-04-25 13:30:54.693559');
INSERT INTO public.books (book_id, book_title, book_subtitle, book_edition, author_id, publisher_id, category_id, publication_year, book_isbn, book_cover_image, date_read, book_notes, date_added) VALUES (3, 'Build Your Own Database Driven Web Site Using PHP & MySQL', 'Learning PHP & MySQL Has Never Been So Easy!', '4', 25, 15, 1, '2009', 9780980576818, 'https://covers.openlibrary.org/b/isbn/9780980576818.jpg', '2016-12-08', 'Vel eligendi sint culpa. Et sed explicabo omnis deleniti. Laboriosam minima consequatur tenetur quia aut voluptates.
Est quaerat enim eos commodi vero. Velit adipisci temporibus atque ut quo nostrum. Consequatur culpa omnis dolor minima deleniti.
', '2024-04-25 13:30:54.693559');
INSERT INTO public.books (book_id, book_title, book_subtitle, book_edition, author_id, publisher_id, category_id, publication_year, book_isbn, book_cover_image, date_read, book_notes, date_added) VALUES (4, 'Goddesses in Everywoman', 'Powerful Archetypes in Womens Lives', '20th Anniversary', 2, 13, 2, '2004', 9780060572846, 'https://covers.openlibrary.org/b/isbn/9780060572846.jpg', '2024-01-17', 'Vel eligendi sint culpa. Et sed explicabo omnis deleniti. Laboriosam minima consequatur tenetur quia aut voluptates.
Est quaerat enim eos commodi vero. Velit adipisci temporibus atque ut quo nostrum. Consequatur culpa omnis dolor minima deleniti.Aperiam autem consectetur iusto sunt. Minus et molestiae ducimus sunt. Laudantium sint debitis est. Itaque rerum dolor veritatis dolores repellendus eos ratione eveniet. Ut in ratione quas distinctio neque aperiam impedit.
', '2024-04-25 13:30:54.693559');
INSERT INTO public.books (book_id, book_title, book_subtitle, book_edition, author_id, publisher_id, category_id, publication_year, book_isbn, book_cover_image, date_read, book_notes, date_added) VALUES (5, 'Shambhala', 'The Sacred Path of the Warrior', '', 25, 13, 3, '1984', 1590300416, 'https://covers.openlibrary.org/b/isbn/1590300416.jpg', '2023-01-12', 'This is one of those books that I inherited, if you could call it that, along with many others. The story goes that it was among a collection of books my late husband bought. Somehow, I couldn''t think of a reason to throw it away after his death. Vel eligendi sint culpa. Et sed explicabo omnis deleniti. Laboriosam minima consequatur tenetur quia aut voluptates.
Est quaerat enim eos commodi vero. Velit adipisci temporibus atque ut quo nostrum. Consequatur culpa omnis dolor minima deleniti.', '2024-04-25 13:30:54.693559');
INSERT INTO public.books (book_id, book_title, book_subtitle, book_edition, author_id, publisher_id, category_id, publication_year, book_isbn, book_cover_image, date_read, book_notes, date_added) VALUES (6, 'Flatland', 'A Romance of Many Dimensions', '', 27, 9, 12, '1984', 451522907, 'https://covers.openlibrary.org/b/isbn/0451522907.jpg', '1996-04-05', 'Vel eligendi sint culpa. Et sed explicabo omnis deleniti. Laboriosam minima consequatur tenetur quia aut voluptates.
Est quaerat enim eos commodi vero. Velit adipisci temporibus atque ut quo nostrum. Consequatur culpa omnis dolor minima deleniti.
Aperiam autem consectetur iusto sunt. Minus et molestiae ducimus sunt. Laudantium sint debitis est. Itaque rerum dolor veritatis dolores repellendus eos ratione eveniet. Ut in ratione quas distinctio neque aperiam impedit.', '2024-04-25 13:30:54.693559');
INSERT INTO public.books (book_id, book_title, book_subtitle, book_edition, author_id, publisher_id, category_id, publication_year, book_isbn, book_cover_image, date_read, book_notes, date_added) VALUES (8, 'The Web Designer&#39;s Handbook Volume 3', 'Inspiration from todays best web design trends, themes, and styles', '29', 1, 2, 1, '2013', 9781440323966, 'https://covers.openlibrary.org/b/isbn/9781440323966.jpg', '2023-09-05', 'Vel eligendi sint culpa. Et sed explicabo omnis deleniti. Laboriosam minima consequatur tenetur quia aut voluptates.
Est quaerat enim eos commodi vero. Velit adipisci temporibus atque ut quo nostrum. Consequatur culpa omnis dolor minima deleniti.
Aperiam autem consectetur iusto sunt. Minus et molestiae ducimus sunt. Laudantium sint debitis est. Itaque rerum dolor veritatis dolores repellendus eos ratione eveniet. Ut in ratione quas distinctio neque aperiam impedit.', '2024-04-25 13:30:54.693559');
INSERT INTO public.books (book_id, book_title, book_subtitle, book_edition, author_id, publisher_id, category_id, publication_year, book_isbn, book_cover_image, date_read, book_notes, date_added) VALUES (20, 'The Hero With An African Face', 'Mythic Wisdom of Traditional Africa', '', 13, 18, 3, '2000', 553378686, 'https://covers.openlibrary.org/b/isbn/0553378686.jpg', '2016-05-26', 'Vel eligendi sint culpa. Et sed explicabo omnis deleniti. Laboriosam minima consequatur tenetur quia aut voluptates.
Est quaerat enim eos commodi vero. Velit adipisci temporibus atque ut quo nostrum. Consequatur culpa omnis dolor minima deleniti.
Aperiam autem consectetur iusto sunt. Minus et molestiae ducimus sunt. Laudantium sint debitis est. Itaque rerum dolor veritatis dolores repellendus eos ratione eveniet. Ut in ratione quas distinctio neque aperiam impedit.', '2024-04-25 13:30:54.693559');
INSERT INTO public.books (book_id, book_title, book_subtitle, book_edition, author_id, publisher_id, category_id, publication_year, book_isbn, book_cover_image, date_read, book_notes, date_added) VALUES (14, 'The Hidden Messages in Water', '', '', 11, 19, 14, '2004', 1582701148, 'https://covers.openlibrary.org/b/isbn/1582701148.jpg', '2023-07-06', 'Vel eligendi sint culpa. Et sed explicabo omnis deleniti. Laboriosam minima consequatur tenetur quia aut voluptates.
Est quaerat enim eos commodi vero. Velit adipisci temporibus atque ut quo nostrum. Consequatur culpa omnis dolor minima deleniti.
Aperiam autem consectetur iusto sunt. Minus et molestiae ducimus sunt. Laudantium sint debitis est. Itaque rerum dolor veritatis dolores repellendus eos ratione eveniet. Ut in ratione quas distinctio neque aperiam impedit.', '2024-04-25 13:30:54.693559');
INSERT INTO public.books (book_id, book_title, book_subtitle, book_edition, author_id, publisher_id, category_id, publication_year, book_isbn, book_cover_image, date_read, book_notes, date_added) VALUES (12, 'The Hidden Persuaders', '', '', 3, 17, 12, '1981', 140205853, 'http://localhost:3000/images/default_image.jpg', '2022-04-15', 'NO COVER at the Open Library archive. 
Vel eligendi sint culpa. Et sed explicabo omnis deleniti. Laboriosam minima consequatur tenetur quia aut voluptates.
Est quaerat enim eos commodi vero. Velit adipisci temporibus atque ut quo nostrum. Consequatur culpa omnis dolor minima deleniti.
Aperiam autem consectetur iusto sunt. Minus et molestiae ducimus sunt. Laudantium sint debitis est. Itaque rerum dolor veritatis dolores repellendus eos ratione eveniet. Ut in ratione quas distinctio neque aperiam impedit.', '2024-04-25 13:30:54.693559');
INSERT INTO public.books (book_id, book_title, book_subtitle, book_edition, author_id, publisher_id, category_id, publication_year, book_isbn, book_cover_image, date_read, book_notes, date_added) VALUES (16, 'The Revolt of the Angels', '', '', 7, 21, 12, '2015', 9780486794976, 'https://covers.openlibrary.org/b/isbn/9780486794976.jpg', '2024-04-14', 'Vel eligendi sint culpa. Et sed explicabo omnis deleniti. Laboriosam minima consequatur tenetur quia aut voluptates.
Est quaerat enim eos commodi vero. Velit adipisci temporibus atque ut quo nostrum. Consequatur culpa omnis dolor minima deleniti.
Aperiam autem consectetur iusto sunt. Minus et molestiae ducimus sunt. Laudantium sint debitis est. Itaque rerum dolor veritatis dolores repellendus eos ratione eveniet. Ut in ratione quas distinctio neque aperiam impedit.', '2024-04-25 13:30:54.693559');
INSERT INTO public.books (book_id, book_title, book_subtitle, book_edition, author_id, publisher_id, category_id, publication_year, book_isbn, book_cover_image, date_read, book_notes, date_added) VALUES (17, 'Better and Better Every Day', 'Self Mastery Through Conscious Auto-Suggestion/The Practice of Auto-Suggestion by the Method of Emile Coué', '', 6, 22, 2, '1961', 123456789000, 'http://localhost:3000/images/default_image.jpg', '2023-06-10', 'No cover found for this image at the time of this submission. Vel eligendi sint culpa. Et sed explicabo omnis deleniti. Laboriosam minima consequatur tenetur quia aut voluptates.
Est quaerat enim eos commodi vero. Velit adipisci temporibus atque ut quo nostrum. Consequatur culpa omnis dolor minima deleniti.
Aperiam autem consectetur iusto sunt. Minus et molestiae ducimus sunt. Laudantium sint debitis est. Itaque rerum dolor veritatis dolores repellendus eos ratione eveniet. Ut in ratione quas distinctio neque aperiam impedit.', '2024-04-25 13:30:54.693559');
INSERT INTO public.books (book_id, book_title, book_subtitle, book_edition, author_id, publisher_id, category_id, publication_year, book_isbn, book_cover_image, date_read, book_notes, date_added) VALUES (18, 'How To Win Friends and Influence People', '', '', 9, 16, 2, '1982', 9780671723651, 'http://localhost:3000/images/default_image.jpg', '2024-02-23', 'No cover for this version of the book (1982). Vel eligendi sint culpa. Et sed explicabo omnis deleniti. Laboriosam minima consequatur tenetur quia aut voluptates.
Est quaerat enim eos commodi vero. Velit adipisci temporibus atque ut quo nostrum. Consequatur culpa omnis dolor minima deleniti.
Aperiam autem consectetur iusto sunt. Minus et molestiae ducimus sunt. Laudantium sint debitis est. Itaque rerum dolor veritatis dolores repellendus eos ratione eveniet. Ut in ratione quas distinctio neque aperiam impedit.', '2024-04-25 13:30:54.693559');
INSERT INTO public.books (book_id, book_title, book_subtitle, book_edition, author_id, publisher_id, category_id, publication_year, book_isbn, book_cover_image, date_read, book_notes, date_added) VALUES (19, 'The Time Falling Bodies Take To Light', 'Mythology, Sexuality and the Origins of Culture', '', 10, 23, 3, '1981', 312805128, 'http://localhost:3000/images/default_image.jpg', '2023-01-09', 'No cover found at the Open Library archive. Vel eligendi sint culpa. Et sed explicabo omnis deleniti. Laboriosam minima consequatur tenetur quia aut voluptates.
Est quaerat enim eos commodi vero. Velit adipisci temporibus atque ut quo nostrum. Consequatur culpa omnis dolor minima deleniti.
Aperiam autem consectetur iusto sunt. Minus et molestiae ducimus sunt. Laudantium sint debitis est. Itaque rerum dolor veritatis dolores repellendus eos ratione eveniet. Ut in ratione quas distinctio neque aperiam impedit.', '2024-04-25 13:30:54.693559');


--
-- TOC entry 2178 (class 0 OID 0)
-- Dependencies: 189
-- Name: books_book_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.books_book_id_seq', 1, true);


--
-- TOC entry 2159 (class 0 OID 16837)
-- Dependencies: 188
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.categories (category_id, category_name, date_added) VALUES (1, 'Computer Technology', '2024-04-25 13:22:26.768266');
INSERT INTO public.categories (category_id, category_name, date_added) VALUES (2, 'Self-Help/Psychology', '2024-04-25 13:22:26.768266');
INSERT INTO public.categories (category_id, category_name, date_added) VALUES (3, 'Philosophy', '2024-04-25 13:22:26.768266');
INSERT INTO public.categories (category_id, category_name, date_added) VALUES (4, 'Non-Fiction', '2024-04-25 13:22:26.768266');
INSERT INTO public.categories (category_id, category_name, date_added) VALUES (5, 'Religion', '2024-04-25 13:22:26.768266');
INSERT INTO public.categories (category_id, category_name, date_added) VALUES (6, 'Art', '2024-04-25 13:22:26.768266');
INSERT INTO public.categories (category_id, category_name, date_added) VALUES (7, 'History', '2024-04-25 13:22:26.768266');
INSERT INTO public.categories (category_id, category_name, date_added) VALUES (8, 'Economics', '2024-04-25 13:22:26.768266');
INSERT INTO public.categories (category_id, category_name, date_added) VALUES (9, 'English Literature', '2024-04-25 13:22:26.768266');
INSERT INTO public.categories (category_id, category_name, date_added) VALUES (10, 'American Literature', '2024-04-25 13:22:26.768266');
INSERT INTO public.categories (category_id, category_name, date_added) VALUES (11, 'Taoism', '2024-04-25 13:22:26.768266');
INSERT INTO public.categories (category_id, category_name, date_added) VALUES (12, 'Satire/Humor', '2024-04-25 13:22:26.768266');
INSERT INTO public.categories (category_id, category_name, date_added) VALUES (13, 'Sociology & Anthropology', '2024-04-25 13:22:26.768266');
INSERT INTO public.categories (category_id, category_name, date_added) VALUES (14, 'Science/Health', '2024-04-25 13:22:26.768266');
INSERT INTO public.categories (category_id, category_name, date_added) VALUES (15, 'Reference', '2024-04-25 13:22:26.768266');
INSERT INTO public.categories (category_id, category_name, date_added) VALUES (16, 'Test Category New', '2024-04-25 17:12:33.751211');


--
-- TOC entry 2179 (class 0 OID 0)
-- Dependencies: 187
-- Name: categories_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_category_id_seq', 16, true);


--
-- TOC entry 2157 (class 0 OID 16825)
-- Dependencies: 186
-- Data for Name: publishers; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.publishers (publisher_id, publisher_name, date_added) VALUES (1, 'Addison-Wesley', '2024-04-25 13:21:50.51943');
INSERT INTO public.publishers (publisher_id, publisher_name, date_added) VALUES (2, 'Thomson Course Technology', '2024-04-25 13:21:50.51943');
INSERT INTO public.publishers (publisher_id, publisher_name, date_added) VALUES (3, 'Apress', '2024-04-25 13:21:50.51943');
INSERT INTO public.publishers (publisher_id, publisher_name, date_added) VALUES (4, 'Packt Publishing', '2024-04-25 13:21:50.51943');
INSERT INTO public.publishers (publisher_id, publisher_name, date_added) VALUES (5, 'Farrar, Straus and Giroux', '2024-04-25 13:21:50.51943');
INSERT INTO public.publishers (publisher_id, publisher_name, date_added) VALUES (6, 'YMAA Publication Center', '2024-04-25 13:21:50.51943');
INSERT INTO public.publishers (publisher_id, publisher_name, date_added) VALUES (7, 'Chritsian Fellowship Publishers, Inc', '2024-04-25 13:21:50.51943');
INSERT INTO public.publishers (publisher_id, publisher_name, date_added) VALUES (8, 'Sams Publishing', '2024-04-25 13:21:50.51943');
INSERT INTO public.publishers (publisher_id, publisher_name, date_added) VALUES (9, 'Signet Classic', '2024-04-25 13:21:50.51943');
INSERT INTO public.publishers (publisher_id, publisher_name, date_added) VALUES (10, 'Trinity Press International', '2024-04-25 13:21:50.51943');
INSERT INTO public.publishers (publisher_id, publisher_name, date_added) VALUES (11, 'HOW Books', '2024-04-25 13:21:50.51943');
INSERT INTO public.publishers (publisher_id, publisher_name, date_added) VALUES (12, 'Michael Wiese Productions', '2024-04-25 13:21:50.51943');
INSERT INTO public.publishers (publisher_id, publisher_name, date_added) VALUES (13, 'Shamballa Publications, Inc', '2024-04-25 13:21:50.51943');
INSERT INTO public.publishers (publisher_id, publisher_name, date_added) VALUES (14, 'Harper & Row', '2024-04-25 13:21:50.51943');
INSERT INTO public.publishers (publisher_id, publisher_name, date_added) VALUES (15, 'sitepoint', '2024-04-25 13:21:50.51943');
INSERT INTO public.publishers (publisher_id, publisher_name, date_added) VALUES (16, 'Pocket Books', '2024-04-25 13:21:50.51943');
INSERT INTO public.publishers (publisher_id, publisher_name, date_added) VALUES (17, 'Penguin Books', '2024-04-25 13:21:50.51943');
INSERT INTO public.publishers (publisher_id, publisher_name, date_added) VALUES (18, 'Bantam Books', '2024-04-25 13:21:50.51943');
INSERT INTO public.publishers (publisher_id, publisher_name, date_added) VALUES (19, 'Beyond Words Publishing', '2024-04-25 13:21:50.51943');
INSERT INTO public.publishers (publisher_id, publisher_name, date_added) VALUES (20, 'Ballantine Books', '2024-04-25 13:21:50.51943');
INSERT INTO public.publishers (publisher_id, publisher_name, date_added) VALUES (21, 'Dover Publications, Inc', '2024-04-25 13:21:50.51943');
INSERT INTO public.publishers (publisher_id, publisher_name, date_added) VALUES (22, 'Unwin Books', '2024-04-25 13:21:50.51943');
INSERT INTO public.publishers (publisher_id, publisher_name, date_added) VALUES (23, 'St. Martins Press', '2024-04-25 13:21:50.51943');
INSERT INTO public.publishers (publisher_id, publisher_name, date_added) VALUES (24, 'Test Publisher New', '2024-04-25 17:10:33.125863');
INSERT INTO public.publishers (publisher_id, publisher_name, date_added) VALUES (25, 'Second Test Publisher New', '2024-04-25 17:35:46.577074');


--
-- TOC entry 2180 (class 0 OID 0)
-- Dependencies: 185
-- Name: publishers_publisher_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.publishers_publisher_id_seq', 25, true);


--
-- TOC entry 2038 (class 2606 OID 16870)
-- Name: authors PK_authors; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authors
    ADD CONSTRAINT "PK_authors" PRIMARY KEY (author_id);


--
-- TOC entry 2036 (class 2606 OID 16858)
-- Name: books PK_books; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books
    ADD CONSTRAINT "PK_books" PRIMARY KEY (book_id);


--
-- TOC entry 2034 (class 2606 OID 16846)
-- Name: categories PK_categories; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT "PK_categories" PRIMARY KEY (category_id);


--
-- TOC entry 2032 (class 2606 OID 16834)
-- Name: publishers PK_publishers; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publishers
    ADD CONSTRAINT "PK_publishers" PRIMARY KEY (publisher_id);


--
-- TOC entry 2171 (class 0 OID 0)
-- Dependencies: 6
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2024-04-27 17:41:13

--
-- PostgreSQL database dump complete
--

