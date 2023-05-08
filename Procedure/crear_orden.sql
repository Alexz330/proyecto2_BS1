DELIMITER //

CREATE PROCEDURE CrearOrden (
    IN p_dpi_cliente BIGINT,
    IN p_id_direccion_cliente INT,
    IN p_canal CHAR(1)
)
BEGIN
    DECLARE v_municipio_cliente VARCHAR(50);
    DECLARE v_direccion_cliente VARCHAR(200);
    DECLARE v_zona_cliente INT;
    DECLARE v_id_restaurante_c VARCHAR(200);
    

    IF p_canal NOT IN ('L', 'A') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El canal debe ser L (línea) o A (aplicación)';
    END IF;
    -- Validar que el cliente existe
    IF NOT EXISTS (SELECT * FROM Clientes WHERE dpi_cliente = p_dpi_cliente) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El cliente no existe';
    END IF;
    
    -- Obtener la dirección del cliente
    SELECT direccion, municipio, zona INTO v_direccion_cliente, v_municipio_cliente, v_zona_cliente
    FROM Direcciones
    WHERE id_direccion = p_id_direccion_cliente AND dpi_cliente = p_dpi_cliente;
    
    -- Validar que la dirección pertenece al cliente
    IF v_direccion_cliente IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La dirección no pertenece al cliente';
    END IF;
    
    -- Validar que hay cobertura en la zona del cliente
    SELECT id_restaurante INTO v_id_restaurante_c
    FROM Restaurantes
    WHERE municipio = v_municipio_cliente AND zona = v_zona_cliente;
    
    IF v_id_restaurante_c IS NULL THEN
        -- No hay cobertura en la zona del cliente
        INSERT INTO Orden (canal,estado,dpi_cliente,id_direccion,id_empleado,id_restaurante,fecha_entrega)
        VALUES (p_canal,'SIN COBERTURA',p_dpi_cliente,p_id_direccion_cliente,NULL,v_id_restaurante_c,NULL);
        SELECT LAST_INSERT_ID() AS id_orden;
    ELSE
        -- Hay cobertura en la zona del cliente
        INSERT INTO Orden(canal,estado,dpi_cliente,id_direccion,id_empleado,id_restaurante,fecha_entrega)
        VALUES (p_canal,'INICIADA',p_dpi_cliente,p_id_direccion_cliente,NULL,v_id_restaurante_c,NULL);
        SELECT LAST_INSERT_ID() AS id_orden;
    END IF;
END //

DELIMITER ;