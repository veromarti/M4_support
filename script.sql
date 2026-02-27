CREATE DATABASE crudzaso_academy_vmc;

USE crudzaso_academy_vmc;

CREATE TABLE users(
	id INT AUTO_INCREMENT PRIMARY KEY,
	full_name VARCHAR(200) NOT NULL,
	email VARCHAR(120) NOT NULL UNIQUE,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP);

CREATE TABLE roles(
	id INT AUTO_INCREMENT PRIMARY KEY,
	code VARCHAR(50) NOT NULL UNIQUE,
	name VARCHAR(100) NOT NULL,
	description TEXT,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP);

CREATE TABLE user_roles(
	user_id INT NOT NULL,
	role_id INT NOT NULL,
	assigned_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	
	PRIMARY KEY(user_id, role_id),
	CONSTRAINT fk_user_roles_user
		FOREIGN KEY (user_id) 
		REFERENCES users(id) ON DELETE CASCADE,
		
		FOREIGN KEY (role_id) 
		REFERENCES roles(id) ON DELETE CASCADE
	);
		
CREATE TABLE courses(
	id INT AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(100) NOT NULL,
	level ENUM('BEGINNER', 'INTERMEDIATE', 'EXPERT') NOT NULL DEFAULT 'BEGINNER',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP);

CREATE TABLE enrollments (
	id INT AUTO_INCREMENT PRIMARY KEY,
	user_id INT NOT NULL,
	course_id INT NOT NULL,
	enrolled_at DATETIME DEFAULT CURRENT_TIMESTAMP,

	FOREIGN KEY (user_id) 
	REFERENCES users(id) ON DELETE CASCADE,
		
	FOREIGN KEY (course_id) 
	REFERENCES courses(id) ON DELETE CASCADE,
	
	UNIQUE KEY uq_user_course (user_id, course_id)
);

INSERT INTO users (full_name, email) VALUES 
	('Veronica Martinez','veronica@mail.com');
	('Daniela Quinto','daniela@mail.com'),
	('Diego Morales','diego@mail.com'),
	('Sebastian Vargas','sebastian@mail.com');

INSERT INTO roles (code, name, description) VALUES 
	('STUDENT','Student','Can enroll and take courses'),
	('TUTOR','Tutor','Supports students and reviews'),
	('TL','Team Leader','Leads a training group'),
	('ADMIN','Admin','Platform administration');

INSERT INTO user_roles (user_id,role_id) VALUES 
	(2,3),
	(2,4);

INSERT INTO courses (name,level) VALUES
	('SQL','INTERMEDIATE'),
	('JAVA','BEGINNER'),
	('C#','EXPERT');

INSERT INTO enrollments (user_id,course_id) VALUES
	(1,3),
	(1,2),
	(3,1);

INSERT INTO user_roles (user_id, role_id)
SELECT 1, id FROM roles WHERE code IN ('ADMIN', 'TL');

INSERT INTO user_roles (user_id, role_id)
SELECT 1, id FROM roles WHERE code IN ('ADMIN', 'TL');

SELECT * FROM roles;

SELECT * FROM roles WHERE code IN ('TUTOR', 'STUDENT');

SELECT id FROM roles WHERE code IN ('TUTOR', 'STUDENT');

SELECT id, full_name FROM users WHERE email IN ('antony@mail.com');

SELECT 1, id FROM roles WHERE code IN ('TUTOR', 'STUDENT');

SELECT r.id, u.id FROM roles r, users u;

INSERT INTO user_roles (user_id, role_id)
SELECT u.id,  r.id 
FROM roles r, users u
WHERE code IN ('TUTOR','STUDENT')
AND email in ('diego@mail.com');

SELECT * FROM user_roles;

SELECT name FROM roles WHERE id=1;

SELECT * FROM user_roles, roles
WHERE user_roles.role_id = roles.id; -- Forma antigua de hacerlo

SELECT * -- A la tabla user_roles le vamos a pegar informacion de la tabla donde vamos a buscar roles
FROM user_roles ur
JOIN roles r ON r.id = ur.role_id
JOIN users u ON u.id = ur.user_id;

SELECT u.full_name, r.name -- Solo me traje en nombre de users y el nombre del rol
FROM user_roles ur
JOIN roles r ON r.id = ur.role_id
JOIN users u ON u.id = ur.user_id;

