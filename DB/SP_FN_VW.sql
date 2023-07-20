SET SERVEROUTPUT ON;

-------------------------------------------------------------------------------------------------------VISTAS---------------------------------------------------------------------------------------------------------------------------
--CREAR USUARIO ADMINISTRADOR
ALTER SESSION SET "_ORACLE_SCRIPT"= TRUE;
CREATE USER ADMIN IDENTIFIED BY ADMIN;
GRANT RESOURCE, DBA TO ADMIN;
GRANT ALL PRIVILEGES TO ADMIN;


--VISTA PARA MOSTRAR LA INFORMACION DE TODOS LOS DESTINOS

CREATE VIEW V_DESTINATIONS AS
SELECT TITLE,DESCRIPTION,START_DATE,END_DATE,SPACES,GUIDE,PRICE
FROM DESTINATIONS;

--VISTA PARA MOSTRAR LOS USUARIOS,SU ROL Y STATUS

CREATE VIEW VIEW_USERS_WITH_ROLES AS
SELECT U.ID_USER, U.NAME, U.LAST_NAME, U.EMAIL, U.PHONE, R.DESCRIPCION AS ROL_DESCRIPTION, S.DESCRIPCION AS STATUS_DESCRIPTION
FROM USERS U
INNER JOIN ROLES R ON U.ROL = R.ID_ROLES
INNER JOIN STATUS S ON U.STATUS = S.ID_STATUS;


--VISTA PARA MOSTAR LOS USUARIOS QUE HAN COMPRADO VIAJES, SU NOMBRE, EL NOMBRE DEL DESTINO, EL NOMBRE DEL GUIA Y LA FECHA DE COMPRA
CREATE VIEW VIEW_TRIPS_WITH_DESTINATION_GUIDE AS
SELECT T.ID_TRIP, U.NAME || ' ' || U.LAST_NAME AS USER_NAME, D.TITLE AS DESTINATION_TITLE, G.NAME || ' ' || G.LAST_NAME AS GUIDE_NAME, T.BUY_DATE
FROM TRIP T
INNER JOIN USERS U ON T.ID_USER = U.ID_USER
INNER JOIN DESTINATIONS D ON T.ID_DESTINATION = D.ID_DESTINATION
INNER JOIN GUIDES G ON D.GUIDE = G.ID_GUIDE;

--VISTA PARA VER LAS SOLICITUDES DE CONTACTO, EL NOMBRE Y ESTATUS
CREATE VIEW VIEW_CONTACTS_WITH_STATUS AS
SELECT C.ID_CONTACT, C.EMAIL, C.PHONE, C.NAME || ' ' || C.LAST_NAME AS USER_NAME, SS.DESCRIPCION AS STATUS_DESCRIPTION, C.DATE_REGIS
FROM CONTACT C
INNER JOIN STATUS_SOLICITUD SS ON C.STATUS_CONTACT = SS.ID_STATUS_SOLICITUD;


--VISTA PARA MOSTAR TODOS LOS REVIEWS
CREATE VIEW VIEW_REVIEWS_WITH_USERS AS
SELECT R.ID_REVIEW, U.NAME || ' ' || U.LAST_NAME AS USER_NAME, R.TITLE, R.DESCRIPTION, R.CALIF, R.DATE_REVIEW
FROM REVIEW R
INNER JOIN USERS U ON R.ID_USER = U.ID_USER;


--VISTA PARA CONTAR LA CANTIDAD DE SOLICITUDES POR SERVICIO
CREATE VIEW VIEW_SERVICES_WITH_REQUESTS AS
SELECT S.ID_SERVICES, S.TITLE AS SERVICE_TITLE, S.DESCRIPTION AS SERVICE_DESCRIPTION, S.COST, COUNT(C.SERVICES) AS REQUESTS_COUNT
FROM SERVICES S
LEFT JOIN CONTACT C ON S.ID_SERVICES = C.SERVICES
GROUP BY S.ID_SERVICES, S.TITLE, S.DESCRIPTION, S.COST;

