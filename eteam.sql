--
-- PostgreSQL database dump
--

-- Dumped from database version 17.1
-- Dumped by pg_dump version 17.1

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
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE public.alembic_version OWNER TO postgres;

--
-- Name: comment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comment (
    comment_id integer NOT NULL,
    content text,
    "timestamp" timestamp without time zone,
    user_id integer,
    post_id integer
);


ALTER TABLE public.comment OWNER TO postgres;

--
-- Name: comment_comment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.comment_comment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.comment_comment_id_seq OWNER TO postgres;

--
-- Name: comment_comment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.comment_comment_id_seq OWNED BY public.comment.comment_id;


--
-- Name: follow; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.follow (
    id integer NOT NULL,
    user_id integer NOT NULL,
    follow_user_id integer NOT NULL,
    follow_date timestamp without time zone NOT NULL
);


ALTER TABLE public.follow OWNER TO postgres;

--
-- Name: follow_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.follow_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.follow_id_seq OWNER TO postgres;

--
-- Name: follow_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.follow_id_seq OWNED BY public.follow.id;


--
-- Name: images; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.images (
    post_image_id integer NOT NULL,
    post_image_path character varying(512),
    post_id integer NOT NULL
);


ALTER TABLE public.images OWNER TO postgres;

--
-- Name: images_post_image_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.images_post_image_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.images_post_image_id_seq OWNER TO postgres;

--
-- Name: images_post_image_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.images_post_image_id_seq OWNED BY public.images.post_image_id;


--
-- Name: post; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.post OWNER TO postgres;

--
-- Name: post_post_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.post_post_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.post_post_id_seq OWNER TO postgres;

--
-- Name: post_post_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.post_post_id_seq OWNED BY public.post.post_id;


--
-- Name: user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."user" (
    id integer NOT NULL,
    username character varying,
    email character varying,
    password_hash character varying,
    icon_path character varying
);


ALTER TABLE public."user" OWNER TO postgres;

--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_id_seq OWNER TO postgres;

--
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_id_seq OWNED BY public."user".id;


--
-- Name: comment comment_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment ALTER COLUMN comment_id SET DEFAULT nextval('public.comment_comment_id_seq'::regclass);


--
-- Name: follow id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.follow ALTER COLUMN id SET DEFAULT nextval('public.follow_id_seq'::regclass);


--
-- Name: images post_image_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.images ALTER COLUMN post_image_id SET DEFAULT nextval('public.images_post_image_id_seq'::regclass);


--
-- Name: post post_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post ALTER COLUMN post_id SET DEFAULT nextval('public.post_post_id_seq'::regclass);


--
-- Name: user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);


--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.alembic_version (version_num) FROM stdin;
ea1dfbecd7b9
\.


--
-- Data for Name: comment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.comment (comment_id, content, "timestamp", user_id, post_id) FROM stdin;
\.


--
-- Data for Name: follow; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.follow (id, user_id, follow_user_id, follow_date) FROM stdin;
4	2	1	2024-11-20 14:06:19.742194
9	1	2	2024-11-26 16:44:55.674606
10	6	1	2024-11-27 10:58:00.330199
11	1	6	2024-11-27 11:28:52.172882
12	3	1	2024-12-02 10:22:40.548656
13	7	3	2024-12-02 14:41:16.576695
\.


--
-- Data for Name: images; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.images (post_image_id, post_image_path, post_id) FROM stdin;
6	29b7b013-687d-43ed-beff-2f62dbeadcc5.jpg	6
8	908e9e74-e7e4-4e26-832c-ccb3bbb75228.jpg	8
9	f5bc829e-f580-4cdc-8289-99b01052e5ee.jpg	9
10	af354366-4ce0-4e8f-b646-7ffdaf076b44.jpg	10
11	d08451b7-d02b-4a57-a4f1-2a5647a8b38f.jpg	11
12	7bf36461-c994-4859-868f-68440fe34d27.jpg	12
\.


