DELIMITER //
CREATE PROCEDURE orders_wait_time(IN minuto INT USIGNED)
BEGIN
    SELECT o.id_orden, d.direccion, o.fecha_inicio, TIMESTAMPDIFF(MINUTE, o.fecha_inicio, o.fecha_entrega) AS tiempo_espera, e.nombres 
    FROM Orden o 
    INNER JOIN Empleados e ON e.id_empleado = o.id_empleado 
    INNER JOIN Direcciones d ON d.id_direccion = o.id_direccion 
    WHERE TIMESTAMPDIFF(MINUTE, o.fecha_inicio, o.fecha_entrega) >= minuto;
END //
DELIMITER ;