--VISTA PARA MOSTAR LA INFORMACION DEL BLOG, EL NOMBRE DEL USUARIO QUE LO CREA Y LA INFORMACION DEL DESTINO
CREATE VIEW VIEW_BLOGS_WITH_USERS_DESTINATIONS AS
SELECT B.ID_BLOG, U.NAME || ' ' || U.LAST_NAME AS AUTHOR_NAME, B.TITLE AS BLOG_TITLE, B.DESCRIPTION AS BLOG_DESCRIPTION, D.TITLE AS DESTINATION_TITLE
FROM BLOG_ENTRY B
INNER JOIN USERS U ON B.ID_USER = U.ID_USER
INNER JOIN DESTINATIONS D ON B.ID_DESTINATION = D.ID_DESTINATION;


--VISTA PARA MOSTAR LOS GUIAS Y LOS IDIOMAS HABLADOS
CREATE VIEW VIEW_GUIDES_WITH_LANGUAGES AS
SELECT G.ID_GUIDE, G.NAME || ' ' || G.LAST_NAME AS GUIDE_NAME, G.EXPERIENCE || ' Años de experiencia' AS EXPERIENCIA, LISTAGG(I.DESCRIPTION, ', ') WITHIN GROUP (ORDER BY I.DESCRIPTION) AS LANGUAGES
FROM GUIDES G
INNER JOIN IDIOMASXGUIDE IG ON G.ID_GUIDE = IG.ID_GUIDE
INNER JOIN IDIOMAS I ON IG.ID_IDIOMAS = I.ID_IDIOMAS
GROUP BY G.ID_GUIDE, G.NAME, G.LAST_NAME, G.EXPERIENCE;


--VISTA PARA VER LOS REVIEWS CON NOMBRE DE USUARIO
CREATE VIEW VIEW_REVIEWS_WITH_USERS_DESTINATIONS AS
SELECT R.ID_REVIEW, U.NAME || ' ' || U.LAST_NAME AS USER_NAME, R.TITLE, R.DESCRIPTION, R.CALIF, R.DATE_REVIEW
FROM REVIEW R
INNER JOIN USERS U ON R.ID_USER = U.ID_USER;


-------------------------------------------------------------------------------------------------------FUNCIONES---------------------------------------------------------------------------------------------------------------------------

--FUNCION PARA VER LA CANTIDAD DE USUARIO ACTIVOS

CREATE OR REPLACE FUNCTION GET_ACTIVE_USERS_COUNT RETURN NUMBER AS
    active_users_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO active_users_count
    FROM USERS
    WHERE STATUS = 1;
    RETURN active_users_count;
END;

--FUNCION PARA VER LA CANTIDAD DE DESTINOS POSIBLES
CREATE OR REPLACE FUNCTION GET_AVAILABLE_DESTINATIONS_COUNT RETURN NUMBER AS
    available_destinations_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO available_destinations_count
    FROM DESTINATIONS
    WHERE END_DATE >= SYSDATE;
    RETURN available_destinations_count;
END;

-- FUNCION PARA VER LAS CALIFICACIONES CON X RATING
CREATE OR REPLACE FUNCTION GET_REVIEWS_WITH_RATING(
    P_RATING NUMBER
) RETURN NUMBER AS
    reviews_with_rating NUMBER;
BEGIN
    SELECT COUNT(*) INTO reviews_with_rating
    FROM REVIEW
    WHERE CALIF = P_RATING;
    RETURN reviews_with_rating;
END;

--FUNCION PARA CONTAR LA CANTIDAD DE CONTACTOS PENDIENTES

CREATE OR REPLACE FUNCTION GET_PENDING_CONTACT_REQUESTS RETURN NUMBER AS
    pending_requests_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO pending_requests_count
    FROM CONTACT
    WHERE STATUS_CONTACT = 1;
    RETURN pending_requests_count;
END;

--FUNCION PARA CONTAR LA CANTIDAD DE USUARIOS REGISTRADOS.
CREATE OR REPLACE FUNCTION GET_TOTAL_REGISTERED_USERS RETURN NUMBER AS
    total_registered_users NUMBER;
BEGIN
    SELECT COUNT(*) INTO total_registered_users
    FROM USERS;
    RETURN total_registered_users;
END;
-------------------------------------------------------------------------------------------------------PROCEDIMIENTOS ALMACENADOS----------------------------------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE RegistrarUsuario (pNombre in VARCHAR2,pApellido IN  VARCHAR2, pCorreo IN VARCHAR2, pTelefono IN  VARCHAR2, pContrasenna IN  VARCHAR2)
as BEGIN

INSERT INTO USERS(NAME, LAST_NAME, EMAIL, PHONE, ROL, PASSWORD, STATUS)
VALUES (pNombre, pApellido, pCorreo, pTelefono,1, pContrasenna,1);

