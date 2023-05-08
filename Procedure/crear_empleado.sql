DELIMITER //
CREATE PROCEDURE CrearEmpleado (
    IN Nombres VARCHAR(50),
    IN Apellidos VARCHAR(50),
    IN FechaNacimiento DATE,
    IN Correo VARCHAR(50),
    IN Telefono BIGINT,
    IN Direccion VARCHAR(100),
    IN NumeroDPI BIGINT,
    IN FechaInicio DATE,

    IN Puesto INT,
    IN id_restaurante VARCHAR(50)
)
BEGIN
    DECLARE id_empleado INT DEFAULT 0;
    DECLARE correo_valido BOOLEAN DEFAULT FALSE;

    -- Validar formato de correo electrónico
    IF Correo REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$' THEN
        SET correo_valido = TRUE;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El formato del correo electrónico es inválido';
    END IF;
    SET id_empleado = LAST_INSERT_ID();

    -- Insertar registro en la tabla Empleado
    INSERT INTO Empleados (id_empleado,Nombres, Apellidos, fecha_nacimiento, Correo, Telefono, Direccion, num_dpi, id_puesto, fecha_inicio, id_restaurante) 
    VALUES (LPAD(id_empleado, 8, '0'),Nombres, Apellidos, FechaNacimiento, Correo, Telefono, Direccion, NumeroDPI, Puesto, FechaInicio, id_restaurante);

    -- Obtener el ID del último registro insertado
    SET id_empleado = LAST_INSERT_ID();

    -- Actualizar el campo id_empleado con el identificador generado
    -- UPDATE Empleados SET id_empleado = LPAD(id_empleado, 8, '0') WHERE id_empleado IS NULL AND id_restaurante = id_restaurante;

END //

DELIMITER ;
