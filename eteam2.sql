--
-- PostgreSQL database dump
--

-- Dumped from database version 17.1
-- Dumped by pg_dump version 17.1

-- Started on 2024-12-05 14:20:31

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 217 (class 1259 OID 16865)
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);


--
-- TOC entry 225 (class 1259 OID 16913)
-- Name: comment; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.comment (
    comment_id integer NOT NULL,
    content text,
    "timestamp" timestamp without time zone,
    user_id integer,
    post_id integer
);


--
-- TOC entry 224 (class 1259 OID 16912)
-- Name: comment_comment_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.comment_comment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4905 (class 0 OID 0)
-- Dependencies: 224
-- Name: comment_comment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.comment_comment_id_seq OWNED BY public.comment.comment_id;


--
-- TOC entry 221 (class 1259 OID 16882)
-- Name: follow; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.follow (
    id integer NOT NULL,
    user_id integer NOT NULL,
    follow_user_id integer NOT NULL,
    follow_date timestamp without time zone NOT NULL
);


--
-- TOC entry 220 (class 1259 OID 16881)
-- Name: follow_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.follow_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4906 (class 0 OID 0)
-- Dependencies: 220
-- Name: follow_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.follow_id_seq OWNED BY public.follow.id;


--
-- TOC entry 227 (class 1259 OID 16932)
-- Name: images; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.images (
    post_image_id integer NOT NULL,
    post_image_path character varying(512),
    post_id integer NOT NULL
);


--
-- TOC entry 226 (class 1259 OID 16931)
-- Name: images_post_image_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.images_post_image_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4907 (class 0 OID 0)
-- Dependencies: 226
-- Name: images_post_image_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.images_post_image_id_seq OWNED BY public.images.post_image_id;


--
-- TOC entry 223 (class 1259 OID 16899)
-- Name: post; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.post (
    post_id integer NOT NULL,
    title character varying,
    content character varying,
    "timestamp" timestamp without time zone,
    user_id integer NOT NULL,
    prefecture_id character varying(10),
    city_code character varying(10)
);


--
-- TOC entry 222 (class 1259 OID 16898)
-- Name: post_post_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.post_post_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4908 (class 0 OID 0)
-- Dependencies: 222
-- Name: post_post_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.post_post_id_seq OWNED BY public.post.post_id;


--
-- TOC entry 219 (class 1259 OID 16871)
-- Name: user; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."user" (
    id integer NOT NULL,
    username character varying,
    email character varying,
    password_hash character varying,
    icon_path character varying
);


--
-- TOC entry 218 (class 1259 OID 16870)
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4909 (class 0 OID 0)
-- Dependencies: 218
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_id_seq OWNED BY public."user".id;


--
-- TOC entry 4722 (class 2604 OID 16916)
-- Name: comment comment_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comment ALTER COLUMN comment_id SET DEFAULT nextval('public.comment_comment_id_seq'::regclass);


--
-- TOC entry 4720 (class 2604 OID 16885)
-- Name: follow id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.follow ALTER COLUMN id SET DEFAULT nextval('public.follow_id_seq'::regclass);


--
-- TOC entry 4723 (class 2604 OID 16935)
-- Name: images post_image_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.images ALTER COLUMN post_image_id SET DEFAULT nextval('public.images_post_image_id_seq'::regclass);


--
-- TOC entry 4721 (class 2604 OID 16902)
-- Name: post post_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.post ALTER COLUMN post_id SET DEFAULT nextval('public.post_post_id_seq'::regclass);


--
-- TOC entry 4719 (class 2604 OID 16874)
-- Name: user id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);


--
-- TOC entry 4889 (class 0 OID 16865)
-- Dependencies: 217
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.alembic_version VALUES ('ea1dfbecd7b9');


