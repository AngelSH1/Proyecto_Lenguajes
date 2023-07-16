----INSERT STATUS
INSERT INTO STATUS VALUES(1, 'ACTIVE');
INSERT INTO STATUS VALUES(2, 'INACTIVE');
INSERT INTO STATUS VALUES(3, 'PENDING');


----INSERT ROLES
INSERT INTO ROLES VALUES(1, 'ADMIN');
INSERT INTO ROLES VALUES(2, 'USER');

----ISERT USERS
INSERT INTO USERS (NAME, LAST_NAME, EMAIL, PHONE, ROL, PASSWORD, STATUS)
VALUES('JOSHUA','MELENDEZ','JOSHUA33657@GMAIL.COM','+50672550428',1,'12345',1);

INSERT INTO USERS (NAME, LAST_NAME, EMAIL, PHONE, ROL, PASSWORD, STATUS)
VALUES ('John', 'Doe', 'john.doe@example.com', '+123456789', 1, 'password123', 1);

INSERT INTO USERS (NAME, LAST_NAME, EMAIL, PHONE, ROL, PASSWORD, STATUS)
VALUES ('Jane', 'Smith', 'jane.smith@example.com', '+987654321', 2, 'pass4321', 1);

INSERT INTO USERS (NAME, LAST_NAME, EMAIL, PHONE, ROL, PASSWORD, STATUS)
VALUES ('Michael', 'Johnson', 'michael.johnson@example.com', '+111111111', 2, 'testpass', 2);

INSERT INTO USERS (NAME, LAST_NAME, EMAIL, PHONE, ROL, PASSWORD, STATUS)
VALUES ('Emily', 'Anderson', 'emily.anderson@example.com', '+222222222', 2, '12345678', 3);


----INSERT SERVICES

