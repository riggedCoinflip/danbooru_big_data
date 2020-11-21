/* ---------------------------------------------------------------------- */
/* Script generated with: DeZign for Databases 12.2.0                     */
/* Target DBMS:           PostgreSQL 12                                   */
/* Project file:          postgreERM.dez                                  */
/* Project name:                                                          */
/* Author:                                                                */
/* Script type:           Database drop script                            */
/* Created on:            2020-11-21 17:29                                */
/* ---------------------------------------------------------------------- */


/* ---------------------------------------------------------------------- */
/* Drop foreign key constraints                                           */
/* ---------------------------------------------------------------------- */

ALTER TABLE image DROP CONSTRAINT uploader_image;

ALTER TABLE image DROP CONSTRAINT image_image;

ALTER TABLE image DROP CONSTRAINT approver_image;

ALTER TABLE tags DROP CONSTRAINT tag_category_tags;

ALTER TABLE tags_image DROP CONSTRAINT tags_tags_image;

ALTER TABLE tags_image DROP CONSTRAINT image_tags_image;

/* ---------------------------------------------------------------------- */
/* Drop table "tags_image"                                                */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE tags_image DROP CONSTRAINT PK_tags_image;

DROP TABLE tags_image;

/* ---------------------------------------------------------------------- */
/* Drop table "tags"                                                      */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE tags DROP CONSTRAINT PK_tags;

DROP TABLE tags;

/* ---------------------------------------------------------------------- */
/* Drop table "image"                                                     */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE image DROP CONSTRAINT PK_image;

COMMENT ON COLUMN image.rating IS NULL;

DROP TABLE image;

/* ---------------------------------------------------------------------- */
/* Drop table "user"                                                      */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE user DROP CONSTRAINT PK_user;

DROP TABLE user;

/* ---------------------------------------------------------------------- */
/* Drop table "tag_category"                                              */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE tag_category DROP CONSTRAINT PK_tag_category;

COMMENT ON COLUMN tag_category.tag_category_id IS NULL;

DROP TABLE tag_category;
