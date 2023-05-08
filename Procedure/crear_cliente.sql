DELIMITER //
CREATE PROCEDURE RegistrarCliente (
    IN p_dpi BIGINT,
    IN p_nombre VARCHAR(50),
    IN p_apellidos VARCHAR(50),
    IN p_fecha_nacimiento DATE,
    IN p_correo VARCHAR(50),
    IN p_telefono BIGINT,
    IN p_nit BIGINT
)
BEGIN
    DECLARE v_count INT;
    SELECT COUNT(*) INTO v_count FROM Clientes WHERE dpi_cliente = p_dpi;
    IF (p_Correo NOT REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Correo inválido';
    END IF;
    
    IF v_count > 0 THEN
        SELECT 'Error: El cliente ya existe.' AS mensaje;
    ELSE
        INSERT INTO Clientes (dpi_cliente, nombre, apellido, fecha_nacimiento, correo, telefono, nit)
        VALUES (p_dpi, p_nombre, p_apellidos, p_fecha_nacimiento, p_correo, p_telefono, p_nit);
        SELECT 'Cliente registrado correctamente.' AS mensaje;
    END IF;
END //

DELIMITER ;