END;
/

CREATE OR REPLACE PROCEDURE INSERT_DESTINATION(
    P_TITLE VARCHAR2,
    P_DESCRIPTION VARCHAR2,
    P_START_DATE DATE,
    P_END_DATE DATE,
    P_SPACES NUMBER,
    P_GUIDE NUMBER,
    P_PRICE NUMBER
) AS
BEGIN
    INSERT INTO DESTINATIONS (TITLE, DESCRIPTION, START_DATE, END_DATE, SPACES, GUIDE, PRICE)
    VALUES (P_TITLE, P_DESCRIPTION, P_START_DATE, P_END_DATE, P_SPACES, P_GUIDE, P_PRICE);
    COMMIT;
END;
/


CREATE OR REPLACE PROCEDURE INSERT_GUIDE(
    P_NAME VARCHAR2,
    P_LAST_NAME VARCHAR2,
    P_EXPERIENCE NUMBER
) AS
BEGIN
    INSERT INTO GUIDES (NAME, LAST_NAME, EXPERIENCE)
    VALUES (P_NAME, P_LAST_NAME, P_EXPERIENCE);
    COMMIT;
END;
/

CREATE OR REPLACE PROCEDURE ADD_LANGUAGE_TO_GUIDE(
    P_ID_GUIDE NUMBER,
    P_ID_IDIOMAS NUMBER
) AS
BEGIN
    INSERT INTO IDIOMASXGUIDE (ID_GUIDE, ID_IDIOMAS)
    VALUES (P_ID_GUIDE, P_ID_IDIOMAS);
    COMMIT;
END;
/

CREATE OR REPLACE PROCEDURE UPDATE_CONTACT_STATUS(
    P_ID_CONTACT NUMBER,
    P_NEW_STATUS_CONTACT NUMBER
) AS
BEGIN
    UPDATE CONTACT
    SET STATUS_CONTACT = P_NEW_STATUS_CONTACT
    WHERE ID_CONTACT = P_ID_CONTACT;
    COMMIT;
END;
/

CREATE OR REPLACE PROCEDURE FILTER_DESTINATIONS_BY_PRICE(
    P_MIN_PRICE NUMBER,
    P_MAX_PRICE NUMBER
) AS
BEGIN
    SELECT *
    FROM DESTINATIONS
    WHERE PRICE BETWEEN P_MIN_PRICE AND P_MAX_PRICE;
END;
/

CREATE OR REPLACE PROCEDURE FILTER_DESTINATIONS_BY_DATE(
    P_START_DATE DATE,
    P_END_DATE DATE
) AS
BEGIN
    SELECT *
    FROM DESTINATIONS
    WHERE START_DATE >= P_START_DATE AND END_DATE <= P_END_DATE;
END;
/

CREATE OR REPLACE PROCEDURE FILTER_DESTINATIONS_BY_SPACES(
    P_MIN_SPACES NUMBER
) AS
BEGIN
    SELECT *
    FROM DESTINATIONS
    WHERE SPACES >= P_MIN_SPACES;
END;
/

CREATE OR REPLACE PROCEDURE FILTER_DESTINATIONS_BY_PRICE(
    P_MIN_PRICE NUMBER,
    P_MAX_PRICE NUMBER
) AS
BEGIN
    SELECT *
    FROM DESTINATIONS
    WHERE PRICE BETWEEN P_MIN_PRICE AND P_MAX_PRICE;
END;

CREATE OR REPLACE PROCEDURE RegistrarFormulario (pID_USER_SOLICITUD in NUMBER, pFULLNAME IN  VARCHAR2, pEMAIL IN VARCHAR2, pPHONE IN  VARCHAR2, pSERVICIO in VARCHAR2, pMENSAJE in VARCHAR2)
as BEGIN

INSERT INTO SOLICITUD(ID_USER_SOLICITUD, FULLNAME, EMAIL, PHONE, SERVICIO, MENSAJE)
VALUES (pID_USER_SOLICITUD, pFULLNAME, pEMAIL, pPHONE, pSERVICIO, pMENSAJE);

END;

-------------------------------------------------------------------------------------------------------CURSORES---------------------------------------------------------------------------------------------------------------------------
--users

