/* Clean up Roles_Permissions */
DELETE FROM `Roles_Permissions`;

/* Cleanup Roles table */
DELETE from `Roles`;

/* Clean up* Permissions */

/* Install Roles */
INSERT INTO `Roles` (`role_id`,`name`,`description`) VALUES (1,'Admin','Administrador del sistema. Acceso universal');
INSERT INTO `Roles` (`role_id`,`name`,`description`) VALUES (2,'Contestant','Concursante común, usuario principal de omegaup');
INSERT INTO `Roles` (`role_id`,`name`,`description`) VALUES (3,'Judge','Juez de concursos. Encargados de crear problemas y responder preguntas sobre los problemas');
INSERT INTO `Roles` (`role_id`,`name`,`description`) VALUES (4,'Visitor','Usuario no loggeado a omegaup');






/* Install Roles_Permissions*/

/* Admin permissions */
INSERT INTO `Roles_Permissions` (`role_id`,`permission_id`) VALUES (1,1);
INSERT INTO `Roles_Permissions` (`role_id`,`permission_id`) VALUES (1,2);
INSERT INTO `Roles_Permissions` (`role_id`,`permission_id`) VALUES (1,3);
INSERT INTO `Roles_Permissions` (`role_id`,`permission_id`) VALUES (1,4);
INSERT INTO `Roles_Permissions` (`role_id`,`permission_id`) VALUES (1,5);
INSERT INTO `Roles_Permissions` (`role_id`,`permission_id`) VALUES (1,6);
INSERT INTO `Roles_Permissions` (`role_id`,`permission_id`) VALUES (1,7);
INSERT INTO `Roles_Permissions` (`role_id`,`permission_id`) VALUES (1,8);
INSERT INTO `Roles_Permissions` (`role_id`,`permission_id`) VALUES (1,9);
INSERT INTO `Roles_Permissions` (`role_id`,`permission_id`) VALUES (1,10);
INSERT INTO `Roles_Permissions` (`role_id`,`permission_id`) VALUES (1,11);
INSERT INTO `Roles_Permissions` (`role_id`,`permission_id`) VALUES (1,12);
INSERT INTO `Roles_Permissions` (`role_id`,`permission_id`) VALUES (1,13);
INSERT INTO `Roles_Permissions` (`role_id`,`permission_id`) VALUES (1,14);
INSERT INTO `Roles_Permissions` (`role_id`,`permission_id`) VALUES (1,15);
INSERT INTO `Roles_Permissions` (`role_id`,`permission_id`) VALUES (1,16);
INSERT INTO `Roles_Permissions` (`role_id`,`permission_id`) VALUES (1,17);

/* Contestant Permissions */

INSERT INTO `Roles_Permissions` (`role_id`,`permission_id`) VALUES (2,1);
INSERT INTO `Roles_Permissions` (`role_id`,`permission_id`) VALUES (2,3);
INSERT INTO `Roles_Permissions` (`role_id`,`permission_id`) VALUES (2,4);
INSERT INTO `Roles_Permissions` (`role_id`,`permission_id`) VALUES (2,5);
INSERT INTO `Roles_Permissions` (`role_id`,`permission_id`) VALUES (2,7);
INSERT INTO `Roles_Permissions` (`role_id`,`permission_id`) VALUES (2,8);
INSERT INTO `Roles_Permissions` (`role_id`,`permission_id`) VALUES (2,10);
INSERT INTO `Roles_Permissions` (`role_id`,`permission_id`) VALUES (2,11);
INSERT INTO `Roles_Permissions` (`role_id`,`permission_id`) VALUES (2,12);
INSERT INTO `Roles_Permissions` (`role_id`,`permission_id`) VALUES (2,13);
INSERT INTO `Roles_Permissions` (`role_id`,`permission_id`) VALUES (2,15);
INSERT INTO `Roles_Permissions` (`role_id`,`permission_id`) VALUES (2,16);
INSERT INTO `Roles_Permissions` (`role_id`,`permission_id`) VALUES (2,17);

/* Judge permissions */

INSERT INTO `Roles_Permissions` (`role_id`,`permission_id`) VALUES (3,1);
INSERT INTO `Roles_Permissions` (`role_id`,`permission_id`) VALUES (3,3);
INSERT INTO `Roles_Permissions` (`role_id`,`permission_id`) VALUES (3,4);
INSERT INTO `Roles_Permissions` (`role_id`,`permission_id`) VALUES (3,5);
INSERT INTO `Roles_Permissions` (`role_id`,`permission_id`) VALUES (3,6);
INSERT INTO `Roles_Permissions` (`role_id`,`permission_id`) VALUES (3,7);
INSERT INTO `Roles_Permissions` (`role_id`,`permission_id`) VALUES (3,8);
INSERT INTO `Roles_Permissions` (`role_id`,`permission_id`) VALUES (3,9);
INSERT INTO `Roles_Permissions` (`role_id`,`permission_id`) VALUES (3,10);
INSERT INTO `Roles_Permissions` (`role_id`,`permission_id`) VALUES (3,11);
INSERT INTO `Roles_Permissions` (`role_id`,`permission_id`) VALUES (3,12);
INSERT INTO `Roles_Permissions` (`role_id`,`permission_id`) VALUES (3,13);
INSERT INTO `Roles_Permissions` (`role_id`,`permission_id`) VALUES (3,14);
INSERT INTO `Roles_Permissions` (`role_id`,`permission_id`) VALUES (3,15);
INSERT INTO `Roles_Permissions` (`role_id`,`permission_id`) VALUES (3,16);
INSERT INTO `Roles_Permissions` (`role_id`,`permission_id`) VALUES (3,17);

/* Visitor permisions */
INSERT INTO `Roles_Permissions` (`role_id`,`permission_id`) VALUES (4,1);
INSERT INTO `Roles_Permissions` (`role_id`,`permission_id`) VALUES (4,4);
INSERT INTO `Roles_Permissions` (`role_id`,`permission_id`) VALUES (4,15);
INSERT INTO `Roles_Permissions` (`role_id`,`permission_id`) VALUES (4,16);
INSERT INTO `Roles_Permissions` (`role_id`,`permission_id`) VALUES (4,17);