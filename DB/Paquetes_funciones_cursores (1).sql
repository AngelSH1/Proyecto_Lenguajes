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
    -- Procedure para insertar una destinación
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
    
    -- Procedure para modificar una destinación por su ID
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

    -- Procedure para eliminar una destinación por su ID
    PROCEDURE ELIMINAR_DESTINATION (
        id_destination NUMBER
    );
    
    -- Procedure para ver todas las destinaciones
    PROCEDURE VER_TODOS_DESTINATIONS (
        p_cursor OUT SYS_REFCURSOR
    );
        -- Procedure para ver la info de una destinación con EL GUIA
    PROCEDURE VER_DESTINATION_GUIDE (
        id_destination NUMBER,
        p_cursor OUT SYS_REFCURSOR
    );
END PAQUETE_DESTINATIONS;


CREATE OR REPLACE PACKAGE BODY PAQUETE_DESTINATIONS AS
    -- Procedure para insertar una destinación
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
    
    -- Procedure para modificar una destinación por su ID
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
    
    -- Procedure para eliminar una destinación por su ID
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
    -- Procedure para ver la info de una destinación con la guía
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
    -- Función para obtener el nombre completo de un usuario
    FUNCTION NOMBRE_COMPLETO_USUARIO(id_user NUMBER) RETURN VARCHAR2;
    
    -- Función para calcular el total de costos de todos los servicios
    FUNCTION CALCULAR_TOTAL_COSTOS_SERVICIOS RETURN NUMBER;
    
    -- Función para obtener la cantidad de espacios disponibles en una destinación
    FUNCTION ESPACIOS_DISPONIBLES(id_destination NUMBER) RETURN NUMBER;
    
    -- Función para obtener la cantidad de viajes realizados por un usuario
    FUNCTION CANTIDAD_VIAJES_USUARIO(id_user NUMBER) RETURN NUMBER;
    
END PAQUETE_FUNCIONES_1;


CREATE OR REPLACE PACKAGE BODY PAQUETE_FUNCIONES_1 AS
    -- Función para obtener el nombre completo de un usuario
    FUNCTION NOMBRE_COMPLETO_USUARIO(id_user NUMBER) RETURN VARCHAR2 AS
        nombre_completo VARCHAR2(100);
    BEGIN
        SELECT NAME || ' ' || LAST_NAME INTO nombre_completo
        FROM USERS
        WHERE ID_USER = id_user;
        RETURN nombre_completo;
    END NOMBRE_COMPLETO_USUARIO;
    
    -- Función para calcular el total de costos de todos los servicios
    FUNCTION CALCULAR_TOTAL_COSTOS_SERVICIOS RETURN NUMBER AS
        costo_total NUMBER := 0;
    BEGIN
        SELECT SUM(COST) INTO costo_total
        FROM SERVICES;
        RETURN costo_total;
    END CALCULAR_TOTAL_COSTOS_SERVICIOS;
    
    -- Función para obtener la cantidad de espacios disponibles en una destinación
    FUNCTION ESPACIOS_DISPONIBLES(id_destination NUMBER) RETURN NUMBER AS
        espacios_disponibles NUMBER := 0;
    BEGIN
        SELECT SPACES INTO espacios_disponibles
        FROM DESTINATIONS
        WHERE ID_DESTINATION = id_destination;
        RETURN espacios_disponibles;
    END ESPACIOS_DISPONIBLES;
    
    -- Función para obtener la cantidad de viajes realizados por un usuario
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
    -- Función para obtener el estado de un usuario
    FUNCTION ESTADO_USUARIO(id_user NUMBER) RETURN VARCHAR2;
    
    -- Función para obtener la descripción de un rol
    FUNCTION DESCRIPCION_ROL(id_rol NUMBER) RETURN VARCHAR2;
    
    -- Función para obtener el costo promedio de los servicios
    FUNCTION COSTO_PROMEDIO_SERVICIOS RETURN NUMBER;
    
    -- Función para verificar si una destinación tiene espacios disponibles
    FUNCTION ESPACIOS_DISPONIBLES(id_destination NUMBER) RETURN BOOLEAN;
    
    -- Función para obtener la cantidad de reseñas de un usuario
    FUNCTION CANTIDAD_RESEÑAS_POR_USUARIO(id_user NUMBER) RETURN NUMBER;
    
END PAQUETE_FUNCIONES_2;


