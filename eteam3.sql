PGDMP  1    4                |         	   flask_sns    17.1    17.1 2    &           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            '           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            (           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            )           1262    16469 	   flask_sns    DATABASE     k   CREATE DATABASE flask_sns WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'C';
    DROP DATABASE flask_sns;
                     postgres    false            �            1259    16865    alembic_version    TABLE     X   CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);
 #   DROP TABLE public.alembic_version;
       public         heap r       postgres    false            �            1259    16913    comment    TABLE     �   CREATE TABLE public.comment (
    comment_id integer NOT NULL,
    content text,
    "timestamp" timestamp without time zone,
    user_id integer,
    post_id integer
);
    DROP TABLE public.comment;
       public         heap r       postgres    false            �            1259    16912    comment_comment_id_seq    SEQUENCE     �   CREATE SEQUENCE public.comment_comment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.comment_comment_id_seq;
       public               postgres    false    225            *           0    0    comment_comment_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.comment_comment_id_seq OWNED BY public.comment.comment_id;
          public               postgres    false    224            �            1259    16882    follow    TABLE     �   CREATE TABLE public.follow (
    id integer NOT NULL,
    user_id integer NOT NULL,
    follow_user_id integer NOT NULL,
    follow_date timestamp without time zone NOT NULL
);
    DROP TABLE public.follow;
       public         heap r       postgres    false            �            1259    16881    follow_id_seq    SEQUENCE     �   CREATE SEQUENCE public.follow_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.follow_id_seq;
       public               postgres    false    221            +           0    0    follow_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.follow_id_seq OWNED BY public.follow.id;
          public               postgres    false    220            �            1259    16932    images    TABLE     �   CREATE TABLE public.images (
    post_image_id integer NOT NULL,
    post_image_path character varying(512),
    post_id integer NOT NULL
);
    DROP TABLE public.images;
       public         heap r       postgres    false            �            1259    16931    images_post_image_id_seq    SEQUENCE     �   CREATE SEQUENCE public.images_post_image_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.images_post_image_id_seq;
       public               postgres    false    227            ,           0    0    images_post_image_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.images_post_image_id_seq OWNED BY public.images.post_image_id;
          public               postgres    false    226            �            1259    16899    post    TABLE       CREATE TABLE public.post (
    post_id integer NOT NULL,
    title character varying,
    content character varying,
    "timestamp" timestamp without time zone,
    user_id integer NOT NULL,
    prefecture_id character varying(10),
    city_code character varying(10)
);
    DROP TABLE public.post;
       public         heap r       postgres    false            �            1259    16898    post_post_id_seq    SEQUENCE     �   CREATE SEQUENCE public.post_post_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.post_post_id_seq;
       public               postgres    false    223            -           0    0    post_post_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.post_post_id_seq OWNED BY public.post.post_id;
          public               postgres    false    222            �            1259    16871    user    TABLE     �   CREATE TABLE public."user" (
    id integer NOT NULL,
    username character varying,
    email character varying,
    password_hash character varying,
    icon_path character varying
);
    DROP TABLE public."user";
       public         heap r       postgres    false            �            1259    16870    user_id_seq    SEQUENCE     �   CREATE SEQUENCE public.user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.user_id_seq;
       public               postgres    false    219            .           0    0    user_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.user_id_seq OWNED BY public."user".id;
          public               postgres    false    218            r           2604    16916    comment comment_id    DEFAULT     x   ALTER TABLE ONLY public.comment ALTER COLUMN comment_id SET DEFAULT nextval('public.comment_comment_id_seq'::regclass);
 A   ALTER TABLE public.comment ALTER COLUMN comment_id DROP DEFAULT;
       public               postgres    false    225    224    225            p           2604    16885 	   follow id    DEFAULT     f   ALTER TABLE ONLY public.follow ALTER COLUMN id SET DEFAULT nextval('public.follow_id_seq'::regclass);
 8   ALTER TABLE public.follow ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    220    221    221            s           2604    16935    images post_image_id    DEFAULT     |   ALTER TABLE ONLY public.images ALTER COLUMN post_image_id SET DEFAULT nextval('public.images_post_image_id_seq'::regclass);
 C   ALTER TABLE public.images ALTER COLUMN post_image_id DROP DEFAULT;
       public               postgres    false    227    226    227            q           2604    16902    post post_id    DEFAULT     l   ALTER TABLE ONLY public.post ALTER COLUMN post_id SET DEFAULT nextval('public.post_post_id_seq'::regclass);
 ;   ALTER TABLE public.post ALTER COLUMN post_id DROP DEFAULT;
       public               postgres    false    223    222    223            o           2604    16874    user id    DEFAULT     d   ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);
 8   ALTER TABLE public."user" ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    218    219    219                      0    16865    alembic_version 
   TABLE DATA           6   COPY public.alembic_version (version_num) FROM stdin;
    public               postgres    false    217   \8       !          0    16913    comment 
   TABLE DATA           U   COPY public.comment (comment_id, content, "timestamp", user_id, post_id) FROM stdin;
    public               postgres    false    225   �8                 0    16882    follow 
   TABLE DATA           J   COPY public.follow (id, user_id, follow_user_id, follow_date) FROM stdin;
    public               postgres    false    221   �8       #          0    16932    images 
   TABLE DATA           I   COPY public.images (post_image_id, post_image_path, post_id) FROM stdin;
    public               postgres    false    227   +9                 0    16899    post 
   TABLE DATA           g   COPY public.post (post_id, title, content, "timestamp", user_id, prefecture_id, city_code) FROM stdin;
    public               postgres    false    223   �9                 0    16871    user 
   TABLE DATA           O   COPY public."user" (id, username, email, password_hash, icon_path) FROM stdin;
    public               postgres    false    219   l<       /           0    0    comment_comment_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.comment_comment_id_seq', 3, true);
          public               postgres    false    224            0           0    0    follow_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.follow_id_seq', 13, true);
          public               postgres    false    220            1           0    0    images_post_image_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.images_post_image_id_seq', 12, true);
          public               postgres    false    226            2           0    0    post_post_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.post_post_id_seq', 12, true);
          public               postgres    false    222            3           0    0    user_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('public.user_id_seq', 7, true);
          public               postgres    false    218            u           2606    16869 #   alembic_version alembic_version_pkc 
   CONSTRAINT     j   ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);
 M   ALTER TABLE ONLY public.alembic_version DROP CONSTRAINT alembic_version_pkc;
       public                 postgres    false    217                       2606    16920    comment comment_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_pkey PRIMARY KEY (comment_id);
 >   ALTER TABLE ONLY public.comment DROP CONSTRAINT comment_pkey;
       public                 postgres    false    225            {           2606    16887    follow follow_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.follow
    ADD CONSTRAINT follow_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.follow DROP CONSTRAINT follow_pkey;
       public                 postgres    false    221            �           2606    16939    images images_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.images
    ADD CONSTRAINT images_pkey PRIMARY KEY (post_image_id);
 <   ALTER TABLE ONLY public.images DROP CONSTRAINT images_pkey;
       public                 postgres    false    227            }           2606    16906    post post_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.post
    ADD CONSTRAINT post_pkey PRIMARY KEY (post_id);
 8   ALTER TABLE ONLY public.post DROP CONSTRAINT post_pkey;
       public                 postgres    false    223            y           2606    16878    user user_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public."user" DROP CONSTRAINT user_pkey;
       public                 postgres    false    219            v           1259    16879    ix_user_email    INDEX     H   CREATE UNIQUE INDEX ix_user_email ON public."user" USING btree (email);
 !   DROP INDEX public.ix_user_email;
       public                 postgres    false    219            w           1259    16880    ix_user_username    INDEX     G   CREATE INDEX ix_user_username ON public."user" USING btree (username);
 $   DROP INDEX public.ix_user_username;
       public                 postgres    false    219            �           2606    16921    comment comment_post_id_fkey    FK CONSTRAINT        ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.post(post_id);
 F   ALTER TABLE ONLY public.comment DROP CONSTRAINT comment_post_id_fkey;
       public               postgres    false    223    4733    225            �           2606    16926    comment comment_user_id_fkey    FK CONSTRAINT     |   ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);
 F   ALTER TABLE ONLY public.comment DROP CONSTRAINT comment_user_id_fkey;
       public               postgres    false    225    219    4729            �           2606    16888 !   follow follow_follow_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.follow
    ADD CONSTRAINT follow_follow_user_id_fkey FOREIGN KEY (follow_user_id) REFERENCES public."user"(id);
 K   ALTER TABLE ONLY public.follow DROP CONSTRAINT follow_follow_user_id_fkey;
       public               postgres    false    221    4729    219            �           2606    16893    follow follow_user_id_fkey    FK CONSTRAINT     z   ALTER TABLE ONLY public.follow
    ADD CONSTRAINT follow_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);
 D   ALTER TABLE ONLY public.follow DROP CONSTRAINT follow_user_id_fkey;
       public               postgres    false    4729    219    221            �           2606    16940    images images_post_id_fkey    FK CONSTRAINT     }   ALTER TABLE ONLY public.images
    ADD CONSTRAINT images_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.post(post_id);
 D   ALTER TABLE ONLY public.images DROP CONSTRAINT images_post_id_fkey;
       public               postgres    false    227    223    4733            �           2606    16907    post post_user_id_fkey    FK CONSTRAINT     v   ALTER TABLE ONLY public.post
    ADD CONSTRAINT post_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);
 @   ALTER TABLE ONLY public.post DROP CONSTRAINT post_user_id_fkey;
       public               postgres    false    223    4729    219                  x�KM4LIKJMN1O������ 7��      !      x������ � �         x   x�Uͱ�0C�Z���G@$%q�?G�&qj���ƆF�w��.xY�N'��~��Y��9=-���b���a�[���@qUP1�l��`7>��4|e����1o��(����!����H$�      #   �   x�%�1nD1 �ھ+��]�VJ��W���f��Ǌ����y!�
