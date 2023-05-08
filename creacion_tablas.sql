-- Creacion de la tabla restaurante 
CREATE TABLE Restaurantes (
    id_restaurante VARCHAR(50) PRIMARY KEY,
    direccion VARCHAR(255) NOT NULL,
    municipio VARCHAR(50) NOT NULL,
    zona INT UNSIGNED NOT NULL,
    telefono BIGINT UNSIGNED NOT NULL,
    personal_maximo INT UNSIGNED NOT NULL,
    tiene_parqueo BOOLEAN NOT NULL
);

-- Creacion de la tabla de puestos

CREATE TABLE PuestosDeTrabajo (
    id_puesto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(200),
    salario DECIMAL(10, 2) NOT NULL CHECK (salario >= 0)
);


-- Creacion de la tabla empleados
CREATE TABLE Empleados (
  id_empleado INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombres VARCHAR(50) NOT NULL,
  apellidos VARCHAR(50) NOT NULL,
  fecha_nacimiento DATE NOT NULL,
  correo VARCHAR(50) NOT NULL,
  telefono BIGINT UNSIGNED NOT NULL,
  direccion VARCHAR(100) NOT NULL,
  num_dpi BIGINT UNSIGNED NOT NULL,
  id_puesto INT  NOT NULL,
  fecha_inicio DATE NOT NULL,
  id_restaurante VARCHAR(50) NOT NULL,
  FOREIGN KEY (id_puesto) REFERENCES PuestosDeTrabajo(id_puesto),
  FOREIGN KEY (id_restaurante) REFERENCES Restaurantes(id_restaurante)
);


;

CREATE TABLE Clientes (
  dpi_cliente BIGINT PRIMARY KEY,
  nombre VARCHAR(50),
  apellido VARCHAR(50),
  fecha_nacimiento DATE,
  correo VARCHAR(50),
  telefono BIGINT,
  nit BIGINT
);


CREATE TABLE Direcciones (
  id_direccion INT NOT NULL AUTO_INCREMENT,
  direccion VARCHAR(100) NOT NULL,
  municipio VARCHAR(50) NOT NULL,
  zona VARCHAR(50) NOT NULL,
  dpi_cliente BIGINT NOT NULL,
  PRIMARY KEY (id_direccion),
  FOREIGN KEY (dpi_cliente) REFERENCES Clientes(dpi_cliente)
);


CREATE TABLE Menu (
  id_menu INT NOT NULL AUTO_INCREMENT,
  producto VARCHAR(50) NOT NULL,
  precio DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (id_menu)
);

CREATE TABLE Orden (
  id_orden INT NOT NULL AUTO_INCREMENT,
  canal CHAR(1) NOT NULL,
  estado VARCHAR(20) NOT NULL,
  dpi_cliente bigint(20) NOT NULL,
  id_direccion INT NOT NULL,
  id_empleado INT UNSIGNED,
  id_restaurante VARCHAR(50) NOT NULL,
  fecha_inicio DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  fecha_entrega DATETIME,
    
  PRIMARY KEY (id_orden),
    
  FOREIGN KEY (dpi_cliente) REFERENCES Clientes(dpi_cliente),
  FOREIGN KEY (id_direccion) REFERENCES Direcciones(id_direccion),
  FOREIGN KEY (id_empleado) REFERENCES Empleados(id_empleado),
  FOREIGN KEY (id_restaurante) REFERENCES Restaurantes(id_restaurante)
);


CREATE TABLE DetalleOrden (
  id_detalleOrden INT NOT NULL AUTO_INCREMENT,
  id_orden INT NOT NULL,
  tipo_producto CHAR(1) NOT NULL,
  producto INT NOT NULL,
  id_menu INT,
  cantidad INT NOT NULL,
 	precio_unitario DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (id_detalleOrden),
  FOREIGN KEY (id_orden) REFERENCES Orden (id_orden),
  FOREIGN KEY (id_menu) REFERENCES Menu (id_menu)
);


CREATE TABLE Facturas (
  id_factura INT NOT NULL AUTO_INCREMENT,
  id_orden INT NOT NULL,
  no_serie INT NOT NULL,
  monto_total DECIMAL(10,2) NOT NULL,
  lugar VARCHAR(100) NOT NULL,
  fecha_actual DATE NOT NULL,
  nit_cliente INT NOT NULL,
  tipo_pago CHAR(1) NOT NULL,
  PRIMARY KEY (id_factura),
  FOREIGN KEY (id_orden) REFERENCES orden(id_orden)
);