DECLARE
  CURSOR cur_usuarios IS
    SELECT id_user, name,last_name, email
    FROM USERS;
  v_id_usuario users.id_user%TYPE;
  v_nombre users.name%TYPE;
  v_apellido users.last_name%TYPE;
  v_correo_electronico users.email%TYPE;
BEGIN
  OPEN cur_usuarios;
  LOOP
    FETCH cur_usuarios INTO v_id_usuario, v_nombre, v_apellido, v_correo_electronico;
    EXIT WHEN cur_usuarios%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('ID Usuario: ' || v_id_usuario || ', Nombre: ' || v_nombre || ', Apellido: ' || v_apellido || ', Correo electr�nico: ' || v_correo_electronico);
  END LOOP;
  CLOSE cur_usuarios;
END;

--destinations

DECLARE
  CURSOR cur_destinations IS
    SELECT id_destination, title, description
    FROM destinations;
  v_id_destination destinations.id_destination%TYPE;
  v_destination_name destinations.title%TYPE;
  v_description destinations.description%TYPE;
BEGIN
  OPEN cur_destinations;
  LOOP
    FETCH cur_destinations INTO v_id_destination, v_destination_name, v_description;
    EXIT WHEN cur_destinations%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('Destination ID: ' || v_id_destination || ', Name: ' || v_destination_name || ', Description: ' || v_description);
  END LOOP;
  CLOSE cur_destinations;
END;

--guides

DECLARE
  CURSOR cur_guides IS
    SELECT id_guide, name, last_name, experience
    FROM guides;
  v_id_guide guides.id_guide%TYPE;
  v_guide_name guides.name%TYPE;
  v_last_name guides.last_name%TYPE;
  v_experience guides.experience%TYPE;
BEGIN
  OPEN cur_guides;
  LOOP
    FETCH cur_guides INTO v_id_guide, v_guide_name, v_last_name, v_experience;
    EXIT WHEN cur_guides%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('Guide ID: ' || v_id_guide || ', Name: ' || v_guide_name || ', Location: ' || v_last_name || ', Specialty: ' || v_experience);
  END LOOP;
  CLOSE cur_guides;
END;

--services

DECLARE
  CURSOR cur_services IS
    SELECT id_services, title, description, cost
    FROM services;
  v_service_id services.id_services%TYPE;
  v_service_name services.title%TYPE;
  v_description services.description%TYPE;
  v_price services.cost%TYPE;
BEGIN
  OPEN cur_services;
  LOOP
    FETCH cur_services INTO v_service_id, v_service_name, v_description, v_price;
    EXIT WHEN cur_services%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('Service ID: ' || v_service_id || ', Name: ' || v_service_name || ', Description: ' || v_description || ', cost: ' || v_price);
  END LOOP;
  CLOSE cur_services;
END;


--TRIP

DECLARE
  CURSOR cur_trip IS
    SELECT t.id_trip, d.title, d.start_date, d.end_date, t.id_user, u.name, u.email, t.buy_date
    FROM trip t
    JOIN destinations d ON t.id_destination = d.id_destination
    JOIN users u ON t.id_user = u.id_user;
  v_trip_id trip.id_trip%TYPE;
  v_destinations_name destinations.title%TYPE;
  v_destinations_date destinations.start_date%TYPE;
  v_destinations_end destinations.end_date%TYPE;
  v_trip_id_user trip.id_user%TYPE;
  v_user_name users.name%TYPE;
  v_email users.email%TYPE;
  v_trip_buy_Date trip.buy_date%TYPE;
BEGIN
  OPEN cur_trip;
  LOOP
    FETCH cur_trip INTO v_trip_id, v_destinations_name, v_destinations_date, v_destinations_end, v_trip_id_user, v_user_name, v_email, v_trip_buy_Date;
    EXIT WHEN cur_trip%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('Trip ID: ' || v_trip_id || ', Trip Name: ' || v_destinations_name || ', Trip Start Date: ' || v_destinations_date ||
    ', Trip End Date: ' || v_destinations_end || ', ID de Usuario: ' || v_trip_id_user || ', User Name: ' || v_user_name || ', Email: ' 
    || v_email || ', Buy date: ' || v_trip_buy_Date);
  END LOOP;
  CLOSE cur_trip;
END;

-------------------------------------------------------------------------------------------------------PAQUETES---------------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------TRIGGERS---------------------------------------------------------------------------------------------------------------------------