��n������ݴ{+�c�	%6��=`d�Ob�d~�wm����G���ª����`�h��a,� ޲`s!��-�՗cGj+j>5����&��B�yTN�����ϫ��FQ;         �  x�uS�V�@��y
_@Nv�ȳ���*J�9VQ��()hD�ʇ�����-:I�=��ow�Ν;3w�,��उ���'���l�|��	U�뜯��7,Ͱ�Q����3^a*���ZU���`���X�����;�k��*8s���T�N.�����d)+��b���l���O�^2z�]��.фArq��Mp����u�md��CT�����dD��Q���py���CvZ�l�U9�4	��y��� ���G���V���bw�K����XW�W-�-�R2*\�Lc�d�0UB(\�&..3����5pG�>8��`���St��hj�j| r�d�5�3�,�}���pf�5p^����_��^s�pp[�[�� �n���ZҘ�M���2ot��S[���4K�%CW5�`�q����7L�su�p��Z����lOV!"On��<-v�z�_�u��>��6.�� �6�S����f�#sm�x����3��N3+���M3:�SlMHG|H�
�љH�=���Z�mϺeTK�j�J�3SUN-s�>���f��&��I<xfX��T��iMg+��o�v��[M�Y����sX?�ɳ��=��
MK�������t&�d�r�c?�E���P�         G  x�m�Mn7�ףs�Z�*���V��D@Ό�F �d�d�Ì�X��}�lȽ��-Rӽ�l
�=d���kZ<����x����n�훗ǧ�@I�Q>¥X�����������eR�e�6�P��!�\+�)i��$��I=�Q
�B,E�p��&eI���cV���$�B%H�WG�}PR��`��Q��y;6�����A��yNa?Ň�vzq�H��]���zY/�IК0����L���]kI#ЈԺ�h�"�H���0Ck��j�]J�<�U댜à�ņ(�uh.�!�~����:����Ǜ�p�x} �sb��,p�zwӶ_x��^���PE[B�h�(�ԡ[��J��c�!��*��P3n�g��Eze��Ò�6�9G��{��ТoŤ�2b,$�.��,3�|:qb��YV�t}u	��&���mI"�f�ddRR-]8����������-�h4WV�� Z�m��X-����R�\
�`!�{���%5'����c)��iNOs�h���8}~�Z���]�_^��ew4��fv�jH�+r��ux��6HTR� ��V׏T�w8�4P������%x�,c`Oh�c� �Ҽ�3E�:���w7��<��~���x��'���L?�ߜ.s.~���-����k%&�ЛQ�M1�j��jtw�;�8
�����\���8�ds�/��E�(�A���RC!ϭo�3Ni���ׯ�~�����.>�M=��~���/O�s��U7W��ɛ%p����%����]=$���:&��ýE�lWK��R�z[����2���P�q���U�$+YW��1vM�k�>Z�ߗ��Ã������     