--
-- TOC entry 4897 (class 0 OID 16913)
-- Dependencies: 225
-- Data for Name: comment; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4893 (class 0 OID 16882)
-- Dependencies: 221
-- Data for Name: follow; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.follow VALUES (4, 2, 1, '2024-11-20 14:06:19.742194');
INSERT INTO public.follow VALUES (9, 1, 2, '2024-11-26 16:44:55.674606');
INSERT INTO public.follow VALUES (10, 6, 1, '2024-11-27 10:58:00.330199');
INSERT INTO public.follow VALUES (11, 1, 6, '2024-11-27 11:28:52.172882');
INSERT INTO public.follow VALUES (12, 3, 1, '2024-12-02 10:22:40.548656');
INSERT INTO public.follow VALUES (13, 7, 3, '2024-12-02 14:41:16.576695');


--
-- TOC entry 4899 (class 0 OID 16932)
-- Dependencies: 227
-- Data for Name: images; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.images VALUES (6, '29b7b013-687d-43ed-beff-2f62dbeadcc5.jpg', 6);
INSERT INTO public.images VALUES (9, 'f5bc829e-f580-4cdc-8289-99b01052e5ee.jpg', 9);
INSERT INTO public.images VALUES (10, 'af354366-4ce0-4e8f-b646-7ffdaf076b44.jpg', 10);
INSERT INTO public.images VALUES (11, 'd08451b7-d02b-4a57-a4f1-2a5647a8b38f.jpg', 11);
INSERT INTO public.images VALUES (12, '7bf36461-c994-4859-868f-68440fe34d27.jpg', 12);


--
-- TOC entry 4895 (class 0 OID 16899)
-- Dependencies: 223
-- Data for Name: post; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.post VALUES (6, '東尋坊', '東尋坊に行きました', '2024-11-29 15:35:15.457835', 1, '18', '0180009');
INSERT INTO public.post VALUES (9, '大阪城公園', '大阪城公園は、大阪市中央区にある広大な都市公園で、歴史と自然が調和した人気の観光スポットです。園内には、日本を代表する名城「大阪城」がそびえ立ち、その雄大な姿は圧巻。', '2024-12-02 10:21:48.58124', 3, '27', '0270024');
INSERT INTO public.post VALUES (10, '東京スカイツリー', '2012年に完成した東京スカイツリーは、その高さが634mと世界一高いタワー※としてギネス世界記録の認定を受けています。', '2024-12-03 12:33:41.540375', 2, '13', '0130007');
INSERT INTO public.post VALUES (11, '札幌市時計台', '札幌を象徴する観光スポットが札幌市時計台です。木造2階建ての洋風建築であり、白い壁面と赤い屋根が印象的な歴史的建造物です。', '2024-12-03 12:34:59.812438', 2, '1', '0010001');
INSERT INTO public.post VALUES (12, '伏見稲荷大社', '全国に約3万社あるといわれている稲荷神社の総本宮が伏見稲荷大社です。', '2024-12-03 12:37:20.633287', 4, '26', '0260009');


--
-- TOC entry 4891 (class 0 OID 16871)
-- Dependencies: 219
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public."user" VALUES (2, 'test1', 'test1@test1.com', 'scrypt:32768:8:1$6f3hoDHialfRHElI$7d0c9eddbd6390cd6e62545aa595de077da361e97f853af6b3c86f273823499db659aea7d5675861863e443efa2b5ec26c23a20783494f4ce27dd2850f9a4e9a', 'user_2.jpg');
INSERT INTO public."user" VALUES (4, 'test3', 'test3@test3.com', 'scrypt:32768:8:1$ZlbGOUp2VPTyDUyS$ef63da714782344bfd056ec2da97e32e42bc6c4fba11566b4b551e6550bbf400757a1df01c69845ebfafc51583e2e19fed21309f3dbc0be9a845123e2e454a63', 'default_icon.png');
INSERT INTO public."user" VALUES (6, 'test5', 'test5@test5.com', 'scrypt:32768:8:1$0IRPibsx5Ss3gwTQ$40a616db71dc1f2429d0b7c0cf42379cd94adf513814089cc0ba0ee3962bf5bec8962496ca5da05ef7d7be155840fc8ccbe12f3b4e39e9f6ce9e4b61926f7a16', 'default_icon.png');
INSERT INTO public."user" VALUES (5, 'test4', 'test4@test4.com', 'scrypt:32768:8:1$R8GSUT0SeRs72ZRX$253459bf898152d2dd9c6575154c0d8b45c9f0a1326bfa27db2f3a7695451f9d2dd24d1af364f45627a58995fe51062d368981feb197bf67d74ce6f51f737b17', 'user_5.png');
INSERT INTO public."user" VALUES (3, 'test2', 'test2@test2.com', 'scrypt:32768:8:1$GVIBuRSeKobmbfed$e037d0fa856a6164c1d855757320a378cd15902d95aeb556af1b07297c536923f0aa64f1295b9a168c7e1d12029197cdc6800f6bf8135a1188ee00f00509baa5', 'user_3.jpg');
INSERT INTO public."user" VALUES (1, 'admin', 'admin@admin.com', 'scrypt:32768:8:1$LvA1lBOrSrHdjVrG$88939efd0f6e0b300a19f0da2525d3cbf2c1b4fd18eaf8834fbe962750b75461a4b0ff55f0f0eaf64ec1f737a3c82324eb4de9e2f0c095308d2b16662f420ea4', 'user_1.jpg');
INSERT INTO public."user" VALUES (7, '大原太郎', 'ohara@ohara.com', 'scrypt:32768:8:1$HOxtrI5gWdrU6FBA$05c048bd6628602a1f7f42367029fbc17f0e5e7cd12453f2379f705a12945ef84b99f79e8cd0b9d139754eff2ebecad576c1a2fcddd4c6114cd708abfceba6b0', 'default_icon.png');