INSERT INTO SERVICES VALUES(
1,'VISA AMERICANA',
'Este servicio incluye: 
-Asesoramiento personalizado para llenar el formulario de la visa. 
-Busqueda de la cita mas cercana para el proceso. 
-Busqueda continua en la pagina de la embajada para un posible adelantamiento de la cita. 
-Revision de documentos a presentar',20);


INSERT INTO SERVICES VALUES(2,
'ETA CANADIENSE',
'Este servicio incluye: 
-Asesoramiento personalizado para llenar el formulario de la ETA.',5);

INSERT INTO SERVICES VALUES(
3,'VIAJES PERSONALIZADOS',
'Este servicio incluye: 
-Asesoramiento para elegir un destino basado en tus necesidades.
-Busqueda de las mejores opciones disponibles de vuelos.
-Asesoramiento para actividades a realizar, entradas y tickets necesarios.
-Informacion relevante con respecto a requisitos de ingreso al destino.
-Apoyo para la compra de seguro medico.',100);


----INSERT STATUS SOLICITUD
INSERT INTO STATUS_SOLICITUD VALUES(1, 'PENDING');
INSERT INTO STATUS_SOLICITUD VALUES(2, 'COMPLETED');


----INSERT SOLICITUDES DE CONTACTO
INSERT INTO CONTACT (EMAIL, PHONE, NAME, LAST_NAME,STATUS_CONTACT, DATE_REGIS, SERVICES)
VALUES ('EMAIL_EXAMPLE@EMAIL1.COM', '+50670118975', 'John', 'Doe',1, SYSDATE, 2);


INSERT INTO CONTACT (EMAIL, PHONE, NAME, LAST_NAME, STATUS_CONTACT, DATE_REGIS, SERVICES)
VALUES ('example1@email.com', '+1234567890', 'Jane', 'Smith', 1, SYSDATE, 1);


INSERT INTO CONTACT (EMAIL, PHONE, NAME, LAST_NAME, STATUS_CONTACT, DATE_REGIS, SERVICES)
VALUES ('example2@email.com', '+9876543210', 'Michael', 'Johnson', 1, SYSDATE, 3);


INSERT INTO CONTACT (EMAIL, PHONE, NAME, LAST_NAME, STATUS_CONTACT, DATE_REGIS, SERVICES)
VALUES ('example3@email.com', '+1111111111', 'Emily', 'Anderson', 1, SYSDATE, 2);


INSERT INTO CONTACT (EMAIL, PHONE, NAME, LAST_NAME, STATUS_CONTACT, DATE_REGIS, SERVICES)
VALUES ('example4@email.com', '+2222222222', 'William', 'Brown', 1, SYSDATE, 1);


INSERT INTO CONTACT (EMAIL, PHONE, NAME, LAST_NAME, STATUS_CONTACT, DATE_REGIS, SERVICES)
VALUES ('example5@email.com', '+3333333333', 'Sophia', 'Johnson', 1, SYSDATE, 3);


----INSERT DESTINATIONS



INSERT INTO DESTINATIONS (TITLE, DESCRIPTION, START_DATE, END_DATE, SPACES, GUIDE, PRICE, IMAGEN)
VALUES ('Travesía Europea', 'Embárcate en un emocionante viaje a través de los tesoros de Europa. Visita la majestuosa Torre Eiffel en Francia, pasea por los canales de Ámsterdam en los Países Bajos, explora las ruinas del Coliseo en Italia y disfruta de la cálida hospitalidad en Grecia.', TO_DATE('2023-08-10', 'YYYY-MM-DD'), TO_DATE('2023-08-30', 'YYYY-MM-DD'), 100, 1, 5000, EMPTY_BLOB());


INSERT INTO DESTINATIONS (TITLE, DESCRIPTION, START_DATE, END_DATE, SPACES, GUIDE, PRICE, IMAGEN)
VALUES ('Sudamérica Salvaje', 'Descubre la diversidad de Sudamérica en este fascinante viaje. Explora la selva amazónica en Brasil, camina por los senderos de Machu Picchu en Perú, conoce la cultura ancestral de los incas en Bolivia y disfruta del tango y la rica historia en Argentina.', TO_DATE('2023-09-05', 'YYYY-MM-DD'), TO_DATE('2023-09-25', 'YYYY-MM-DD'), 80, 2, 4500, EMPTY_BLOB());


INSERT INTO DESTINATIONS (TITLE, DESCRIPTION, START_DATE, END_DATE, SPACES, GUIDE, PRICE, IMAGEN)
VALUES ('Misterios de Asia Oriental', 'Sumérgete en la magia de Asia Oriental en este increíble recorrido. Admira la belleza tradicional de Kioto en Japón, recorre la Gran Muralla China, maravíllate con la modernidad de Seúl en Corea del Sur y relájate en los jardines zen de Suzhou en China.', TO_DATE('2023-10-15', 'YYYY-MM-DD'), TO_DATE('2023-10-30', 'YYYY-MM-DD'), 60, 3, 4200, EMPTY_BLOB());


INSERT INTO DESTINATIONS (TITLE, DESCRIPTION, START_DATE, END_DATE, SPACES, GUIDE, PRICE, IMAGEN)
VALUES ('África: Culturas y Tradiciones', 'Sumérgete en la rica diversidad cultural de África. Descubre los vibrantes mercados de Marruecos, admira las pirámides de Egipto, conoce la historia de Sudáfrica y experimenta la hospitalidad de Ghana.', TO_DATE('2023-11-10', 'YYYY-MM-DD'), TO_DATE('2023-11-25', 'YYYY-MM-DD'), 50, 4, 4800, EMPTY_BLOB());


INSERT INTO DESTINATIONS (TITLE, DESCRIPTION, START_DATE, END_DATE, SPACES, GUIDE, PRICE, IMAGEN)
VALUES ('Asia y el Pacífico en Esencia', 'Explora la esencia de Asia y el Pacífico en este mágico viaje. Sumérgete en la espiritualidad de Tailandia, disfruta del paraíso tropical en Bali, maravíllate con los rascacielos de Singapur y conoce las tradiciones maoríes en Nueva Zelanda.', TO_DATE('2023-12-05', 'YYYY-MM-DD'), TO_DATE('2023-12-20', 'YYYY-MM-DD'), 70, 5, 3800, EMPTY_BLOB());


----INSERT GUIAS
INSERT INTO GUIDES (NAME, LAST_NAME, EXPERIENCE)
VALUES ('Juan', 'Pérez', 5);

INSERT INTO GUIDES (NAME, LAST_NAME, EXPERIENCE)
VALUES ('María', 'Gómez', 8);

INSERT INTO GUIDES (NAME, LAST_NAME, EXPERIENCE)
VALUES ('Carlos', 'López', 3);

INSERT INTO GUIDES (NAME, LAST_NAME, EXPERIENCE)
VALUES ('Ana', 'Ramírez', 6);

INSERT INTO GUIDES (NAME, LAST_NAME, EXPERIENCE)
VALUES ('Pedro', 'Martínez', 4);


----INSERT IDIOMAS
INSERT INTO IDIOMAS (ID_IDIOMAS, DESCRIPTION)
VALUES (1, 'Español');

INSERT INTO IDIOMAS (ID_IDIOMAS, DESCRIPTION)
VALUES (2, 'Inglés');

INSERT INTO IDIOMAS (ID_IDIOMAS, DESCRIPTION)
VALUES (3, 'Francés');

INSERT INTO IDIOMAS (ID_IDIOMAS, DESCRIPTION)
VALUES (4, 'Alemán');

INSERT INTO IDIOMAS (ID_IDIOMAS, DESCRIPTION)
VALUES (5, 'Italiano');


----INSERT TRIPS

INSERT INTO TRIP (ID_USER, ID_DESTINATION, BUY_DATE)
VALUES (1, 6, SYSDATE);


INSERT INTO TRIP (ID_USER, ID_DESTINATION, BUY_DATE)
VALUES (21, 7, SYSDATE);

INSERT INTO TRIP (ID_USER, ID_DESTINATION, BUY_DATE)
VALUES (22, 8, SYSDATE);


INSERT INTO TRIP (ID_USER, ID_DESTINATION, BUY_DATE)
VALUES (23, 9, SYSDATE);


INSERT INTO TRIP (ID_USER, ID_DESTINATION, BUY_DATE)
VALUES (24, 10, SYSDATE);

---- INSERT REVIEWS
INSERT INTO REVIEW (ID_USER, TITLE, DESCRIPTION, CALIF, DATE_REVIEW)
VALUES (1, 'Excelente experiencia', 'El viaje fue increíble, disfrutamos de paisajes espectaculares y un guía muy amable y conocedor. Recomiendo este destino a todos los viajeros.', 5, SYSDATE);


INSERT INTO REVIEW (ID_USER, TITLE, DESCRIPTION, CALIF, DATE_REVIEW)
VALUES (21, 'Muy buen servicio', 'El paquete de viaje cubrió todas nuestras expectativas. Los hoteles y la comida fueron geniales. Sin duda, volveríamos a viajar con esta agencia.', 4, SYSDATE);


INSERT INTO REVIEW (ID_USER, TITLE, DESCRIPTION, CALIF, DATE_REVIEW)
VALUES (22, 'Una experiencia única', 'Este viaje superó todas nuestras expectativas. La atención recibida por el guía y el equipo fue excepcional. Gracias por esta increíble experiencia.', 5, SYSDATE);


INSERT INTO REVIEW (ID_USER, TITLE, DESCRIPTION, CALIF, DATE_REVIEW)
VALUES (23, 'Buen viaje', 'El paquete de viaje fue bastante bueno en general, aunque hubo algunos problemas menores con la logística. Sin embargo, disfrutamos del destino y la cultura.', 3, SYSDATE);


INSERT INTO REVIEW (ID_USER, TITLE, DESCRIPTION, CALIF, DATE_REVIEW)
VALUES (24, 'Vacaciones inolvidables', 'Este viaje fue una experiencia inolvidable. Los destinos visitados fueron increíbles y el guía hizo que cada día fuera especial. Muy recomendado.', 5, SYSDATE);

----INSERT BLOG ENTRY

INSERT INTO BLOG_ENTRY (TITLE, DESCRIPTION, ID_USER, ID_DESTINATION, IMAGE1)
VALUES ('Increíbles Aventuras en África', 'Comparto mis experiencias de viaje por África, visitando las reservas naturales más emblemáticas del continente y conociendo la vida salvaje en su esplendor. Desde los emocionantes safaris en Serengeti hasta los majestuosos paisajes del Delta del Okavango, cada día fue una experiencia inolvidable. También descubrí las ricas culturas y tradiciones de las tribus locales, sumergiéndome en sus danzas y celebraciones. África es un destino que captura el corazón y el alma de cada viajero aventurero.', 1, 6, EMPTY_BLOB());


INSERT INTO BLOG_ENTRY (TITLE, DESCRIPTION, ID_USER, ID_DESTINATION, IMAGE1)
VALUES ('Un Recorrido por Europa', '¡Europa es un continente lleno de historia y belleza! Durante mi viaje, recorrí ciudades icónicas como París, Roma, Barcelona y Praga, quedando maravillado por sus majestuosas arquitecturas, museos y deliciosa gastronomía. Paseé por las románticas calles de Venecia y disfruté del arte en el Louvre. Además, me sumergí en la rica historia de Atenas y contemplé la hermosa puesta de sol desde Santorini. Europa tiene algo especial para cada tipo de viajero, desde amantes de la historia y la cultura hasta entusiastas de la comida y la moda.', 1, 7, EMPTY_BLOB());


INSERT INTO BLOG_ENTRY (TITLE, DESCRIPTION, ID_USER, ID_DESTINATION, IMAGE1)
VALUES ('Maravillas de Asia Oriental', 'Mi aventura por Asia Oriental me llevó a explorar la fascinante cultura de Japón y China. En Japón, experimenté la tradicional ceremonia del té, contemplé los hermosos cerezos en flor en primavera y maravillé con la modernidad de Tokio. En China, caminé sobre la Gran Muralla, visité los majestuosos Guerreros de Terracota y me perdí en los hermosos jardines de Suzhou. Cada lugar que visité tenía su encanto único y me dejó con recuerdos inolvidables.', 1, 8, EMPTY_BLOB());


INSERT INTO BLOG_ENTRY (TITLE, DESCRIPTION, ID_USER, ID_DESTINATION, IMAGE1)
VALUES ('Aventuras en Sudamérica', 'Recorrer Sudamérica fue una experiencia llena de aventura y diversidad. En la selva amazónica, me sumergí en un mundo lleno de vida silvestre y plantas exóticas. Descubrí la rica historia de los incas en Machu Picchu, contemplé los altos picos de los Andes y probé deliciosos platos locales en Perú. En Brasil, disfruté del vibrante carnaval en Río de Janeiro y me maravillé con las impresionantes Cataratas del Iguazú. Sudamérica es un paraíso para los amantes de la naturaleza y la cultura.', 1, 9, EMPTY_BLOB());


INSERT INTO BLOG_ENTRY (TITLE, DESCRIPTION, ID_USER, ID_DESTINATION, IMAGE1)
VALUES ('Islas Exóticas del Pacífico', 'Explorar las islas exóticas del Pacífico fue como sumergirme en un auténtico paraíso. Desde las playas de arena blanca y las aguas cristalinas de Bora Bora hasta la cultura rica y ancestral de Samoa, cada isla tenía su propia belleza única. Nadé con tortugas marinas en las Islas Galápagos, me relajé en las cálidas playas de Fiji y aprendí sobre la cultura maorí en Nueva Zelanda. Cada día me sorprendía con la asombrosa belleza y la calidez de la gente local. ¡Estas islas son el sueño de todo viajero!', 1, 10, EMPTY_BLOB());



----INSERT IDIAOMAS X GUIA


INSERT INTO IDIOMASXGUIDE (ID_GUIDE, ID_IDIOMAS)
VALUES (1, 1);

INSERT INTO IDIOMASXGUIDE (ID_GUIDE, ID_IDIOMAS)
VALUES (1, 2);


INSERT INTO IDIOMASXGUIDE (ID_GUIDE, ID_IDIOMAS)
VALUES (2, 2);

INSERT INTO IDIOMASXGUIDE (ID_GUIDE, ID_IDIOMAS)
VALUES (2, 3);


INSERT INTO IDIOMASXGUIDE (ID_GUIDE, ID_IDIOMAS)
VALUES (3, 1);

INSERT INTO IDIOMASXGUIDE (ID_GUIDE, ID_IDIOMAS)
VALUES (3, 3);

INSERT INTO IDIOMASXGUIDE (ID_GUIDE, ID_IDIOMAS)
VALUES (4, 2);

INSERT INTO IDIOMASXGUIDE (ID_GUIDE, ID_IDIOMAS)
VALUES (4, 4);


INSERT INTO IDIOMASXGUIDE (ID_GUIDE, ID_IDIOMAS)
VALUES (5, 1);

INSERT INTO IDIOMASXGUIDE (ID_GUIDE, ID_IDIOMAS)
VALUES (5, 5);
