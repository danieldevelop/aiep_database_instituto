/**
 * COMO PLATAFORMA SE UTILIZO ORACLE 11G
 * M3 - BASE DE DATOS RELACIONAL (AIEP)
 * Nota!: La sintaxis puede variar en la plataforma oracle 11g
 *
 * DATABASE aiep_database_instituto
 * PREFIX DATABASE ap
 */

CREATE DATABASE IF NOT EXISTS aiep_database_instituto;
USE aiep_database_instituto;

--
-- STRUCTURE TO TABLE PROFESOR 
--
CREATE TABLE IF NOT EXISTS ap_profesor(
    rut VARCHAR(15),
    nombre VARCHAR(45) NOT NULL,
    direccion VARCHAR(45) NOT NULL,
    telefono INT NOT NULL
);

--
-- STRUCTURE TO TABLE ALUMNO
--
CREATE TABLE IF NOT EXISTS ap_alumno(
    numero_expediente INT,
    nombre VARCHAR(45) NOT NULL,
    apellidos VARCHAR(45) NOT NULL,
    fecha_nacimiento DATETIME NOT NULL
);

--
-- STRUCTURE TO TABLE MODULO
--
CREATE TABLE IF NOT EXISTS ap_modulo(
    codigo VARCHAR(10),
    nombre VARCHAR(45) NOT NULL,
    PRO_rut VARCHAR(15) NOT NULL,
    ALUM_numero_expediente INT NOT NULL
);

--
-- STRUCTURE TO TABLE MODULO_has_ALUMNO
--
CREATE TABLE IF NOT EXISTS ap_modulo_has_alumno(
    id INT,
    semestre VARCHAR(45),
    MOD_codigo VARCHAR(10) NOT NULL,
    ALUM_numero_expediente INT NOT NULL
);


--
-- ADD INDEX IN TABLES
--
ALTER TABLE ap_profesor 
    ADD PRIMARY KEY(rut);

ALTER TABLE ap_alumno 
    ADD PRIMARY KEY(numero_expediente);

ALTER TABLE ap_modulo 
    ADD PRIMARY KEY(codigo),
    ADD UNIQUE KEY(nombre);
    
ALTER TABLE ap_modulo_has_alumno
    ADD PRIMARY KEY(id),
    ADD UNIQUE KEY(MOD_codigo),
    ADD UNIQUE KEY(ALUM_numero_expediente);


--
-- ADD AUTO_INCREMENT IN TABLES
--
ALTER TABLE ap_modulo_has_alumno 
    MODIFY id INT NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=0;


--
-- CREATE KEYS FOREIGN AND PRIMARY OF TABLES AND 
--  Reference of prefix PRO to table PROFESOR and ALUM to table ALUMNO
--  Reference of prefix MOD to table MODULO and ALUM to table ALUMNO
--
ALTER TABLE ap_modulo 
    ADD CONSTRAINT FK_PROFESOR_rut FOREIGN KEY(PRO_rut) REFERENCES ap_profesor(rut),
    ADD CONSTRAINT FK_ALUMNO_numero_expediente FOREIGN KEY(ALUM_numero_expediente) REFERENCES ap_alumno(numero_expediente);
    
ALTER TABLE ap_modulo_has_alumno
    ADD CONSTRAINT FK_MODULO_codigo FOREIGN KEY(MOD_codigo) REFERENCES ap_modulo(codigo),
    ADD CONSTRAINT FK_ALUMNO_numero_expediente FOREIGN KEY(ALUM_numero_expediente) REFERENCES ap_alumno(numero_expediente);
    

--
-- DUMP DATA IN TABLES
--
/**
INSERT INTO ap_profesor(rut, nombre, direccion, telefono)
    VALUES ('7797535-2', 'Ingrid Gutierrez', 'Julio Prado #2143', 99626808),
    ('18079606-K', 'Abel Zenteno', 'Copihue #2872', 958452846);

INSERT INTO ap_alumno(numero_expediente, nombre, apellidos, fecha_nacimiento)
    VALUES(6860, 'Alvaro Alexis', 'Contreras', NOW()),
    (10528, 'Ronaldo Vega', 'Contreras', NOW());

INSERT INTO ap_modulo(codigo, nombre, PRO_rut, ALUM_numero_expediente)
    VALUES('PRO201', 'TALLER DE PROGRAMACION', '7797535-2', 6860),
    ('HPE101', 'HERRAMIENTAS PARA LA EMPLEABILIDAD', '18079606-K', 10528);

INSERT INTO ap_modulo_has_alumno(semestre, MOD_codigo, ALUM_numero_expediente)
    VALUES('2 Semestre', 'PRO201', 6860),
    ('4 Semestre', 'HPE101', 10528);
*/


--
-- CONSULTAS DE PRUEBAS
--
/**
SELECT alum.numero_expediente, mod_alum.semestre, alum.nombre, pro.nombre as "profesor", m.codigo, 
    m.nombre as "modulo"
FROM ap_alumno alum
INNER JOIN ap_modulo m ON alum.numero_expediente = m.ALUM_numero_expediente
INNER JOIN ap_profesor pro ON m.PRO_rut = pro.rut
INNER JOIN ap_modulo_has_alumno mod_alum ON alum.numero_expediente = mod_alum.ALUM_numero_expediente;
*/
