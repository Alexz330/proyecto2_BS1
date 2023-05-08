DELIMITER //
CREATE PROCEDURE FinalizarOrden(IN p_id_orden INT)
BEGIN
    DECLARE v_estado_actual VARCHAR(20);
    DECLARE v_fecha_entrega_actual DATETIME;
    DECLARE v_fecha_actual DATETIME;
    
    -- Validar que la orden exista y su estado sea "EN CAMINO"
    SELECT estado, fecha_entrega INTO v_estado_actual, v_fecha_entrega_actual
    FROM Orden
    WHERE id_orden = p_id_orden;
    
    IF v_estado_actual IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La orden no existe';
    END IF;
    
    IF v_estado_actual != 'EN CAMINO' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La orden no se puede finalizar porque su estado no es "EN CAMINO"';
    END IF;
    
    -- Actualizar el estado de la orden y su fecha de entrega
    SET v_fecha_actual = NOW();
    UPDATE Orden
    SET estado = 'ENTREGADA', fecha_entrega = v_fecha_actual
    WHERE id_orden = p_id_orden;
    
    SELECT CONCAT('La orden ', p_id_orden, ' ha sido finalizada con éxito') AS mensaje;
END //
DELIMITER ;