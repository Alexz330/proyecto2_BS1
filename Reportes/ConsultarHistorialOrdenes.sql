DELIMITER //

CREATE PROCEDURE ConsultarHistorialOrdenes(IN p_dpi_cliente NUMERIC(14))
BEGIN
    DECLARE existe_cliente INT DEFAULT 0;
    
    -- Verificar si el cliente existe
    SELECT COUNT(*) INTO existe_cliente FROM Clientes WHERE dpi_cliente = p_dpi_cliente;
    
    IF existe_cliente = 0 THEN
        SIGNAL SQLSTATE '45006' SET MESSAGE_TEXT = 'El cliente no existe';
     
    ELSE
        SELECT Orden.id_orden AS IdOrden, Orden.fecha_inicio AS Fecha, SUM(DetalleOrden.cantidad * DetalleOrden.precio_unitario) AS 'Monto de la orden',
               Restaurantes.id_restaurante AS 'Restaurante que cubrió la orden',
               CONCAT(Empleados.nombres, ' ', Empleados.apellidos) AS 'Repartidor que hizo la entrega',
               Direcciones.direccion AS 'Dirección que fue enviada',
               CASE Orden.canal
                    WHEN 'L' THEN 'Llamada'
                    WHEN 'A' THEN 'Aplicación'
                    ELSE 'Desconocido'
               END AS Canal
        FROM Orden
        INNER JOIN Clientes ON Orden.dpi_cliente = Clientes.dpi_cliente
        INNER JOIN Direcciones ON Orden.id_direccion = Direcciones.id_direccion
        INNER JOIN DetalleOrden ON Orden.id_orden = DetalleOrden.id_orden
        INNER JOIN Empleados ON Orden.id_empleado = Empleados.id_empleado
        INNER JOIN Restaurantes ON Orden.id_restaurante = Restaurantes.id_restaurante
        WHERE Clientes.dpi_cliente = p_dpi_cliente
        GROUP BY Orden.id_orden
        ORDER BY Orden.fecha_inicio DESC;
    END IF;
END //

DELIMITER ;
