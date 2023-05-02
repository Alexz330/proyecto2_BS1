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


