/* Limpieza previa */
DROP SCHEMA IF EXISTS distribuidora;
DROP USER IF EXISTS 'usuario_final'@'%';
DROP USER IF EXISTS 'usuario_administrador'@'%';

CREATE SCHEMA distribuidora;
USE distribuidora;

/* Creación de usuarios */
CREATE USER 'usuario_final'@'%' IDENTIFIED BY 'Usuar1o_Clave.';
CREATE USER 'usuario_administrador'@'%' IDENTIFIED BY 'Usuar1o_administrador.';

/* Asignación de privilegios */
GRANT ALL PRIVILEGES ON distribuidora.* TO 'usuario_final'@'%';
GRANT SELECT ON distribuidora.* TO 'usuario_administrador'@'%';
FLUSH PRIVILEGES;

/* Tabla categoría */
CREATE TABLE categoria (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(255) NOT NULL,
    activo BOOLEAN DEFAULT TRUE,
    ruta_imagen VARCHAR(255)
);

/* Tabla recetas */
CREATE TABLE recetas (
    id_recetas BIGINT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(255) NOT NULL,
    ruta_imagen VARCHAR(255),
    activo BOOLEAN DEFAULT TRUE
);

/* Tabla producto */
CREATE TABLE producto (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    id_categoria INT,
    descripcion VARCHAR(255) NOT NULL,
    detalle TEXT,
    precio DECIMAL(10,2),
    existencias INT,
    ruta_imagen TEXT,
    activo BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria)
);

/* Tabla usuario */
CREATE TABLE usuario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) UNIQUE NOT NULL,
    telefono VARCHAR(20),
    direccion TEXT,
    contrasena VARCHAR(255) NOT NULL,
    rol ENUM('CLIENTE', 'ADMIN') DEFAULT 'CLIENTE',
    activo BOOLEAN DEFAULT TRUE
);

/* Tabla carrito */
CREATE TABLE carrito (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    id_producto INT,
    cantidad INT,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id),
    FOREIGN KEY (id_producto) REFERENCES producto(id)
);

/* Tabla pedidos */
CREATE TABLE pedidos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(10,2),
    estado ENUM('PENDIENTE', 'APROBADO', 'RECHAZADO') DEFAULT 'PENDIENTE',
    FOREIGN KEY (id_usuario) REFERENCES usuario(id)
);

/* Tabla detalle_pedido */
CREATE TABLE detalle_pedido (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT,
    id_producto INT,
    cantidad INT,
    precio_unitario DECIMAL(10,2),
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id),
    FOREIGN KEY (id_producto) REFERENCES producto(id)
);

