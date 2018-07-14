DROP TABLE IF EXISTS "accounts";
DROP SEQUENCE IF EXISTS accounts_id_seq;
CREATE SEQUENCE accounts_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1;

CREATE TABLE "public"."accounts" (
    "id" integer DEFAULT nextval('accounts_id_seq') NOT NULL,
    "username" character varying NOT NULL,
    "password" character varying NOT NULL,
    CONSTRAINT "accounts_username" PRIMARY KEY ("username")
) WITH (oids = false);


DROP TABLE IF EXISTS "books";
DROP SEQUENCE IF EXISTS books_id_seq;
CREATE SEQUENCE books_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1;

CREATE TABLE "public"."books" (
    "id" integer DEFAULT nextval('books_id_seq') NOT NULL,
    "isbn" character varying NOT NULL,
    "title" character varying NOT NULL,
    "author" character varying NOT NULL,
    "year" integer NOT NULL,
    CONSTRAINT "books_isbn" PRIMARY KEY ("isbn")
) WITH (oids = false);


DROP TABLE IF EXISTS "reviews";
DROP SEQUENCE IF EXISTS reviews_id_seq;
CREATE SEQUENCE reviews_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1;

CREATE TABLE "public"."reviews" (
    "id" integer DEFAULT nextval('reviews_id_seq') NOT NULL,
    "acc_id" character varying NOT NULL,
    "book_id" character varying NOT NULL,
    "comment" character varying NOT NULL,
    "rating" integer NOT NULL,
    "date" timestamp DEFAULT now() NOT NULL,
    CONSTRAINT "reviews_id" PRIMARY KEY ("id"),
    CONSTRAINT "reviews_acc_id_fkey" FOREIGN KEY (acc_id) REFERENCES accounts(username) ON DELETE CASCADE NOT DEFERRABLE,
    CONSTRAINT "reviews_book_id_fkey" FOREIGN KEY (book_id) REFERENCES books(isbn) ON DELETE CASCADE NOT DEFERRABLE
) WITH (oids = false);
