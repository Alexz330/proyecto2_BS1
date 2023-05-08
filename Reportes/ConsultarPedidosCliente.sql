DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `ConsultarPedidosCliente`(IN p_IdOrden INT)
BEGIN
    DECLARE v_Estado VARCHAR(50);
    
    SELECT estado INTO v_Estado
    FROM Orden
    WHERE id_orden = p_IdOrden;
    
    IF v_Estado IS NULL THEN
        SIGNAL SQLSTATE '45005' SET MESSAGE_TEXT = 'La orden no existe.';
    ELSEIF v_Estado = 'SIN COBERTURA' THEN
        SIGNAL SQLSTATE '45006' SET MESSAGE_TEXT = 'La orden no tiene cobertura.';
    ELSE
        SELECT o.id_orden, 
               
            CASE do.tipo_producto 
                WHEN 'C' THEN 'Combo'
                WHEN 'E' THEN 'Extra'
                WHEN 'B' THEN 'Bebida'
                WHEN 'P' THEN 'Postre'
                ELSE 'Desconocido' 
           END AS tipo_producto,

               m.precio, 
               m.producto,
               do.observacion,
               do.cantidad
        FROM Orden o 
        JOIN DetalleOrden do ON o.id_orden = do.id_orden 
        JOIN Menu m ON CONCAT(do.tipo_producto, do.producto) = m.id_menu
        WHERE o.id_orden = p_IdOrden;
    END IF;
END$$
DELIMITER ;