--
-- Data for Name: post; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.post (post_id, title, content, "timestamp", user_id, prefecture_id, city_code) FROM stdin;
6	譚ｱ蟆句搖	譚ｱ蟆句搖縺ｫ陦後″縺ｾ縺励◆	2024-11-29 15:35:15.457835	1	18	0180009
8	蜈ｼ蜈ｭ蝨・蜉雉豁ｴ莉｣阯ｩ荳ｻ縺ｫ繧医ｊ髟ｷ縺・ｹｴ譛医ｒ縺九￠縺ｦ蠖｢菴懊ｉ繧後◆縲∵ｱ滓虻譎ゆｻ｣縺ｮ莉｣陦ｨ逧・↑蝗樣♀蠑丞ｺｭ蝨偵・2024-12-02 10:15:46.368087	5	17	0170001
9	螟ｧ髦ｪ蝓主・蝨・螟ｧ髦ｪ蝓主・蝨偵・縲∝､ｧ髦ｪ蟶ゆｸｭ螟ｮ蛹ｺ縺ｫ縺ゅｋ蠎・､ｧ縺ｪ驛ｽ蟶ょ・蝨偵〒縲∵ｭｴ蜿ｲ縺ｨ閾ｪ辟ｶ縺瑚ｪｿ蜥後＠縺滉ｺｺ豌励・隕ｳ蜈峨せ繝昴ャ繝医〒縺吶ょ恍蜀・↓縺ｯ縲∵律譛ｬ繧剃ｻ｣陦ｨ縺吶ｋ蜷榊沁縲悟､ｧ髦ｪ蝓弱阪′縺昴・縺育ｫ九■縲√◎縺ｮ髮・､ｧ縺ｪ蟋ｿ縺ｯ蝨ｧ蟾ｻ縲・2024-12-02 10:21:48.58124	3	27	0270024
10	譚ｱ莠ｬ繧ｹ繧ｫ繧､繝・Μ繝ｼ	2012蟷ｴ縺ｫ螳梧・縺励◆譚ｱ莠ｬ繧ｹ繧ｫ繧､繝・Μ繝ｼ縺ｯ縲√◎縺ｮ鬮倥＆縺・34m縺ｨ荳也阜荳鬮倥＞繧ｿ繝ｯ繝ｼ窶ｻ縺ｨ縺励※繧ｮ繝阪せ荳也阜險倬鹸縺ｮ隱榊ｮ壹ｒ蜿励￠縺ｦ縺・∪縺吶・2024-12-03 12:33:41.540375	2	13	0130007
11	譛ｭ蟷悟ｸよ凾險亥床	譛ｭ蟷後ｒ雎｡蠕ｴ縺吶ｋ隕ｳ蜈峨せ繝昴ャ繝医′譛ｭ蟷悟ｸよ凾險亥床縺ｧ縺吶よ惠騾2髫主ｻｺ縺ｦ縺ｮ豢矩｢ｨ蟒ｺ遽峨〒縺ゅｊ縲∫區縺・｣・擇縺ｨ襍､縺・ｱ区ｹ縺悟魂雎｡逧・↑豁ｴ蜿ｲ逧・ｻｺ騾迚ｩ縺ｧ縺吶・2024-12-03 12:34:59.812438	2	1	0010001
12	莨剰ｦ狗ｨｲ闕ｷ螟ｧ遉ｾ	蜈ｨ蝗ｽ縺ｫ邏・荳・､ｾ縺ゅｋ縺ｨ縺・ｏ繧後※縺・ｋ遞ｲ闕ｷ逾樒､ｾ縺ｮ邱乗悽螳ｮ縺御ｼ剰ｦ狗ｨｲ闕ｷ螟ｧ遉ｾ縺ｧ縺吶・2024-12-03 12:37:20.633287	4	26	0260009
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."user" (id, username, email, password_hash, icon_path) FROM stdin;
2	test1	test1@test1.com	scrypt:32768:8:1$6f3hoDHialfRHElI$7d0c9eddbd6390cd6e62545aa595de077da361e97f853af6b3c86f273823499db659aea7d5675861863e443efa2b5ec26c23a20783494f4ce27dd2850f9a4e9a	user_2.jpg
4	test3	test3@test3.com	scrypt:32768:8:1$ZlbGOUp2VPTyDUyS$ef63da714782344bfd056ec2da97e32e42bc6c4fba11566b4b551e6550bbf400757a1df01c69845ebfafc51583e2e19fed21309f3dbc0be9a845123e2e454a63	default_icon.png
6	test5	test5@test5.com	scrypt:32768:8:1$0IRPibsx5Ss3gwTQ$40a616db71dc1f2429d0b7c0cf42379cd94adf513814089cc0ba0ee3962bf5bec8962496ca5da05ef7d7be155840fc8ccbe12f3b4e39e9f6ce9e4b61926f7a16	default_icon.png
5	test4	test4@test4.com	scrypt:32768:8:1$R8GSUT0SeRs72ZRX$253459bf898152d2dd9c6575154c0d8b45c9f0a1326bfa27db2f3a7695451f9d2dd24d1af364f45627a58995fe51062d368981feb197bf67d74ce6f51f737b17	user_5.png
3	test2	test2@test2.com	scrypt:32768:8:1$GVIBuRSeKobmbfed$e037d0fa856a6164c1d855757320a378cd15902d95aeb556af1b07297c536923f0aa64f1295b9a168c7e1d12029197cdc6800f6bf8135a1188ee00f00509baa5	user_3.jpg
1	admin	admin@admin.com	scrypt:32768:8:1$LvA1lBOrSrHdjVrG$88939efd0f6e0b300a19f0da2525d3cbf2c1b4fd18eaf8834fbe962750b75461a4b0ff55f0f0eaf64ec1f737a3c82324eb4de9e2f0c095308d2b16662f420ea4	user_1.jpg
7	螟ｧ蜴溷､ｪ驛・ohara@ohara.com	scrypt:32768:8:1$HOxtrI5gWdrU6FBA$05c048bd6628602a1f7f42367029fbc17f0e5e7cd12453f2379f705a12945ef84b99f79e8cd0b9d139754eff2ebecad576c1a2fcddd4c6114cd708abfceba6b0	default_icon.png
\.


