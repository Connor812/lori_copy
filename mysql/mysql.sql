DROP DATABASE IF EXISTS loridb;

CREATE DATABASE loridb;

USE loridb;

-- Set up of tables -------------------------------------------->

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE journal_page (
    id int(11) AUTO_INCREMENT PRIMARY KEY NOT NULL,
    section_type varchar(11) NOT NULL,
    section_name varchar(50) NOT NULL,
    order_num int(11) UNIQUE NOT NULL
);

CREATE TABLE header (
    id int(11) AUTO_INCREMENT PRIMARY KEY NOT NULL,
    header_content varchar(100) NOT NULL,
    section_id int(11) NOT NULL,
    FOREIGN KEY (section_id) REFERENCES journal_page(id)
);

CREATE TABLE quote (
    id int(11) AUTO_INCREMENT PRIMARY KEY NOT NULL,
    quote_content varchar(500) NOT NULL,
    section_id int(11) NOT NULL,
    FOREIGN KEY (section_id) REFERENCES journal_page(id)
);

CREATE TABLE byline (
    id int(11) AUTO_INCREMENT PRIMARY KEY NOT NULL,
    section_id int(11) NOT NULL,
    FOREIGN KEY (section_id) REFERENCES journal_page(id)
);

CREATE TABLE story_box (
    id int(11) AUTO_INCREMENT PRIMARY KEY NOT NULL,
    img BLOB DEFAULT NULL,
    section_id int(11) NOT NULL,
    FOREIGN KEY (section_id) REFERENCES journal_page(id)
);

CREATE TABLE story_box_paragraphs (
    id int(11) AUTO_INCREMENT PRIMARY KEY NOT NULL,
    paragraph varchar(500) NOT NULL,
    story_box_id int(11) NOT NULL,
    FOREIGN KEY (story_box_id) REFERENCES story_box(id)
);


CREATE TABLE video (
    id int(11) AUTO_INCREMENT PRIMARY KEY NOT NULL,
    video_data LONGBLOB NOT NULL,
    section_id int(11) NOT NULL,
    FOREIGN KEY (section_id) REFERENCES journal_page(id)
);

CREATE TABLE click_list (
    id int(11) AUTO_INCREMENT PRIMARY KEY NOT NULL,
    section_id int(11) NOT NULL
);

CREATE TABLE click_list_items (
    id int(11) AUTO_INCREMENT PRIMARY KEY NOT NULL,
    content varchar(200) NOT NULL,
    click_list_id int(11) NOT NULL,
    FOREIGN KEY (click_list_id) REFERENCES click_list(id)
);

-- Table for the user input ------------------------------------------------------------->

CREATE TABLE user_input (
    id int(11) AUTO_INCREMENT PRIMARY KEY NOT NULL,
    our_story varchar(500) DEFAULT NULL,
    my_concerns varchar(500) DEFAULT NULL,
    respectful_communication BIT(1) DEFAULT 0,
    silence BIT(1) DEFAULT 0,
    profanity BIT(1) DEFAULT 0,
    dealing_with_stress_comment varchar(500) DEFAULT NULL,
    story_ending varchar(500) DEFAULT NULL,
    former_our_story varchar(500) DEFAULT NULL,
    former_partner_concerns varchar(500) DEFAULT NULL,
    former_respectful_communication BIT(1) DEFAULT 0,
    former_silence BIT(1) DEFAULT 0,
    former_profanity BIT(1) DEFAULT 0,
    former_dealing_with_stress_comment varchar(500) DEFAULT NULL,
    former_story_ending varchar(500) DEFAULT NULL,
    previous_partners varchar(500) DEFAULT NULL,
    partner_family_dysfunctional varchar(500) DEFAULT NULL,
    toxic_relationship varchar(500) DEFAULT NULL,
    relationship_damage varchar(500) DEFAULT NULL,
    relationship_self_esteem varchar(500) DEFAULT NULL,
    relationship_isolation varchar(500) DEFAULT NULL,
    relationship_basis varchar(500) DEFAULT NULL,
    belittling varchar(500) DEFAULT NULL,
    criticism varchar(500) DEFAULT NULL,
    blamed varchar(500) DEFAULT NULL,
    accused_of_cheating varchar(500) DEFAULT NULL,
    partner_cheated varchar(500) DEFAULT NULL,
    gave_in varchar(500) DEFAULT NULL,
    abusive BIT(1) DEFAULT 0,
    brandished_anger BIT(1) DEFAULT 0,
    barraged_calls BIT(1) DEFAULT 0,
    critical_of_clothes BIT(1) DEFAULT 0,
    called_family BIT(1) DEFAULT 0,
    damaged_property BIT(1) DEFAULT 0,
    withheld_finances BIT(1) DEFAULT 0,
    dissatisfying BIT(1) DEFAULT 0,
    not_reciprocated BIT(1) DEFAULT 0,
    comment_on_toxic_relationship varchar(500) DEFAULT NULL,
    no_reciprocation BIT(1) DEFAULT 0,
    no_attention BIT(1) DEFAULT 0,
    felt_insecure BIT(1) DEFAULT 0,
    more_intimacy BIT(1) DEFAULT 0,
    more_one_on_one BIT(1) DEFAULT 0,
    dissatisfying_comment varchar(500) DEFAULT NULL,
    medical_issues varchar(500) DEFAULT NULL,
    legal_issues varchar(500) DEFAULT NULL,
    financial_issues varchar(500) DEFAULT NULL,
    sexual_intimacy varchar(500) DEFAULT NULL,
    family_income varchar(500) DEFAULT NULL,
    feeling_stuck BIT(1) DEFAULT 0,
    no_medical_physical_needs BIT(1) DEFAULT 0,
    more_then_one_toxic_relationship BIT(1) DEFAULT 0,
    returned BIT(1) DEFAULT 0,
    repetitive_partners BIT(1) DEFAULT 0,
    giving_all_resources BIT(1) DEFAULT 0,
    professional_counselling varchar(500) DEFAULT NULL,
    experienced_violence BIT(1) DEFAULT 0,
    home_violence BIT(1) DEFAULT 0,
    family_suicide BIT(1) DEFAULT 0,
    death_of_parent BIT(1) DEFAULT 0,    
    childhood_experiences_comment varchar(500) DEFAULT NULL,
    substance_use BIT(1) DEFAULT 0,
    mental_health BIT(1) DEFAULT 0,
    instability BIT(1) DEFAULT 0,
    moving_around BIT(1) DEFAULT 0,
    family_in_jail BIT(1) DEFAULT 0,
    mom_in_toxic_relationship BIT(1) DEFAULT 0,
    prematurity BIT(1) DEFAULT 0,
    adopted BIT(1) DEFAULT 0,
    bullying BIT(1) DEFAULT 0,
    teen_dating_violence BIT(1) DEFAULT 0,
    community_violence BIT(1) DEFAULT 0,
    other_trauma BIT(1) DEFAULT 0,
    trauma_comment varchar(500) DEFAULT NULL,
    why_do_i_keeping_doing_this varchar(500) DEFAULT NULL,
    why_am_i_like_this varchar(500) DEFAULT NULL,
    how_did_i_get_here varchar(500) DEFAULT NULL,
    what_keeps_me varchar(500) DEFAULT NULL,
    why_am_i_stuck varchar(500) DEFAULT NULL,
    general_comment varchar(500) DEFAULT NULL,
    user_id int(11) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id)
);