SELECT u.full_name, GROUP_CONCAT(r.name SEPARATOR ' / ' ) AS roles -- Para juntar la info de la tabla roles
FROM user_roles ur
JOIN roles r ON r.id = ur.role_id -- Lo que esta en la izq que esta en la derecha
JOIN users u ON u.id = ur.user_id
GROUP BY u.id; -- Hacerlo por un valor unico full_name no es unico

SELECT u.full_name, GROUP_CONCAT(r.name SEPARATOR ' / ' ) AS roles -- Para juntar la info de la tabla roles
FROM user_roles ur -- SIEMPRE ES LA IZQUIERDA
JOIN roles r ON r.id = ur.role_id
RIGHT JOIN users u ON u.id = ur.user_id -- LA DERECHA ES DEL JOIN
GROUP BY u.id; 

SELECT u.full_name, GROUP_CONCAT(r.name SEPARATOR ' / ' ) AS roles -- Para juntar la info de la tabla roles
FROM user_roles ur
JOIN roles r ON r.id = ur.role_id
LEFT JOIN users u ON u.id = ur.user_id
GROUP BY u.id; 

SELECT users.full_name as coder, courses.name 
FROM enrollments
JOIN users ON users.id = enrollments.user_id
JOIN courses ON courses.id = enrollments.course_id;

-- Traer todos los usuarios que tienen rol TL en el curso id= 1
SELECT users.full_name as coder, courses.name 
FROM enrollments
JOIN users ON users.id = enrollments.user_id
JOIN courses ON courses.id = enrollments.course_id
JOIN user_roles ON user_roles.user_id = users.id
JOIN roles ON roles.id = user_roles.role_id
WHERE course_id =1
AND roles.code IN ('TUTOR');

SELECT users.full_name as coder, courses.name 
FROM enrollments
JOIN users ON users.id = enrollments.user_id
JOIN courses ON courses.id = enrollments.course_id;

SELECT users.full_name as coder, courses.name 
FROM enrollments
JOIN users ON users.id = enrollments.user_id
JOIN courses ON courses.id = enrollments.course_id
JOIN user_roles ON user_roles.user_id = users.id
JOIN roles ON roles.id = user_roles.role_id
WHERE course_id =1;

SELECT * FROM enrollments;

SELECT users.full_name, GROUP_CONCAT(roles.code) as roles
FROM enrollments
JOIN users ON users.id = enrollments.user_id
JOIN courses ON courses.id = enrollments.course_id
JOIN user_roles ON user_roles.user_id = users.id
JOIN roles ON roles.id = user_roles.role_id
GROUP BY users.id;

SELECT users.full_name, courses.name, GROUP_CONCAT(roles.code) as roles
FROM enrollments
JOIN users ON users.id = enrollments.user_id
JOIN courses ON courses.id = enrollments.course_id
JOIN user_roles ON user_roles.user_id = users.id
JOIN roles ON roles.id = user_roles.role_id
GROUP BY users.id;

SELECT *
FROM enrollments
JOIN users ON users.id = enrollments.user_id
JOIN courses ON courses.id = enrollments.course_id
JOIN user_roles ON user_roles.user_id = users.id
JOIN roles ON roles.id = user_roles.role_id;

SELECT users.full_name, courses.name, GROUP_CONCAT(roles.code) as roles
FROM enrollments
JOIN users ON users.id = enrollments.user_id
JOIN courses ON courses.id = enrollments.course_id
JOIN user_roles ON user_roles.user_id = users.id
JOIN roles ON roles.id = user_roles.role_id
WHERE courses.id =1
GROUP BY users.id;

SELECT users.full_name, GROUP_CONCAT(DISTINCT courses.name), GROUP_CONCAT(DISTINCT roles.code) as roles
FROM enrollments
JOIN users ON users.id = enrollments.user_id
JOIN courses ON courses.id = enrollments.course_id
JOIN user_roles ON user_roles.user_id = users.id
JOIN roles ON roles.id = user_roles.role_id
GROUP BY users.id;

SELECT *
FROM enrollments
LEFT JOIN courses ON courses.id = enrollments.course_id;

SELECT *
FROM enrollments
JOIN courses ON courses.id = enrollments.course_id
RIGHT JOIN users ON users.id = enrollments.user_id;