---Procedimiento para guardar cambios en la modificación de la tabla de SOLICITUD

CREATE TABLE SOLICITUD(
ID_SOLICITUD NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY,
ID_USER_SOLICITUD NUMBER,
FULLNAME VARCHAR2(50),
EMAIL VARCHAR2(50),
PHONE VARCHAR2(50),
SERVICIO VARCHAR2(50),
MENSAJE VARCHAR2(100)
);

CREATE OR REPLACE PROCEDURE RegistrarFormulario (pID_USER_SOLICITUD in NUMBER, pFULLNAME IN  VARCHAR2, pEMAIL IN VARCHAR2, pPHONE IN  VARCHAR2, pSERVICIO in VARCHAR2, pMENSAJE in VARCHAR2)
as BEGIN

INSERT INTO SOLICITUD(ID_USER_SOLICITUD, FULLNAME, EMAIL, PHONE, SERVICIO, MENSAJE)
VALUES (pID_USER_SOLICITUD, pFULLNAME, pEMAIL, pPHONE, pSERVICIO, pMENSAJE);

END;

EXEC RegistrarFormulario (5682, 'Marie Franklin', 'mefrank@example.com', '123456789', 'Servicio 3', 'Este es un mensaje de solicitud');


CREATE TABLE AUDITORIA_SOLICITUD (
    AUDIT_ID NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY,
    OPERATION_TYPE VARCHAR2(10),
    AUDIT_TIMESTAMP TIMESTAMP,
    USER_ID NUMBER,
    FULLNAME VARCHAR2(50),
    EMAIL VARCHAR2(50),
    PHONE VARCHAR2(50),
    SERVICIO VARCHAR2(50),
    MENSAJE_AUDITORIA VARCHAR2(100) 
);

CREATE OR REPLACE PROCEDURE AUDITORIA_SOLICITUD_PROCEDIMIENTO (
    p_operation_type IN VARCHAR2,
    p_user_id IN NUMBER,
    p_fullname IN VARCHAR2,
    p_email IN VARCHAR2,
    p_phone IN VARCHAR2,
    p_servicio IN VARCHAR2,
    p_mensaje IN VARCHAR2
) AS
BEGIN
    INSERT INTO AUDITORIA_SOLICITUD (
        OPERATION_TYPE,
        AUDIT_TIMESTAMP,
        USER_ID,
        FULLNAME,
        EMAIL,
        PHONE,
        SERVICIO,
        MENSAJE_AUDITORIA  
    ) VALUES (
        p_operation_type,
        SYSTIMESTAMP,
        p_user_id,
        p_fullname,
        p_email,
        p_phone,
        p_servicio,
        p_mensaje
    );
END;
/

CREATE OR REPLACE TRIGGER TRG_AUDITORIA_SOLICITUD
AFTER INSERT OR UPDATE OR DELETE ON SOLICITUD
FOR EACH ROW
DECLARE
    v_operation_type VARCHAR2(10);
BEGIN
    IF INSERTING THEN
        v_operation_type := 'INSERT';
        AUDITORIA_SOLICITUD_PROCEDIMIENTO(
        v_operation_type,
        :NEW.ID_USER_SOLICITUD,
        :NEW.FULLNAME,
        :NEW.EMAIL,
        :NEW.PHONE,
        :NEW.SERVICIO,
        :NEW.MENSAJE
    );
    ELSIF UPDATING THEN
        v_operation_type := 'UPDATE';
        AUDITORIA_SOLICITUD_PROCEDIMIENTO(
        v_operation_type,
        :OLD.ID_USER_SOLICITUD,
        :OLD.FULLNAME,
        :OLD.EMAIL,
        :OLD.PHONE,
        :OLD.SERVICIO,
        :OLD.MENSAJE
    );
    ELSIF DELETING THEN
        v_operation_type := 'DELETE';
        AUDITORIA_SOLICITUD_PROCEDIMIENTO(
        v_operation_type,
        :OLD.ID_USER_SOLICITUD,
        :OLD.FULLNAME,
        :OLD.EMAIL,
        :OLD.PHONE,
        :OLD.SERVICIO,
        :OLD.MENSAJE
    );
    END IF;
END;
/


---pRUEBA 
INSERT INTO SOLICITUD (ID_USER_SOLICITUD, FULLNAME, EMAIL, PHONE, SERVICIO, MENSAJE)
VALUES (1, 'John Doe', 'johndoe@example.com', '123456789', 'Servicio 1', 'Este es un mensaje de solicitud');

