DELIMITER //

CREATE PROCEDURE RegistrarDireccion (
    IN DPI_cliente BIGINT,
    IN direccion VARCHAR(100),
    IN municipio VARCHAR(50),
    IN zona INT
)
BEGIN
    DECLARE cliente_existente INT;
    
    -- Validar que el cliente exista
    SELECT COUNT(*) INTO cliente_existente FROM Clientes WHERE dpi_cliente  = DPI_cliente;
    
    IF cliente_existente = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El cliente no existe en la base de datos';
    ELSE
        -- Insertar la nueva dirección
        INSERT INTO Direcciones (direccion, municipio, zona, dpi_cliente)
        VALUES (direccion, municipio, zona, DPI_cliente);
        
        SELECT LAST_INSERT_ID() AS id_direccion;
    END IF;
END //

DELIMITER ;