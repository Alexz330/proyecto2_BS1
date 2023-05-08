DELIMITER //
CREATE PROCEDURE ConsultarDirecciones(IN p_DPI_cliente BIGINT)
BEGIN
    DECLARE v_num_registros INT DEFAULT 0;
    SELECT COUNT(*) INTO v_num_registros FROM Clientes WHERE dpi_cliente = p_DPI_cliente;
    
    IF v_num_registros = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El DPI del cliente no existe';
    ELSE
       SELECT direccion,municipio,zona FROM `Direcciones` WHERE dpi_cliente = p_DPI_cliente;

    END IF;
END //

DELIMITER ;