CREATE OR REPLACE PACKAGE BODY PAQUETE_FUNCIONES_2 AS
    -- Función para obtener el estado de un usuario
    FUNCTION ESTADO_USUARIO(id_user NUMBER) RETURN VARCHAR2 AS
        descripcion_estado VARCHAR2(50);
    BEGIN
        SELECT DESCRIPCION INTO descripcion_estado
        FROM STATUS
        WHERE ID_STATUS = (SELECT STATUS FROM USERS WHERE ID_USER = id_user);
        RETURN descripcion_estado;
    END ESTADO_USUARIO;
    
    -- Función para obtener la descripción de un rol
    FUNCTION DESCRIPCION_ROL(id_rol NUMBER) RETURN VARCHAR2 AS
        rol_description VARCHAR2(50);
    BEGIN
        SELECT DESCRIPCION INTO rol_description
        FROM ROLES
        WHERE ID_ROLES = id_rol;
        RETURN rol_description;
    END DESCRIPCION_ROL;
    
    -- Función para obtener el costo promedio de los servicios
    FUNCTION COSTO_PROMEDIO_SERVICIOS RETURN NUMBER AS
        costo_prom NUMBER;
    BEGIN
        SELECT AVG(COST) INTO costo_prom
        FROM SERVICES;
        RETURN costo_prom;
    END COSTO_PROMEDIO_SERVICIOS;
    
    -- Función para verificar si una destinación tiene espacios disponibles
    FUNCTION ESPACIOS_DISPONIBLES(id_destination NUMBER) RETURN BOOLEAN AS
        espacios_disponibles NUMBER;
    BEGIN
        SELECT SPACES INTO espacios_disponibles
        FROM DESTINATIONS
        WHERE ID_DESTINATION = id_destination;
        RETURN espacios_disponibles > 0;
    END ESPACIOS_DISPONIBLES;
    
    -- Función para obtener la cantidad de reseñas de un usuario
    FUNCTION CANTIDAD_RESEÑAS_POR_USUARIO(id_user NUMBER) RETURN NUMBER AS
        contador_reseñas NUMBER;
    BEGIN
        SELECT COUNT(*) INTO contador_reseñas
        FROM REVIEW
        WHERE ID_USER = id_user;
        RETURN contador_reseñas;
    END CANTIDAD_RESEÑAS_POR_USUARIO;
    
END PAQUETE_FUNCIONES_2;

---PAQUETE DE FUNCIONES cursores ***************************************************************************
CREATE OR REPLACE PACKAGE PAQUETE_CURSORES AS
    -- Tipo de cursor para usuarios
    TYPE cursor_usuario IS REF CURSOR;
    
    -- Tipo de cursor para servicios
    TYPE cursor_servicio IS REF CURSOR;
    
    -- Procedimiento para mostrar todos los usuarios usando un cursor explícito
    PROCEDURE CURSOR_USUARIOS(p_cursor OUT cursor_usuario);
    
    -- Procedimiento para mostrar todos los servicios con costo menor a un valor
    PROCEDURE CURSOR_SERVICIO_COSTO_ID(cost_limit NUMBER, p_cursor OUT cursor_servicio);
    
    -- Procedimiento para mostrar los usuarios que tienen un estado específico
    PROCEDURE CURSOR_STATUS_ID(status_id NUMBER, p_cursor OUT cursor_usuario);
    
    -- Procedimiento para mostrar todos los servicios con descripción que contiene un término
    PROCEDURE CURSOR_SERVICIOS_DESCRIPCION(term VARCHAR2, p_cursor OUT cursor_servicio);
END PAQUETE_CURSORES;


CREATE OR REPLACE PACKAGE BODY PAQUETE_CURSORES AS
    -- Procedimiento para mostrar todos los usuarios usando un cursor explícito
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
    
    -- Procedimiento para mostrar los usuarios que tienen un estado específico
    PROCEDURE CURSOR_STATUS_ID(status_id NUMBER, p_cursor OUT cursor_usuario) AS
    BEGIN
        OPEN p_cursor FOR
        SELECT * FROM USERS
        WHERE STATUS = status_id;
    END CURSOR_STATUS_ID;
    
    -- Procedimiento para mostrar todos los servicios con descripción que contiene un término
    PROCEDURE CURSOR_SERVICIOS_DESCRIPCION(term VARCHAR2, p_cursor OUT cursor_servicio) AS
    BEGIN
        OPEN p_cursor FOR
        SELECT * FROM SERVICES
        WHERE UPPER(DESCRIPTION) LIKE '%' || UPPER(term) || '%';
    END CURSOR_SERVICIOS_DESCRIPCION;
END PAQUETE_CURSORES;