--
-- TOC entry 4910 (class 0 OID 0)
-- Dependencies: 224
-- Name: comment_comment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.comment_comment_id_seq', 3, true);


--
-- TOC entry 4911 (class 0 OID 0)
-- Dependencies: 220
-- Name: follow_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.follow_id_seq', 13, true);


--
-- TOC entry 4912 (class 0 OID 0)
-- Dependencies: 226
-- Name: images_post_image_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.images_post_image_id_seq', 12, true);


--
-- TOC entry 4913 (class 0 OID 0)
-- Dependencies: 222
-- Name: post_post_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.post_post_id_seq', 12, true);


--
-- TOC entry 4914 (class 0 OID 0)
-- Dependencies: 218
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.user_id_seq', 7, true);


--
-- TOC entry 4725 (class 2606 OID 16869)
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- TOC entry 4735 (class 2606 OID 16920)
-- Name: comment comment_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_pkey PRIMARY KEY (comment_id);


--
-- TOC entry 4731 (class 2606 OID 16887)
-- Name: follow follow_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.follow
    ADD CONSTRAINT follow_pkey PRIMARY KEY (id);


--
-- TOC entry 4737 (class 2606 OID 16939)
-- Name: images images_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.images
    ADD CONSTRAINT images_pkey PRIMARY KEY (post_image_id);


--
-- TOC entry 4733 (class 2606 OID 16906)
-- Name: post post_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.post
    ADD CONSTRAINT post_pkey PRIMARY KEY (post_id);


--
-- TOC entry 4729 (class 2606 OID 16878)
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- TOC entry 4726 (class 1259 OID 16879)
-- Name: ix_user_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX ix_user_email ON public."user" USING btree (email);


--
-- TOC entry 4727 (class 1259 OID 16880)
-- Name: ix_user_username; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_user_username ON public."user" USING btree (username);


--
-- TOC entry 4741 (class 2606 OID 16921)
-- Name: comment comment_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.post(post_id);


--
-- TOC entry 4742 (class 2606 OID 16926)
-- Name: comment comment_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- TOC entry 4738 (class 2606 OID 16888)
-- Name: follow follow_follow_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.follow
    ADD CONSTRAINT follow_follow_user_id_fkey FOREIGN KEY (follow_user_id) REFERENCES public."user"(id);


--
-- TOC entry 4739 (class 2606 OID 16893)
-- Name: follow follow_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.follow
    ADD CONSTRAINT follow_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- TOC entry 4743 (class 2606 OID 16940)
-- Name: images images_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.images
    ADD CONSTRAINT images_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.post(post_id);


--
-- TOC entry 4740 (class 2606 OID 16907)
-- Name: post post_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.post
    ADD CONSTRAINT post_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


-- Completed on 2024-12-05 14:20:31

--
-- PostgreSQL database dump complete
--