INSERT INTO SOLICITUD (ID_USER_SOLICITUD, FULLNAME, EMAIL, PHONE, SERVICIO, MENSAJE)
VALUES (2, 'John Doe2', 'johndoe@example.com', '123456789', 'Servicio 1', 'Este es un mensaje de solicitud');


DELETE FROM SOLICITUD WHERE ID_USER_SOLICITUD = 2;

UPDATE SOLICITUD
SET SERVICIO = 'Nuevo servicio', MENSAJE = 'Mensaje actualizado'
WHERE ID_USER_SOLICITUD = 1;

SELECT * FROM SOLICITUD;
SELECT * FROM AUDITORIA_SOLICITUD;


------- tABLA DE USERS, auditoria

CREATE TABLE AUDITORIA_USERS (
    AUDIT_ID NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY,
    OPERATION_TYPE VARCHAR2(10),
    AUDIT_TIMESTAMP TIMESTAMP,
    USER_ID NUMBER,
    NAME VARCHAR2(50),
    LAST_NAME VARCHAR2(50),
    EMAIL VARCHAR2(50),
    PHONE VARCHAR2(50),
    ROL NUMBER,
    PASSWORD VARCHAR2(50),
    STATUS NUMBER
);

CREATE OR REPLACE PROCEDURE AUDITORIA_USERS_PROCEDURE (
    p_operation_type IN VARCHAR2,
    p_user_id IN NUMBER,
    p_name IN VARCHAR2,
    p_last_name IN VARCHAR2,
    p_email IN VARCHAR2,
    p_phone IN VARCHAR2,
    p_rol IN NUMBER,
    p_password IN VARCHAR2,
    p_status IN NUMBER
) AS
BEGIN
    INSERT INTO AUDITORIA_USERS (
        OPERATION_TYPE,
        AUDIT_TIMESTAMP,
        USER_ID,
        NAME,
        LAST_NAME,
        EMAIL,
        PHONE,
        ROL,
        PASSWORD,
        STATUS
    ) VALUES (
        p_operation_type,
        SYSTIMESTAMP,
        p_user_id,
        p_name,
        p_last_name,
        p_email,
        p_phone,
        p_rol,
        p_password,
        p_status
    );
END;
/

CREATE OR REPLACE TRIGGER TRG_AUDITORIA_USERS
AFTER INSERT OR UPDATE OR DELETE ON USERS
FOR EACH ROW
DECLARE
    v_operation_type VARCHAR2(10);
BEGIN
        IF INSERTING THEN
        v_operation_type := 'INSERT';
        AUDITORIA_USERS_PROCEDURE(
        v_operation_type,
        :NEW.ID_USER,
        :NEW.NAME,
        :NEW.LAST_NAME,
        :NEW.EMAIL,
        :NEW.PHONE,
        :NEW.ROL,
        :NEW.PASSWORD,
        :NEW.STATUS
    );
    ELSIF UPDATING THEN
        v_operation_type := 'UPDATE';
        AUDITORIA_USERS_PROCEDURE(
        v_operation_type,
        :OLD.ID_USER,
        :OLD.NAME,
        :OLD.LAST_NAME,
        :OLD.EMAIL,
        :OLD.PHONE,
        :OLD.ROL,
        :OLD.PASSWORD,
        :OLD.STATUS
    );
    ELSIF DELETING THEN
        v_operation_type := 'DELETE';
        AUDITORIA_USERS_PROCEDURE(
        v_operation_type,
        :OLD.ID_USER,
        :OLD.NAME,
        :OLD.LAST_NAME,
        :OLD.EMAIL,
        :OLD.PHONE,
        :OLD.ROL,
        :OLD.PASSWORD,
        :OLD.STATUS
    );
    END IF;
END;
/

INSERT INTO USERS (NAME, LAST_NAME, EMAIL, PHONE, ROL, PASSWORD, STATUS)
VALUES ('John', 'Doe', 'johndoe@example.com', '123456789', 1, 'password123', 1);

DELETE FROM USERS WHERE ID_USER = 25;

UPDATE USERS
SET EMAIL = 'newemail@example.com', PHONE = '7777777'
WHERE ID_USER = 24;

SELECT * FROM USERS;
SELECT * FROM AUDITORIA_USERS;

