-----------------------------VISTAS-------------------------------------

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


-- VISTA PARA VER LOS VIAJES COMPRADOS Y EL DESTINO

CREATE VIEW VIEW_TRIPS_INFO AS
SELECT U.NAME || ' ' || U.LAST_NAME AS USER_NAME, T.BUY_DATE, D.TITLE AS DESTINATION_TITLE, D.DESCRIPTION AS DESTINATION_DESCRIPTION, D.START_DATE, D.END_DATE, D.SPACES, D.PRICE
FROM TRIP T
INNER JOIN USERS U ON T.ID_USER = U.ID_USER
INNER JOIN DESTINATIONS D ON T.ID_DESTINATION = D.ID_DESTINATION;


-------------------------------------------FUNCIONES------------------------------------------------
--FUNCION PARA AUMENTAR O DISMINUIR EL PRECIO DE LOS DESTINOS
CREATE OR REPLACE FUNCTION UPDATE_DESTINATION_PRICE(
    P_DESTINATION_ID NUMBER,
    P_PERCENTAGE_CHANGE NUMBER
) RETURN NUMBER
IS
    V_NEW_PRICE NUMBER;
BEGIN
    -- OBTENER EL PRECIO ACTUAL DEL DESTINO
    SELECT PRICE INTO V_NEW_PRICE
    FROM DESTINATIONS
    WHERE ID_DESTINATION = P_DESTINATION_ID;
    -- CALCULAR EL NUEVO PRECIO CON EL CAMBIO PORCENTUAL
    V_NEW_PRICE := V_NEW_PRICE +(V_NEW_PRICE * (P_PERCENTAGE_CHANGE / 100));
    -- ACTUALIZAR EL PRECIO DEL DESTINO
    UPDATE DESTINATIONS
    SET PRICE = V_NEW_PRICE
    WHERE ID_DESTINATION = P_DESTINATION_ID;
    -- DEVOLVER EL NUEVO PRECIO
    RETURN V_NEW_PRICE;
END UPDATE_DESTINATION_PRICE;

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
    -- Declarar un cursor explícito con el nombre DESTINATION_PRICE
    CURSOR DESTINATION_PRICE IS
        SELECT *
        FROM DESTINATIONS
        WHERE PRICE BETWEEN P_MIN_PRICE AND P_MAX_PRICE;
    
    -- Declarar variables para almacenar los campos de DESTINATIONS
    destination_rec DESTINATIONS%ROWTYPE;
BEGIN
    -- Abrir el cursor
    OPEN DESTINATION_PRICE;
    
    -- Recorrer los resultados
    LOOP
        FETCH DESTINATION_PRICE INTO destination_rec;
        EXIT WHEN DESTINATION_PRICE%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('ID: ' || destination_rec.ID_DESTINATION || ', TITLE: ' || destination_rec.TITLE || ', PRICE: ' || destination_rec.PRICE);
    END LOOP;
    
    -- Cerrar el cursor
    CLOSE DESTINATION_PRICE;
END;



/

CREATE OR REPLACE PROCEDURE FILTER_DESTINATIONS_BY_DATE(
    P_START_DATE DATE,
    P_END_DATE DATE
) AS
    -- Declarar un cursor explícito
    CURSOR destination_cursor IS
        SELECT *
        FROM DESTINATIONS
        WHERE START_DATE >= P_START_DATE AND END_DATE <= P_END_DATE;
    
    -- Declarar variables para los campos de DESTINATIONS
    destination_rec DESTINATIONS%ROWTYPE;
BEGIN
    -- Abrir el cursor y recorrer los resultados
    OPEN destination_cursor;
    LOOP
        FETCH destination_cursor INTO destination_rec;
        EXIT WHEN destination_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('ID: ' || destination_rec.ID_DESTINATION || ', TITLE: ' || destination_rec.TITLE || ', START DATE: ' || destination_rec.START_DATE);
    END LOOP;

    -- Cerrar el cursor
    CLOSE destination_cursor;
END;


CREATE OR REPLACE PROCEDURE FILTER_DESTINATIONS_BY_SPACES(
    P_MIN_SPACES NUMBER
) AS
    -- Declarar un cursor explícito con el nombre DESTINATION_SPACES
    CURSOR DESTINATION_SPACES IS
        SELECT *
        FROM DESTINATIONS
        WHERE SPACES >= P_MIN_SPACES;
    
    -- Declarar variables para almacenar los campos de DESTINATIONS
    destination_rec DESTINATIONS%ROWTYPE;
BEGIN
    -- Abrir el cursor
    OPEN DESTINATION_SPACES;
    
    -- Recorrer los resultados
    LOOP
        FETCH DESTINATION_SPACES INTO destination_rec;
        EXIT WHEN DESTINATION_SPACES%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('ID: ' || destination_rec.ID_DESTINATION || ', TITLE: ' || destination_rec.TITLE || ', SPACES: ' || destination_rec.SPACES);
    END LOOP;
    
    -- Cerrar el cursor
    CLOSE DESTINATION_SPACES;
END;
/

-----procedure de insertar en blog
CREATE OR REPLACE PROCEDURE INSERT_BLOG_ENTRY (
    p_title VARCHAR2,
    p_description VARCHAR2,
    p_id_user NUMBER,
    p_id_destination NUMBER,
    p_image1 BLOB,
    p_image2 BLOB,
    p_image3 BLOB,
    p_image4 BLOB
) AS
BEGIN
    INSERT INTO BLOG_ENTRY (TITLE, DESCRIPTION, ID_USER, ID_DESTINATION, IMAGE1, IMAGE2, IMAGE3, IMAGE4)
    VALUES (p_title, p_description, p_id_user, p_id_destination, p_image1, p_image2, p_image3, p_image4);
    COMMIT;