-- Main Query to get the ordered list of data -------------------------------------------->

SELECT 
    jp.id AS journal_page_id,
    jp.section_type,
    jp.section_name,
    jp.order_num,
    h.id AS header_id,
    h.header_content,
    q.id AS quote_id,
    q.quote_content,
    b.id AS byline_id,
    sb.id AS story_box_id,
    sb.img AS story_box_img,
    v.id AS video_id,
    v.video_data,
    cl.id AS click_list_id
FROM journal_page AS jp
LEFT JOIN header AS h ON jp.id = h.section_id
LEFT JOIN quote AS q ON jp.id = q.section_id
LEFT JOIN byline AS b ON jp.id = b.section_id
LEFT JOIN story_box AS sb ON jp.id = sb.section_id
LEFT JOIN video AS v ON jp.id = v.section_id
LEFT JOIN click_list AS cl ON jp.id = cl.section_id
ORDER BY jp.order_num ASC;

-- Query for getting the click_list items for the click list

SELECT cl.id AS click_list_id,
       cl.section_id AS click_list_section_id,
       cli.id AS click_list_item_id,
       cli.content AS click_list_item_content
FROM click_list AS cl
LEFT JOIN click_list_items AS cli ON cl.id = cli.click_list_id
WHERE cl.id = ?;

-- Query for getting the story_box paragraphs

SELECT sb.id AS story_box_id,
       sb.img,
       sb.section_id,
       sbp.id AS paragraph_id,
       sbp.paragraph
FROM story_box AS sb
LEFT JOIN story_box_paragraphs AS sbp ON sb.id = sbp.story_box_id
WHERE sb.id = ?;

-- Seed data  ------------------------------------------------------>

INSERT INTO `users`(`username`, `email`, `password`, `first_name`, `last_name`) VALUES 
('Connor812','connor812@gmail.com','123','Connor','Savoy');

INSERT INTO journal_page (`section_type`, `section_name`, `order_num`) VALUES 
('header', 'header 1', '1'),
('header', 'header 2', '2'),
('header', 'header 3', '3'),
('header', 'header 4', '4'),
('byline', 'byline 1', '5'),
('byline', 'byline 2', '6'),
('byline', 'byline 3', '7'),
('click_list', 'click_list 1', '8'),
('click_list', 'click_list 2', '9'),
('click_list', 'click_list 3', '10'),
('quote', 'quote 1', '11'),
('quote', 'quote 2', '12'),
('quote', 'quote 3', '13'),
('story_box', 'story_box 1', '14'),
('story_box', 'story_box 2', '15'),
('video', 'video 1', '16');


INSERT INTO header (`header_content`, `section_id`) VALUES 
('Connors First Header','1'),
('Connors Second Header','2'),
('Connors Third Header','3'),
('Connors Forth Header','4');

INSERT INTO byline (`section_id`) VALUES 
('5'),
('6'),
('7');

INSERT INTO click_list (`section_id`) VALUES 
('8'),
('9'),
('10');

INSERT INTO click_list_items(`content`, `click_list_id`) VALUES 
('Click list 1 item 1','1'),
('Click list 1 item 2','1'),
('Click list 1 item 3','1'),
('Click list 2 item 1','2'),
('Click list 2 item 2','1'),
('Click list 3 item 1','3'),
('Click list 3 item 2','3'),
('Click list 3 item 3','3');


INSERT INTO quote (`quote_content`, `section_id`) VALUES 
('Quote 1','11'),
('Quote 2','12'),
('Quote 3','13');

INSERT INTO story_box (`img`, `section_id`) VALUES 
('img 1','14'),
('img 1','15');

INSERT INTO story_box_paragraphs (`paragraph`, `story_box_id`) VALUES 
('Paragraph 1','1'),
('Paragraph 2','1'),
('Paragraph 3','1'),
('Paragraph 1','2');

INSERT INTO video (`video_data`, `section_id`) VALUES 
('video 1','16');


-- This is how ill fix the order when i delete an item out of a table

UPDATE your_table
SET order_number = order_number - 1
WHERE order_number > 3;