/* Tabla rol y usuario_rol */
CREATE TABLE rol (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE usuario_rol (
    usuario_id INT,
    rol_id BIGINT,
    PRIMARY KEY (usuario_id, rol_id),
    FOREIGN KEY (usuario_id) REFERENCES usuario(id),
    FOREIGN KEY (rol_id) REFERENCES rol(id)
);

/* Inserciones de datos */
-- Categorías
INSERT INTO categoria (descripcion, activo, ruta_imagen) VALUES 
('Huevos', true, 'https://uvn-brightspot.s3.amazonaws.com/assets/vixes/btg/curiosidades.batanga.com/files/por-que-los-huevos-tienen-forma-de-huevo.jpg'),
('Res, Pollo y Cerdo', true, 'https://aluminiomonarca.mx/cdn/shop/articles/Tiempos-de-coccion-de-carnes_1100x.jpg?v=1663189099'),
('Lacteos', true, 'https://merkocash.es/wp-content/uploads/2023/05/cuantos-lacteos-hay-que-tomar-al-dia.png'),
('Verduras y Frutas', true, 'https://www.hola.com/horizon/original_aspect_ratio/6f180fee6f49-frutas-verduras-a.jpg');

-- Recetas
INSERT INTO recetas (descripcion, activo, ruta_imagen) VALUES
('Costillas Especiales', true, 'https://www.recetasnestle.com.ve/sites/default/files/srh_recipes/4993650ea97c3556791bc0a114e32568.jpg'),
('Fajitas Isabel', true, 'https://villacocina.com/wp-content/uploads/2023/01/Chicken-and-steak-fajitas-WEBSITE-scaled.jpg'),
('Pinchos', true, 'https://gypsyplate.com/wp-content/uploads/2023/03/pinchos-de-pollo_square.jpg'),
('Filet Premium', true,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS4tpB_dN3GRBsoCeq5y1rI_ykp7IYb02cWKg&s'),
('Chifrijos', true,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-vcN9eewjpcIVPFdhjQ6m0JvboQ3jYDscyA&s'),
('Tamales', true,'https://preview.redd.it/mejores-tamales-de-costa-rica-v0-9uy0444fwn8c1.jpeg?auto=webp&s=f29311593785c6f52b7c57ef29c8e0471e22df0a');

-- Usuarios (¡OJO! evita repetir IDs)
INSERT INTO usuario (nombre, correo, telefono, direccion, contrasena, rol, activo) VALUES 
('maye', 'maye@gmail.com','8787-1212', 'Uruca', '$2a$10$P1.w58XvnaYQUQgZUCk4aO/RTRl8EValluCqB3S2VMLTbRt.tlre.', 'CLIENTE', true),
('mariana', 'mariana@gmail.com','8484-1111', 'Cartago', '$2a$10$GkEj.ZzmQa/aEfDmtLIh3udIH5fMphx/35d0EYeqZL5uzgCJ0lQRi', 'ADMIN', true);


INSERT INTO producto (id_producto, id_categoria, descripcion, detalle, precio, existencias, ruta_imagen, activo) VALUES
(1, 4,'Lechuga','Lechuga fresca, ideal para una ensalada', 500, 20, 'https://www.frutas-hortalizas.com/img/fruites_verdures/presentacio/53.jpg', true ),
(2, 4,'Banano','Bananos perfectos para un batido', 50, 100,'https://images.squarespace-cdn.com/content/v1/59bc6b2d29f1875d21620187/1682599976365-QQZEE299LWA6OLNCCE72/Banano.png?format=1500w', true),
(3, 4,'Tomate','Tomates maduros, para ensaladas o salsas', 1000, 100, 'https://definicion.de/wp-content/uploads/2015/01/tomate-1.jpg', true),
(4, 4,'Papaya','Papayas maduras y listas para comer', 600, 10, 'https://www.gob.mx/cms/uploads/article/main_image/78604/papaya.jpg', true),
(5, 4,'Manzanas','Manzanas ricas y jugosas para la lonchera de sus hijos', 300, 100, 'https://www.finedininglovers.com/es/sites/g/files/xknfdk1706/files/2022-10/tipos-de-manzanas%C2%A9iStock.jpg', true),
(6, 4,'Fresas','Fresas rojas y frescas para acompañar su Yogurt', 2000, 50, 'https://www.finedininglovers.com/es/sites/g/files/xknfdk1706/files/styles/article_1200_800_fallback/public/2022-04/fresas%C2%A9iStock.jpg?itok=iBcd_HLd', true),
(7, 4,'Uvas','Uvas verdes y moradas son un rico snack', 1500, 50, 'https://www.semana.com/resizer/v2/NYSRETWNJ5APLFMKK7ZRMKXKCM.jpg?auth=375c491aec74a2da5b888e511fe0fa0d739d12548bf472cab2289c9562eeae3c&smart=true&quality=75&width=1280&height=720', true),
(8, 4,'Aguacate','Aguacates para acompañar tus comidas o ensaladas', 500, 100, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSGuHb4thrqBnKjXY9EFzs_w0nhviJjwgk-zw&s', true),
(9, 4,'Brocoli','Brocolis perfectos para acompañar tus comidas', 1000, 20, 'https://mejorconsalud.as.com/wp-content/uploads/2015/06/brocoli-ramas.jpg', true),
(10, 4,'Pepino','Listos para ser cortados y acompañar sus comidas', 200, 30, 'https://www.finedininglovers.com/es/sites/g/files/xknfdk1706/files/styles/article_1200_800_fallback/public/2022-06/Type%20of%20cucumber.jpg?itok=WEuXomjV', true),
(11, 4,'Arandanos','Perfectos para ser parte de sus ensaladas de frutas', 2000, 50, 'https://cloudfront-us-east-1.images.arcpublishing.com/infobae/LSIIK3VKRVFWRF5JUQG4VYAEBU.jpg', true),
(12, 4,'Papas','Listas para ser fritas o hervidas', 150, 100, 'https://saborusa.com.pa/imagesmg/imagenes/5ff3e6a0b703f_potatoes-food-supermarket-agriculture-JG7QGNY.jpg', true),
(13, 3,'Queso Turrialba','Fresco y perfecto para acompañar su desayuno', 2500, 25, 'https://upload.wikimedia.org/wikipedia/commons/8/8a/Queso_turrialba_crc.jpg', true),
(14, 3,'Natilla Casera','Con sal y listas para acompañar su pinto o chorreadas', 1000, 50, 'https://travelfoodcr.weebly.com/uploads/6/7/4/3/67436053/7482834.jpg?319', true),
(15, 3,'Queso Palmito','Ideal para disfrutar solo o con lo que guste', 3500, 20, 'https://sabellicocr.club/wp-content/uploads/2021/05/IMG-20210526-WA0030-e1622135733294.jpg', true),
(16, 3,'Latocrema','Perfecta para sus tostadas', 1225, 30, 'https://d31f1ehqijlcua.cloudfront.net/n/f/c/c/1/fcc1c5b5753565b907433e345fe81545f12e332c_286984_01.JPG', true);
(17, 3,'Mantequilla','Lista para cocinar', 1550, 30, 'https://www.latercera.com/resizer/v2/7BAPS26WYFCQ7NTZFCDQPDKLHQ.jpg?auth=1773e16befdc9912ad03f57a63d93a81da255f039424c5c381af8576a7224c80&height=675&width=990&smart=true', true),
(18, 3,'Leche','Lista para sus desayunos y batidos', 1325, 50, 'https://www.trainerclub.es/wp-content/uploads/12.jpg', true),
(19, 3,'Leche Descremada','Sin lactosa, para su preferencia', 1350, 30, 'https://walmartcr.vtexassets.com/arquivos/ids/723261/4315_01.jpg?v=638629892074130000', true),
(20, 3,'Queso Crema','Para sus tostadas o recetas', 1500, 30, 'https://walmartcr.vtexassets.com/arquivos/ids/411781/Queso-Crema-Marca-Dos-Pinos-Original-350g-6-33808.jpg?v=638219434540700000', true),
(21, 3,'Yogurt','Listos para acompañar su granola', 1000, 20, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSye-VG4Zp__01ICNIYAzBppC4K-NCOH31jVA&s', true),
(22, 3,'Queso Mozzarella','Perfecto para pastas', 1800, 30, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSd4VgRa3NRCDowK3rk0tr3MkkH3Rm_2qLklQ&s', true),
(23, 3,'Queso Parmesano','Listo para ponerle a su pizza', 2000, 20, 'https://gourmetdemexico.com.mx/wp-content/uploads/2024/07/tipos-de-queso-parmesano-3.jpg', true),
(24, 3,'Fresco Leche Fresa','Para su desayuno o para la escuela', 585, 100, 'https://info.megasuper.com/ecommerce/7441001628351_1.jpeg', true),
(25, 2,'Pechuga sin Hueso','Frescas, para una pechuga a la plancha',2000, 40'https://d31f1ehqijlcua.cloudfront.net/n/3/d/5/8/3d583e792b91fb79425bf7212861ac724563e4b7_Poultry_475622_01.jpg', true),
(26, 2,'Pollo Entero','Fresco ylisto para sus almuerzos', 4000, 50, 'https://jumbo.com.do/pub/media/catalog/product/cache/5d91a1aa0232de6a069aae492eab5701/2/2/2209812-A_1.jpg', true),
(27, 2,'Fajitas de Pollo','Listas para ser empanizados', 2500, 40, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQusSgAsw3T9F4fe3iz88mtCX_IDqGflmL8lw&s', true),
(28, 2,'Alas de Pollo','Perfectas para ser bañadas en BBQ', 3000, 60, 'https://campollo.com/wp-content/uploads/2023/06/ala.jpg', true),
(29, 2,'Costilla de Cerdo','Lo mejor para los asados en familia', 4500, 50, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRRoU-Jcxs_m5oAN2szQtt_-sa-41hKu_wO0w&s', true),
(30, 2,'Posta de Cerdo','Lo mejor para tus cenas con amigos', 3500, 50, 'https://www.carnesdonfernando.com/wp-content/uploads/2023/11/POSTA-CERDO-DF-CORTES-WEB-2023.jpg', true),
(31, 2,'Lomo de Cerdo','Corte magro y suave, ideal para hornear o a la parrilla', 3900, 45, 'https://www.carnesdonfernando.com/wp-content/uploads/2023/11/LOMO-CERDO-DF-CORTES-WEB-2023.jpg', true),
(32, 2,'Chuleta de Cerdo','Perfectas para asar con hueso, llenas de sabor', 3700, 40, 'https://okdiario.com/img/recetas/2017/07/25/chuletas-de-cerdo-4.jpg', true),
(33, 2,'Bistec de Res','Corte clásico para una comida rápida y deliciosa', 4200, 35, 'https://www.carnesdonfernando.com/wp-content/uploads/2023/09/BISTEC-VUELTA-RES-DF-CORTES-WEB-2023.jpg', true),
(34, 2,'Carne Molida','Versátil para pastas, tacos, albóndigas y más', 3600, 60, 'https://info.megasuper.com/ecommerce/06515_1.jpeg', true),
(35, 2,'Mano de Piedra','Corte especial con hueso, ideal para sopas y caldos', 3100, 25, 'https://www.carnesdonfernando.com/wp-content/uploads/2023/11/MANO-PIEDRA-RES-DF-CORTES-WEB-2023.jpg', true),
(36, 2,'Costillas de Res','Jugosas costillas ideales para barbacoa', 4600, 30, 'https://www.carnesdonfernando.com/wp-content/uploads/2023/11/TIRA-ASADO-RES-DF-CORTES-WEB-2023.jpg', true),
(37, 1,'Cartón de Huevos','Cartón con 30 unidades, frescos del día', 2850, 100, 'https://movalle.cr/wp-content/uploads/2020/03/Huevos.jpg', true),
(38, 1,'Medio Cartón de Huevos','Perfecto para hogares pequeños, 15 unidades', 1450, 80, 'https://santamonica.tienda/wp-content/uploads/2022/05/Huevos-EL-Tunal-15-Und_-.webp', true),
(39, 1,'Cartón de 6 Huevos','Ideal para uso individual o en recetas', 650, 60, 'https://media.istockphoto.com/id/514786680/es/foto/seis-huevos.jpg?s=612x612&w=0&k=20&c=XJCOG6YqfXO6NDGFD-GYckecatfNgCRb8NgCwIxAGOQ=', true),
(40, 1,'Huevos por Unidad','Compra exacta según tus necesidades, por unidad', 120, 300, 'https://uvn-brightspot.s3.amazonaws.com/assets/vixes/btg/curiosidades.batanga.com/files/por-que-los-huevos-tienen-forma-de-huevo.jpg', true),
(41, 1,'Huevos Blancos','Cartón de huevos blancos, calidad garantizada', 2950, 90, 'https://isla360shop.com/wp-content/uploads/2023/01/carton_de_huevos_isla360shop.jpg', true);

INSERT INTO rol (nombre) VALUES 
('CLIENTE'),
('ADMIN');

INSERT INTO usuario_rol (usuario_id, rol_id) VALUES
(1, 1), -- Maye como CLIENTE
(2, 2); -- Mariana como ADMIN

-- Maye (usuario_id = 1) agrega productos al carrito
INSERT INTO carrito (id_usuario, id_producto, cantidad) VALUES
(1, 1, 2),  -- Lechuga
(1, 13, 1), -- Queso Turrialba
(1, 24, 3); -- Fresco leche fresa

-- Pedido realizado por Maye
INSERT INTO pedidos (id_usuario, total, estado) VALUES
(1, 5825.00, 'APROBADO');

-- Asumimos que ese pedido fue el ID 1
INSERT INTO detalle_pedido (id_pedido, id_producto, cantidad, precio_unitario) VALUES
(1, 1, 2, 500.00),   -- Lechuga
(1, 13, 1, 2500.00), -- Queso Turrialba
(1, 24, 3, 585.00);  -- Fresco leche fresa