END;
-----procedure para ver todo el blog
CREATE OR REPLACE PROCEDURE VER_BLOG(
    p_cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_cursor FOR
    SELECT * FROM BLOG_ENTRY;
END;
----procesure para ver la info de blog con la pk de destination
CREATE OR REPLACE PROCEDURE VER_BLOG_PRINCIPAL(
    p_cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_cursor FOR
    SELECT B.TITLE, B.DESCRIPTION, D.TITLE AS DESTINATION_TITLE
    FROM BLOG_ENTRY B
    INNER JOIN DESTINATIONS D ON B.ID_DESTINATION = D.ID_DESTINATION;
END;


---------------------------- CURSORES

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
--**************************************************PAQUETE DE SOLICITUD****************************************************************************
--- TABLA DE FORMULARIO DE SOLICITUD
CREATE TABLE SOLICITUD(
ID_SOLICITUD NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY,
ID_USER_SOLICITUD NUMBER,
FULLNAME VARCHAR2(50),
EMAIL VARCHAR2(50),
PHONE VARCHAR2(50),
SERVICIO VARCHAR2(50),
MENSAJE VARCHAR2(100)
);



CREATE OR REPLACE PACKAGE PAQUETE_SOLICITUD AS
    -- Procedure para agregar una solicitud
    PROCEDURE RegistrarFormulario(
        p_id_user_solicitud IN NUMBER,
        p_fullname IN VARCHAR2,
        p_email IN VARCHAR2,
        p_phone IN VARCHAR2,
        p_servicio IN VARCHAR2,
        p_mensaje IN VARCHAR2
    );
    
    -- Procedure para editar una solicitud
    PROCEDURE EDITAR_SOLICITUD(
        p_id_solicitud IN NUMBER,
        p_id_user_solicitud IN NUMBER,
        p_fullname IN VARCHAR2,
        p_email IN VARCHAR2,
        p_phone IN VARCHAR2,
        p_servicio IN VARCHAR2,
        p_mensaje IN VARCHAR2
    );

    -- Procedure para eliminar una solicitud
    PROCEDURE ELIMINAR_SOLICITUD(
        p_id_solicitud IN NUMBER
    );
    
    -- Function para mostrar las solicitudes (usando un cursor)
    FUNCTION MOSTRAR_SOLICITUDES_VISTA RETURN SYS_REFCURSOR;
END PAQUETE_SOLICITUD;





CREATE OR REPLACE PACKAGE BODY PAQUETE_SOLICITUD AS
    -- Procedure para agregar una solicitud
    PROCEDURE RegistrarFormulario(
        p_id_user_solicitud IN NUMBER,
        p_fullname IN VARCHAR2,
        p_email IN VARCHAR2,
        p_phone IN VARCHAR2,
        p_servicio IN VARCHAR2,
        p_mensaje IN VARCHAR2
    ) AS
    BEGIN
        INSERT INTO SOLICITUD(ID_USER_SOLICITUD, FULLNAME, EMAIL, PHONE, SERVICIO, MENSAJE)
        VALUES (p_id_user_solicitud, p_fullname, p_email, p_phone, p_servicio, p_mensaje);
        COMMIT;
    END RegistrarFormulario;  -- Agregar punto y coma aquí

    -- Procedure para editar una solicitud
    PROCEDURE EDITAR_SOLICITUD(
        p_id_solicitud IN NUMBER,
        p_id_user_solicitud IN NUMBER,
        p_fullname IN VARCHAR2,
        p_email IN VARCHAR2,
        p_phone IN VARCHAR2,
        p_servicio IN VARCHAR2,
        p_mensaje IN VARCHAR2
    ) AS
    BEGIN
        UPDATE SOLICITUD
        SET ID_USER_SOLICITUD = p_id_user_solicitud,
            FULLNAME = p_fullname,
            EMAIL = p_email,
            PHONE = p_phone,
            SERVICIO = p_servicio,
            MENSAJE = p_mensaje
        WHERE ID_SOLICITUD = p_id_solicitud;
        COMMIT;
    END EDITAR_SOLICITUD;

    -- Procedure para eliminar una solicitud
    PROCEDURE ELIMINAR_SOLICITUD(
        p_id_solicitud IN NUMBER
    ) AS
    BEGIN
        DELETE FROM SOLICITUD WHERE ID_SOLICITUD = p_id_solicitud;
        COMMIT;
    END ELIMINAR_SOLICITUD;

    FUNCTION MOSTRAR_SOLICITUDES_VISTA RETURN SYS_REFCURSOR AS
        c SYS_REFCURSOR;
    BEGIN
        OPEN c FOR SELECT * FROM VISTA_SOLICITUDES;
        RETURN c;
    END MOSTRAR_SOLICITUDES_VISTA;
END PAQUETE_SOLICITUD;
/


---****** pruebas!!!*****
BEGIN
    PAQUETE_SOLICITUD.RegistrarFormulario(
        p_id_user_solicitud => 5682,
        p_fullname => 'Marie Franklin',
        p_email => 'mefrank@example.com',
        p_phone => '123456789',
        p_servicio => 'Servicio 3',
        p_mensaje => 'Este es un mensaje de solicitud'
    );
    COMMIT;
END;
/

BEGIN
    PAQUETE_SOLICITUD.EDITAR_SOLICITUD(
        p_id_solicitud => 3,  -- ID de la solicitud que deseas editar
        p_id_user_solicitud => 5682,
        p_fullname => 'Marie Franklin (Modificado)',
        p_email => 'mefrank@example.com',
        p_phone => '987654321',
        p_servicio => 'Servicio 4',
        p_mensaje => 'Este es un mensaje modificado de solicitud'
    );
    COMMIT;
END;
/

BEGIN
    PAQUETE_SOLICITUD.ELIMINAR_SOLICITUD(
        p_id_solicitud => 2  -- ID de la solicitud que deseas eliminar
    );
    COMMIT;
END;
/


SET SERVEROUTPUT ON;
DECLARE
    v_id_solicitud NUMBER;
    v_id_user_solicitud NUMBER;
    v_fullname VARCHAR2(50);
    v_email VARCHAR2(50);
    v_phone VARCHAR2(50);
    v_servicio VARCHAR2(50);
    v_mensaje VARCHAR2(100);
BEGIN
    FOR solicitud IN (SELECT * FROM VISTA_SOLICITUDES) LOOP
        v_id_solicitud := solicitud.ID_SOLICITUD;
        v_id_user_solicitud := solicitud.ID_USER_SOLICITUD;
        v_fullname := solicitud.FULLNAME;
        v_email := solicitud.EMAIL;
        v_phone := solicitud.PHONE;
        v_servicio := solicitud.SERVICIO;
        v_mensaje := solicitud.MENSAJE;
        
        DBMS_OUTPUT.PUT_LINE('ID Solicitud: ' || v_id_solicitud || ', Nombre: ' || v_fullname || ', Email: ' || v_email);
    END LOOP;
END;
/

SELECT * FROM SOLICITUD;


--*************************************************



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

-----procedure de blog
CREATE OR REPLACE PROCEDURE INSERTAR_POST(
    p_titulo IN VARCHAR2,
    p_mensaje IN VARCHAR2,
    p_iduser IN NUMBER,
    p_lugar IN VARCHAR2,
    p_img IN BLOB
) AS
BEGIN
    INSERT INTO BLOG_ENTRY (TITLE, DESCRIPTION, ID_USER, ID_DESTINATION, IMAGE1)
    VALUES (p_titulo, p_mensaje, p_iduser, p_lugar, p_img);
    COMMIT;
END;


------------------------------------

----PAQUETE BLOG ******************************************************************
CREATE OR REPLACE PACKAGE PAQUETE_BLOG AS
    -- Procedure para insertar en el blog
    PROCEDURE INSERT_BLOG_ENTRY (
        title VARCHAR2,
        description VARCHAR2,
        id_user NUMBER,
        id_destination NUMBER,
        image1 BLOB,
        image2 BLOB,
        image3 BLOB,
        image4 BLOB
    );
    
    -- Procedure para modificar una entrada en el blog por su ID
    PROCEDURE MODIFICAR_BLOG_ENTRY (
        id NUMBER,
        title VARCHAR2,
        description VARCHAR2,
        id_user NUMBER,
        id_destination NUMBER,
        image1 BLOB,
        image2 BLOB,
        image3 BLOB,
        image4 BLOB
    );

    -- Procedure para eliminar una entrada del blog por su ID
    PROCEDURE DELETE_BLOG_ENTRY (
        id NUMBER
    );
    
    -- Procedure para ver todo el blog
    PROCEDURE VER_BLOG(
        p_cursor OUT SYS_REFCURSOR
    );
    
    -- Procedure para ver la info de blog con la pk de destination
    PROCEDURE VER_BLOG_PRINCIPAL(
        p_cursor OUT SYS_REFCURSOR
    );
END PAQUETE_BLOG;


CREATE OR REPLACE PACKAGE BODY PAQUETE_BLOG AS
    -- Procedure para insertar en el blog
    PROCEDURE INSERT_BLOG_ENTRY (
        title VARCHAR2,
        description VARCHAR2,
        id_user NUMBER,
        id_destination NUMBER,
        image1 BLOB,
        image2 BLOB,
        image3 BLOB,
        image4 BLOB
    ) AS
    BEGIN
        INSERT INTO BLOG_ENTRY (TITLE, DESCRIPTION, ID_USER, ID_DESTINATION, IMAGE1, IMAGE2, IMAGE3, IMAGE4)
        VALUES (title, description, id_user, id_destination, image1, image2, image3, image4);
        COMMIT;
    END INSERT_BLOG_ENTRY;
    
    -- Procedure para modificar una entrada en el blog por su ID
    PROCEDURE MODIFICAR_BLOG_ENTRY (
        id NUMBER,
        title VARCHAR2,
        description VARCHAR2,
        id_user NUMBER,
        id_destination NUMBER,
        image1 BLOB,
        image2 BLOB,
        image3 BLOB,
        image4 BLOB
    ) AS
    BEGIN
        UPDATE BLOG_ENTRY
        SET TITLE = title, DESCRIPTION = description, ID_USER = id_user, ID_DESTINATION = id_destination,
            IMAGE1 = image1, IMAGE2 = image2, IMAGE3 = image3, IMAGE4 = image4
        WHERE ID_BLOG = id;
        COMMIT;
    END MODIFICAR_BLOG_ENTRY;
    
    -- Procedure para eliminar una entrada del blog por su ID
    PROCEDURE DELETE_BLOG_ENTRY (
        id NUMBER
    ) AS
    BEGIN
        DELETE FROM BLOG_ENTRY
        WHERE ID_BLOG = id;
        COMMIT;
    END DELETE_BLOG_ENTRY;
    
    -- Procedure para ver todo el blog
    PROCEDURE VER_BLOG(
        p_cursor OUT SYS_REFCURSOR
    ) AS
    BEGIN
        OPEN p_cursor FOR
        SELECT * FROM BLOG_ENTRY;
    END VER_BLOG;
    
    -- Procedure para ver la info de blog con la pk de destination
    PROCEDURE VER_BLOG_PRINCIPAL(
        p_cursor OUT SYS_REFCURSOR
    ) AS
    BEGIN
        OPEN p_cursor FOR
        SELECT B.TITLE, B.DESCRIPTION, D.TITLE AS DESTINATION_TITLE
        FROM BLOG_ENTRY B
        INNER JOIN DESTINATIONS D ON B.ID_DESTINATION = D.ID_DESTINATION;
    END VER_BLOG_PRINCIPAL;
END PAQUETE_BLOG;



---PAQUETE USERS ***************************************************************************
CREATE OR REPLACE PACKAGE PAQUETE_USER AS
    -- Procedure para insertar un usuario
    PROCEDURE INSERT_USER (
        name VARCHAR2,
        last_name VARCHAR2,
        email VARCHAR2,
        phone VARCHAR2,
        rol NUMBER,
        password VARCHAR2,
        status NUMBER
    );
    
    -- Procedure para eliminar un usuario por su ID
    PROCEDURE DELETE_USER (
        id_user NUMBER
    );
    
    -- Procedure para ver todos los usuarios
    PROCEDURE VER_USERS (
        cursor OUT SYS_REFCURSOR
    );
    
    -- Procedure para ver los detalles de un usuario por su ID
    PROCEDURE VER_USER_ID (
        id_user NUMBER,
        cursor OUT SYS_REFCURSOR
    );
    
    -- Procedure para actualizar los detalles de un usuario por su ID
    PROCEDURE ACTULIZAR_USER (
        id_user NUMBER,
        name VARCHAR2,
        last_name VARCHAR2,
        email VARCHAR2,
        phone VARCHAR2,
        rol NUMBER,
        password VARCHAR2,
        status NUMBER
    );
END PAQUETE_USER;


CREATE OR REPLACE PACKAGE BODY PAQUETE_USER AS
    -- Procedure para insertar un usuario
    PROCEDURE INSERT_USER (
        name VARCHAR2,
        last_name VARCHAR2,
        email VARCHAR2,
        phone VARCHAR2,
        rol NUMBER,
        password VARCHAR2,
        status NUMBER
    ) AS
    BEGIN
        INSERT INTO USERS (NAME, LAST_NAME, EMAIL, PHONE, ROL, PASSWORD, STATUS)
        VALUES (name, last_name, email, phone, rol, password, status);
        COMMIT;
    END INSERT_USER;
    
    -- Procedure para eliminar un usuario por su ID
    PROCEDURE DELETE_USER (
        id_user NUMBER
    ) AS
    BEGIN
        DELETE FROM USERS WHERE ID_USER = id_user;
        COMMIT;
    END DELETE_USER;
    
    -- Procedure para ver todos los usuarios
    PROCEDURE VER_USERS (
        cursor OUT SYS_REFCURSOR
    ) AS
    BEGIN
        OPEN cursor FOR SELECT * FROM USERS;
    END VER_USERS;
    
    -- Procedure para ver los detalles de un usuario por su ID
    PROCEDURE VER_USER_ID (
        id_user NUMBER,
        cursor OUT SYS_REFCURSOR
    ) AS
    BEGIN
        OPEN cursor FOR SELECT * FROM USERS WHERE ID_USER = id_user;
    END VER_USER_ID;
    
    -- Procedure para actualizar los detalles de un usuario por su ID
    PROCEDURE ACTULIZAR_USER (
        id_user NUMBER,
        name VARCHAR2,
        last_name VARCHAR2,
        email VARCHAR2,
        phone VARCHAR2,
        rol NUMBER,
        password VARCHAR2,
        status NUMBER
    ) AS
    BEGIN
        UPDATE USERS
        SET NAME = name,
            LAST_NAME = last_name,
            EMAIL = email,
            PHONE = phone,
            ROL = rol,
            PASSWORD = password,
            STATUS = status
        WHERE ID_USER = id_user;
        COMMIT;
    END ACTULIZAR_USER;
END PAQUETE_USER;

---PAQUETE SERVICIOS ***************************************************************************
CREATE OR REPLACE PACKAGE PAQUETE_SERVICIOS AS
    -- Procedure para insertar un servicio
    PROCEDURE INSERTAR_SERVICES (
        id_services NUMBER,
        title VARCHAR2,
        description VARCHAR2,
        cost NUMBER
    );
    
    -- Procedure para modificar un servicio por su ID
    PROCEDURE MODIFICAR_SERVICES (
        id_services NUMBER,
        title VARCHAR2,
        description VARCHAR2,
        cost NUMBER
    );

    -- Procedure para eliminar un servicio por su ID
    PROCEDURE ELIMINAR_SERVICES (
        id_services NUMBER
    );
    
    -- Procedure para ver todos los servicios
    PROCEDURE VER_TODOS_SERVICES (
        p_cursor OUT SYS_REFCURSOR
    );
END PAQUETE_SERVICIOS;


CREATE OR REPLACE PACKAGE BODY PAQUETE_SERVICIOS AS
    -- Procedure para insertar un servicio
    PROCEDURE INSERTAR_SERVICES (
        id_services NUMBER,
        title VARCHAR2,
        description VARCHAR2,
        cost NUMBER
    ) AS
    BEGIN
        INSERT INTO SERVICES (ID_SERVICES, TITLE, DESCRIPTION, COST)
        VALUES (id_services, title, description, cost);
        COMMIT;
    END INSERTAR_SERVICES;
    
    -- Procedure para modificar un servicio por su ID
    PROCEDURE MODIFICAR_SERVICES (
        id_services NUMBER,
        title VARCHAR2,
        description VARCHAR2,
        cost NUMBER
    ) AS
    BEGIN
        UPDATE SERVICES
        SET TITLE = title, DESCRIPTION = description, COST = cost
        WHERE ID_SERVICES = id_services;
        COMMIT;
    END MODIFICAR_SERVICES;
    
    -- Procedure para eliminar un servicio por su ID
    PROCEDURE ELIMINAR_SERVICES (
        id_services NUMBER
    ) AS
    BEGIN
        DELETE FROM SERVICES
        WHERE ID_SERVICES = id_services;
        COMMIT;
    END ELIMINAR_SERVICES;
    
    -- Procedure para ver todos los servicios
    PROCEDURE VER_TODOS_SERVICES (
        p_cursor OUT SYS_REFCURSOR
    ) AS
    BEGIN
        OPEN p_cursor FOR
        SELECT * FROM SERVICES;
    END VER_TODOS_SERVICES;
END PAQUETE_SERVICIOS;


---PAQUETE DESTINATIONS ***************************************************************************
CREATE OR REPLACE PACKAGE PAQUETE_DESTINATIONS AS
    -- Procedure para insertar una destinaci�n
    PROCEDURE INSERTAR_DESTINATION (
        title VARCHAR2,
        description CLOB,
        start_date DATE,
        end_date DATE,
        spaces NUMBER,
        guide NUMBER,
        price NUMBER,
        imagen BLOB
    );
    
    -- Procedure para modificar una destinaci�n por su ID
    PROCEDURE MODIFICAR_DESTINATION (
        id_destination NUMBER,
        title VARCHAR2,
        description CLOB,
        start_date DATE,
        end_date DATE,
        spaces NUMBER,
        guide NUMBER,
        price NUMBER,
        imagen BLOB
    );

    -- Procedure para eliminar una destinaci�n por su ID
    PROCEDURE ELIMINAR_DESTINATION (
        id_destination NUMBER
    );
    
    -- Procedure para ver todas las destinaciones
    PROCEDURE VER_TODOS_DESTINATIONS (
        p_cursor OUT SYS_REFCURSOR
    );
        -- Procedure para ver la info de una destinaci�n con EL GUIA
    PROCEDURE VER_DESTINATION_GUIDE (
        id_destination NUMBER,
        p_cursor OUT SYS_REFCURSOR
    );
END PAQUETE_DESTINATIONS;


CREATE OR REPLACE PACKAGE BODY PAQUETE_DESTINATIONS AS
    -- Procedure para insertar una destinaci�n
    PROCEDURE INSERTAR_DESTINATION (
        title VARCHAR2,
        description CLOB,
        start_date DATE,
        end_date DATE,
        spaces NUMBER,
        guide NUMBER,
        price NUMBER,
        imagen BLOB
    ) AS
    BEGIN
        INSERT INTO DESTINATIONS (TITLE, DESCRIPTION, START_DATE, END_DATE, SPACES, GUIDE, PRICE, IMAGEN)
        VALUES (title, description, start_date, end_date, spaces, guide, price, imagen);
        COMMIT;
    END INSERTAR_DESTINATION;
    
    -- Procedure para modificar una destinaci�n por su ID
    PROCEDURE MODIFICAR_DESTINATION (
        id_destination NUMBER,
        title VARCHAR2,
        description CLOB,
        start_date DATE,
        end_date DATE,
        spaces NUMBER,
        guide NUMBER,
        price NUMBER,
        imagen BLOB
    ) AS
    BEGIN
        UPDATE DESTINATIONS
        SET TITLE = title, DESCRIPTION = description, START_DATE = start_date, END_DATE = end_date,
            SPACES = spaces, GUIDE = guide, PRICE = price, IMAGEN = imagen
        WHERE ID_DESTINATION = id_destination;
        COMMIT;
    END MODIFICAR_DESTINATION;
    
    -- Procedure para eliminar una destinaci�n por su ID
    PROCEDURE ELIMINAR_DESTINATION (
        id_destination NUMBER
    ) AS
    BEGIN
        DELETE FROM DESTINATIONS
        WHERE ID_DESTINATION = id_destination;
        COMMIT;
    END ELIMINAR_DESTINATION;
    
    -- Procedure para ver todas las destinaciones
    PROCEDURE VER_TODOS_DESTINATIONS (
        p_cursor OUT SYS_REFCURSOR
    ) AS
    BEGIN
        OPEN p_cursor FOR
        SELECT * FROM DESTINATIONS;
    END VER_TODOS_DESTINATIONS;
    -- Procedure para ver la info de una destinaci�n con la gu�a
    PROCEDURE VER_DESTINATION_GUIDE (
        id_destination NUMBER,
        p_cursor OUT SYS_REFCURSOR
    ) AS
    BEGIN
        OPEN p_cursor FOR
        SELECT D.TITLE, D.DESCRIPTION, G.NAME AS GUIDE_NAME
        FROM DESTINATIONS D
        INNER JOIN GUIDES G ON D.GUIDE = G.ID_GUIDE
        WHERE D.ID_DESTINATION = id_destination;
    END VER_DESTINATION_GUIDE;
END PAQUETE_DESTINATIONS;


---PAQUETE TRIP ***************************************************************************
CREATE OR REPLACE PACKAGE PAQUETE_TRIP AS
    -- Procedure para insertar un viaje
    PROCEDURE INSERTAR_TRIP (
        id_user NUMBER,
        id_destination NUMBER,
        buy_date DATE
    );
    
    -- Procedure para modificar un viaje por su ID
    PROCEDURE MODIFICAR_TRIP (
        id_trip NUMBER,
        id_user NUMBER,
        id_destination NUMBER,
        buy_date DATE
    );

    -- Procedure para eliminar un viaje por su ID
    PROCEDURE ELIMINAR_TRIP (
        id_trip NUMBER
    );
    
    -- Procedure para ver todos los viajes
    PROCEDURE VER_TODOS_TRIPS (
        p_cursor OUT SYS_REFCURSOR
    );
    
    -- Procedure para ver los detalles de un viaje por su ID
    PROCEDURE VER_DATALLES_TRIP (
        id_trip NUMBER,
        p_cursor OUT SYS_REFCURSOR
    );
END PAQUETE_TRIP;
/

CREATE OR REPLACE PACKAGE BODY PAQUETE_TRIP AS
    -- Procedure para insertar un viaje
    PROCEDURE INSERTAR_TRIP (
        id_user NUMBER,
        id_destination NUMBER,
        buy_date DATE
    ) AS
    BEGIN
        INSERT INTO TRIP (ID_USER, ID_DESTINATION, BUY_DATE)
        VALUES (id_user, id_destination, buy_date);
        COMMIT;
    END INSERTAR_TRIP;
    
    -- Procedure para modificar un viaje por su ID
    PROCEDURE MODIFICAR_TRIP (
        id_trip NUMBER,
        id_user NUMBER,
        id_destination NUMBER,
        buy_date DATE
    ) AS
    BEGIN
        UPDATE TRIP
        SET ID_USER = id_user, ID_DESTINATION = id_destination, BUY_DATE = buy_date
        WHERE ID_TRIP = id_trip;
        COMMIT;
    END MODIFICAR_TRIP;
    
    -- Procedure para eliminar un viaje por su ID
    PROCEDURE ELIMINAR_TRIP (
        id_trip NUMBER
    ) AS
    BEGIN
        DELETE FROM TRIP
        WHERE ID_TRIP = id_trip;
        COMMIT;
    END ELIMINAR_TRIP;
    
    -- Procedure para ver todos los viajes
    PROCEDURE VER_TODOS_TRIPS (
        p_cursor OUT SYS_REFCURSOR
    ) AS
    BEGIN
        OPEN p_cursor FOR
        SELECT * FROM TRIP;
    END VER_TODOS_TRIPS;
    
    -- Procedure para ver los detalles de un viaje por su ID
    PROCEDURE VER_DATALLES_TRIP (
        id_trip NUMBER,
        p_cursor OUT SYS_REFCURSOR
    ) AS
    BEGIN
        OPEN p_cursor FOR
        SELECT T.ID_TRIP, U.NAME AS USER_NAME, D.TITLE AS DESTINATION_TITLE, T.BUY_DATE
        FROM TRIP T
        INNER JOIN USERS U ON T.ID_USER = U.ID_USER
        INNER JOIN DESTINATIONS D ON T.ID_DESTINATION = D.ID_DESTINATION
        WHERE T.ID_TRIP = id_trip;
    END VER_DATALLES_TRIP;
END PAQUETE_TRIP;

---PAQUETE DE FUNCIONES 1 ***************************************************************************
CREATE OR REPLACE PACKAGE PAQUETE_FUNCIONES_1 AS
    -- Funci�n para obtener el nombre completo de un usuario
    FUNCTION NOMBRE_COMPLETO_USUARIO(id_user NUMBER) RETURN VARCHAR2;
    
    -- Funci�n para calcular el total de costos de todos los servicios
    FUNCTION CALCULAR_TOTAL_COSTOS_SERVICIOS RETURN NUMBER;
    
    -- Funci�n para obtener la cantidad de espacios disponibles en una destinaci�n
    FUNCTION ESPACIOS_DISPONIBLES(id_destination NUMBER) RETURN NUMBER;
    
    -- Funci�n para obtener la cantidad de viajes realizados por un usuario
    FUNCTION CANTIDAD_VIAJES_USUARIO(id_user NUMBER) RETURN NUMBER;
    
END PAQUETE_FUNCIONES_1;


CREATE OR REPLACE PACKAGE BODY PAQUETE_FUNCIONES_1 AS
    -- Funci�n para obtener el nombre completo de un usuario
    FUNCTION NOMBRE_COMPLETO_USUARIO(id_user NUMBER) RETURN VARCHAR2 AS
        nombre_completo VARCHAR2(100);
    BEGIN
        SELECT NAME || ' ' || LAST_NAME INTO nombre_completo
        FROM USERS
        WHERE ID_USER = id_user;
        RETURN nombre_completo;
    END NOMBRE_COMPLETO_USUARIO;
    
    -- Funci�n para calcular el total de costos de todos los servicios
    FUNCTION CALCULAR_TOTAL_COSTOS_SERVICIOS RETURN NUMBER AS
        costo_total NUMBER := 0;
    BEGIN
        SELECT SUM(COST) INTO costo_total
        FROM SERVICES;
        RETURN costo_total;
    END CALCULAR_TOTAL_COSTOS_SERVICIOS;
    
    -- Funci�n para obtener la cantidad de espacios disponibles en una destinaci�n
    FUNCTION ESPACIOS_DISPONIBLES(id_destination NUMBER) RETURN NUMBER AS
        espacios_disponibles NUMBER := 0;
    BEGIN
        SELECT SPACES INTO espacios_disponibles
        FROM DESTINATIONS
        WHERE ID_DESTINATION = id_destination;
        RETURN espacios_disponibles;
    END ESPACIOS_DISPONIBLES;
    
    -- Funci�n para obtener la cantidad de viajes realizados por un usuario
    FUNCTION CANTIDAD_VIAJES_USUARIO(id_user NUMBER) RETURN NUMBER AS
        contador_viajes NUMBER := 0;
    BEGIN
        SELECT COUNT(*) INTO contador_viajes
        FROM TRIP
        WHERE ID_USER = id_user;
        RETURN contador_viajes;
    END CANTIDAD_VIAJES_USUARIO;
    
END PAQUETE_FUNCIONES_1;

---PAQUETE DE FUNCIONES 2 ***************************************************************************
CREATE OR REPLACE PACKAGE PAQUETE_FUNCIONES_2 AS
    -- Funci�n para obtener el estado de un usuario
    FUNCTION ESTADO_USUARIO(id_user NUMBER) RETURN VARCHAR2;
    
    -- Funci�n para obtener la descripci�n de un rol
    FUNCTION DESCRIPCION_ROL(id_rol NUMBER) RETURN VARCHAR2;
    
    -- Funci�n para obtener el costo promedio de los servicios
    FUNCTION COSTO_PROMEDIO_SERVICIOS RETURN NUMBER;
    
    -- Funci�n para verificar si una destinaci�n tiene espacios disponibles
    FUNCTION ESPACIOS_DISPONIBLES(id_destination NUMBER) RETURN BOOLEAN;
    
    -- Funci�n para obtener la cantidad de rese�as de un usuario
    FUNCTION CANTIDAD_RESE�AS_POR_USUARIO(id_user NUMBER) RETURN NUMBER;
    
END PAQUETE_FUNCIONES_2;


CREATE OR REPLACE PACKAGE BODY PAQUETE_FUNCIONES_2 AS
    -- Funci�n para obtener el estado de un usuario
    FUNCTION ESTADO_USUARIO(id_user NUMBER) RETURN VARCHAR2 AS
        descripcion_estado VARCHAR2(50);
    BEGIN
        SELECT DESCRIPCION INTO descripcion_estado
        FROM STATUS
        WHERE ID_STATUS = (SELECT STATUS FROM USERS WHERE ID_USER = id_user);
        RETURN descripcion_estado;
    END ESTADO_USUARIO;
    
    -- Funci�n para obtener la descripci�n de un rol
    FUNCTION DESCRIPCION_ROL(id_rol NUMBER) RETURN VARCHAR2 AS
        rol_description VARCHAR2(50);
    BEGIN
        SELECT DESCRIPCION INTO rol_description
        FROM ROLES
        WHERE ID_ROLES = id_rol;
        RETURN rol_description;
    END DESCRIPCION_ROL;
    
    -- Funci�n para obtener el costo promedio de los servicios
    FUNCTION COSTO_PROMEDIO_SERVICIOS RETURN NUMBER AS
        costo_prom NUMBER;
    BEGIN
        SELECT AVG(COST) INTO costo_prom
        FROM SERVICES;
        RETURN costo_prom;
    END COSTO_PROMEDIO_SERVICIOS;
    
    -- Funci�n para verificar si una destinaci�n tiene espacios disponibles
    FUNCTION ESPACIOS_DISPONIBLES(id_destination NUMBER) RETURN BOOLEAN AS
        espacios_disponibles NUMBER;
    BEGIN
        SELECT SPACES INTO espacios_disponibles
        FROM DESTINATIONS
        WHERE ID_DESTINATION = id_destination;
        RETURN espacios_disponibles > 0;
    END ESPACIOS_DISPONIBLES;
    
    -- Funci�n para obtener la cantidad de rese�as de un usuario
    FUNCTION CANTIDAD_RESE�AS_POR_USUARIO(id_user NUMBER) RETURN NUMBER AS
        contador_rese�as NUMBER;
    BEGIN
        SELECT COUNT(*) INTO contador_rese�as
        FROM REVIEW
        WHERE ID_USER = id_user;
        RETURN contador_rese�as;
    END CANTIDAD_RESE�AS_POR_USUARIO;
    
END PAQUETE_FUNCIONES_2;

---PAQUETE DE FUNCIONES cursores ***************************************************************************
CREATE OR REPLACE PACKAGE PAQUETE_CURSORES AS
    -- Tipo de cursor para usuarios
    TYPE cursor_usuario IS REF CURSOR;
    
    -- Tipo de cursor para servicios
    TYPE cursor_servicio IS REF CURSOR;
    
    -- Procedimiento para mostrar todos los usuarios usando un cursor expl�cito
    PROCEDURE CURSOR_USUARIOS(p_cursor OUT cursor_usuario);
    
    -- Procedimiento para mostrar todos los servicios con costo menor a un valor
    PROCEDURE CURSOR_SERVICIO_COSTO_ID(cost_limit NUMBER, p_cursor OUT cursor_servicio);
    
    -- Procedimiento para mostrar los usuarios que tienen un estado espec�fico
    PROCEDURE CURSOR_STATUS_ID(status_id NUMBER, p_cursor OUT cursor_usuario);
    
    -- Procedimiento para mostrar todos los servicios con descripci�n que contiene un t�rmino
    PROCEDURE CURSOR_SERVICIOS_DESCRIPCION(term VARCHAR2, p_cursor OUT cursor_servicio);
END PAQUETE_CURSORES;


CREATE OR REPLACE PACKAGE BODY PAQUETE_CURSORES AS
    -- Procedimiento para mostrar todos los usuarios usando un cursor expl�cito
    PROCEDURE CURSOR_USUARIOS(p_cursor OUT cursor_usuario) AS
    BEGIN
        OPEN p_cursor FOR
        SELECT * FROM USERS;
    END CURSOR_USUARIOS;
    
    -- Procedimiento para mostrar todos los servicios con costo menor a un valor
    PROCEDURE CURSOR_SERVICIO_COSTO_ID(cost_limit NUMBER, p_cursor OUT cursor_servicio) AS
    BEGIN
        OPEN p_cursor FOR
        SELECT * FROM SERVICES
        WHERE COST < cost_limit;
    END CURSOR_SERVICIO_COSTO_ID;
    
    -- Procedimiento para mostrar los usuarios que tienen un estado espec�fico
    PROCEDURE CURSOR_STATUS_ID(status_id NUMBER, p_cursor OUT cursor_usuario) AS
    BEGIN
        OPEN p_cursor FOR
        SELECT * FROM USERS
        WHERE STATUS = status_id;
    END CURSOR_STATUS_ID;
    
    -- Procedimiento para mostrar todos los servicios con descripci�n que contiene un t�rmino
    PROCEDURE CURSOR_SERVICIOS_DESCRIPCION(term VARCHAR2, p_cursor OUT cursor_servicio) AS
    BEGIN
        OPEN p_cursor FOR
        SELECT * FROM SERVICES
        WHERE UPPER(DESCRIPTION) LIKE '%' || UPPER(term) || '%';
    END CURSOR_SERVICIOS_DESCRIPCION;
END PAQUETE_CURSORES;



CREATE TABLE DESTINATION_AUDIT (
    AUDIT_ID NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY,
    DESTINATION_ID NUMBER,
    OLD_PRICE NUMBER,
    NEW_PRICE NUMBER,
    CHANGE_DATE DATE,
    CONSTRAINT DESTINATION_AUDIT_PK PRIMARY KEY (AUDIT_ID),
    CONSTRAINT FK_DESTINATION_AUDIT_DESTINATION_ID FOREIGN KEY (DESTINATION_ID) REFERENCES DESTINATIONS (ID_DESTINATION)
);

CREATE OR REPLACE TRIGGER DESTINATION_PRICE_AUDIT
AFTER UPDATE OF PRICE ON DESTINATIONS
FOR EACH ROW
BEGIN
    -- Verificar si el precio ha cambiado
    IF :OLD.PRICE != :NEW.PRICE THEN
        INSERT INTO DESTINATION_AUDIT (DESTINATION_ID, OLD_PRICE, NEW_PRICE, CHANGE_DATE)
        VALUES (:NEW.ID_DESTINATION, :OLD.PRICE, :NEW.PRICE, SYSDATE);
    END IF;
END;

CREATE TABLE DESTINATION_DELETE_AUDIT (
    AUDIT_ID NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY,
    DESTINATION_ID NUMBER,
    TITLE VARCHAR2(100),
    DESCRIPTION VARCHAR2(4000),
    START_DATE DATE,
    END_DATE DATE,
    PRICE NUMBER,
    EVENT_TYPE VARCHAR2(50),
    EVENT_DATE DATE,
    CONSTRAINT DESTINATION_DELETE_AUDIT_PK PRIMARY KEY (AUDIT_ID),
    CONSTRAINT FK_DESTINATION_DELETE_AUDIT_DESTINATION_ID FOREIGN KEY (DESTINATION_ID) REFERENCES DESTINATIONS (ID_DESTINATION)
);

CREATE OR REPLACE TRIGGER DESTINATION_DELETE_AUDIT_TRIGGER
AFTER DELETE ON DESTINATIONS
FOR EACH ROW
BEGIN
    INSERT INTO DESTINATION_DELETE_AUDIT (DESTINATION_ID, TITLE, DESCRIPTION, START_DATE, END_DATE, PRICE, EVENT_TYPE, EVENT_DATE)
    VALUES (:OLD.ID_DESTINATION, :OLD.TITLE, :OLD.DESCRIPTION, :OLD.START_DATE, :OLD.END_DATE, :OLD.PRICE, 'Eliminación', SYSDATE);
END;


CREATE TABLE GUIDE_AUDIT (
    AUDIT_ID NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY,
    GUIDE_ID NUMBER,
    EVENT_TYPE VARCHAR2(50),
    EVENT_DATE DATE,
    CONSTRAINT GUIDE_AUDIT_PK PRIMARY KEY (AUDIT_ID),
    CONSTRAINT FK_GUIDE_AUDIT_GUIDE_ID FOREIGN KEY (GUIDE_ID) REFERENCES GUIDES (ID_GUIDE)
);


CREATE OR REPLACE TRIGGER GUIDE_AUDIT_TRIGGER
AFTER UPDATE OR DELETE ON GUIDES
FOR EACH ROW
BEGIN
    IF UPDATING THEN
        INSERT INTO GUIDE_AUDIT (GUIDE_ID, EVENT_TYPE, EVENT_DATE)
        VALUES (:OLD.ID_GUIDE, 'Actualización', SYSDATE);
    ELSE
        INSERT INTO GUIDE_AUDIT (GUIDE_ID, EVENT_TYPE, EVENT_DATE)
        VALUES (:OLD.ID_GUIDE, 'Eliminación', SYSDATE);
    END IF;
END;



