--
-- Name: comment_comment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.comment_comment_id_seq', 2, true);


--
-- Name: follow_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.follow_id_seq', 13, true);


--
-- Name: images_post_image_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.images_post_image_id_seq', 12, true);


--
-- Name: post_post_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.post_post_id_seq', 12, true);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_id_seq', 7, true);


--
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- Name: comment comment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_pkey PRIMARY KEY (comment_id);


--
-- Name: follow follow_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.follow
    ADD CONSTRAINT follow_pkey PRIMARY KEY (id);


--
-- Name: images images_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.images
    ADD CONSTRAINT images_pkey PRIMARY KEY (post_image_id);


--
-- Name: post post_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post
    ADD CONSTRAINT post_pkey PRIMARY KEY (post_id);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: ix_user_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_user_email ON public."user" USING btree (email);


--
-- Name: ix_user_username; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_user_username ON public."user" USING btree (username);


--
-- Name: comment comment_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.post(post_id);


--
-- Name: comment comment_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- Name: follow follow_follow_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.follow
    ADD CONSTRAINT follow_follow_user_id_fkey FOREIGN KEY (follow_user_id) REFERENCES public."user"(id);


--
-- Name: follow follow_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.follow
    ADD CONSTRAINT follow_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- Name: images images_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.images
    ADD CONSTRAINT images_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.post(post_id);


--
-- Name: post post_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post
    ADD CONSTRAINT post_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- PostgreSQL database dump complete
--

