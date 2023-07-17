CREATE OR REPLACE PROCEDURE RegistrarUsuario (pNombre in VARCHAR2,pApellido IN  VARCHAR2, pCorreo IN VARCHAR2, pTelefono IN  VARCHAR2, pContrasenna IN  VARCHAR2)
as BEGIN

INSERT INTO USERS(NAME, LAST_NAME, EMAIL, PHONE, ROL, PASSWORD, STATUS)
VALUES (pNombre, pApellido, pCorreo, pTelefono,1, pContrasenna,1);

END;

