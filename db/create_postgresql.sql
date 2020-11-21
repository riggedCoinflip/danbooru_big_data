/* ---------------------------------------------------------------------- */
/* Script generated with: DeZign for Databases 12.2.0                     */
/* Target DBMS:           PostgreSQL 12                                   */
/* Project file:          postgreERM.dez                                  */
/* Project name:                                                          */
/* Author:                                                                */
/* Script type:           Database creation script                        */
/* Created on:            2020-11-21 17:29                                */
/* ---------------------------------------------------------------------- */


/* ---------------------------------------------------------------------- */
/* Add tables                                                             */
/* ---------------------------------------------------------------------- */

/* ---------------------------------------------------------------------- */
/* Add table "tag_category"                                               */
/* ---------------------------------------------------------------------- */

CREATE TABLE tag_category (
    tag_category_id INTEGER  NOT NULL,
    name CHARACTER(40),
    CONSTRAINT PK_tag_category PRIMARY KEY (tag_category_id)
);

COMMENT ON COLUMN tag_category.tag_category_id IS 'Can be: 0, 1, 3, 4, 5 (general, artist, copyright, character, meta respectively)';

/* ---------------------------------------------------------------------- */
/* Add table "user"                                                       */
/* ---------------------------------------------------------------------- */

CREATE TABLE user (
    user_id INTEGER  NOT NULL,
    id INTEGER,
    CONSTRAINT PK_user PRIMARY KEY (user_id)
);

/* ---------------------------------------------------------------------- */
/* Add table "image"                                                      */
/* ---------------------------------------------------------------------- */

CREATE TABLE image (
    id INTEGER  NOT NULL,
    uploader_id INTEGER,
    approver_id INTEGER,
    parent_id INTEGER,
    created_at DATE,
    updated_at DATE,
    last_commented_at DATE,
    score INTEGER,
    up_score INTEGER,
    down_score INTEGER,
    source CHARACTER(200),
    rating CHARACTER(1),
    image_width SMALLINT,
    image_hight SMALLINT,
    file_size INTEGER,
    has_children BOOLEAN,
    is_note_locked BOOLEAN,
    is_status_locked BOOLEAN,
    is_pending BOOLEAN,
    is_flagged BOOLEAN,
    is_deleted BOOLEAN,
    is_banned BOOLEAN,
    CONSTRAINT PK_image PRIMARY KEY (id)
);

COMMENT ON COLUMN image.rating IS 'safe, questionable or explicit';

/* ---------------------------------------------------------------------- */
/* Add table "tags"                                                       */
/* ---------------------------------------------------------------------- */

CREATE TABLE tags (
    tag_id INTEGER  NOT NULL,
    name CHARACTER(50)  NOT NULL,
    tag_category_id INTEGER  NOT NULL,
    CONSTRAINT PK_tags PRIMARY KEY (tag_id)
);

/* ---------------------------------------------------------------------- */
/* Add table "tags_image"                                                 */
/* ---------------------------------------------------------------------- */

CREATE TABLE tags_image (
    tag_id INTEGER  NOT NULL,
    id INTEGER  NOT NULL,
    CONSTRAINT PK_tags_image PRIMARY KEY (tag_id, id)
);

/* ---------------------------------------------------------------------- */
/* Add foreign key constraints                                            */
/* ---------------------------------------------------------------------- */

ALTER TABLE image ADD CONSTRAINT uploader_image 
    FOREIGN KEY (uploader_id) REFERENCES user (user_id);

ALTER TABLE image ADD CONSTRAINT image_image 
    FOREIGN KEY (parent_id) REFERENCES image (id);

ALTER TABLE image ADD CONSTRAINT approver_image 
    FOREIGN KEY (approver_id) REFERENCES user (user_id);

ALTER TABLE tags ADD CONSTRAINT tag_category_tags 
    FOREIGN KEY (tag_category_id) REFERENCES tag_category (tag_category_id);

ALTER TABLE tags_image ADD CONSTRAINT tags_tags_image 
    FOREIGN KEY (tag_id) REFERENCES tags (tag_id);

ALTER TABLE tags_image ADD CONSTRAINT image_tags_image 
    FOREIGN KEY (id) REFERENCES image (id);
