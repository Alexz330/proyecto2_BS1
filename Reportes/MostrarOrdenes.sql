DELIMITER //
CREATE PROCEDURE MostrarOrdenes(IN estado INT)
BEGIN
    DECLARE estado_string VARCHAR(20);
    
    IF estado = 1 THEN
        SET estado_string = 'INICIADA';
    ELSEIF estado = 2 THEN
        SET estado_string = 'AGREGANDO';
    ELSEIF estado = 3 THEN
        SET estado_string = 'EN CAMINO';
    ELSEIF estado = 4 THEN
        SET estado_string = 'ENTREGADA';
    ELSEIF estado = -1 THEN
        SET estado_string = 'SIN COBERTURA';
    ELSE
        SELECT 'El valor ingresado para el estado no es válido.';

    END IF;

    SELECT 
        Orden.id_orden AS IdOrden,
        estado_string AS Estado,
        Orden.fecha_inicio AS Fecha,
        Orden.dpi_cliente AS 'DPI cliente',
        Direcciones.direccion AS 'Dirección del cliente',
        Orden.id_restaurante AS 'Restaurante que cubre la orden',
        CASE 
            WHEN Orden.canal = 'L' THEN 'Llamada'
            WHEN Orden.canal = 'A' THEN 'Aplicación'
            ELSE 'Canal no definido'
        END AS Canal
    FROM Orden
    INNER JOIN Direcciones ON Orden.id_direccion = Direcciones.id_direccion
    WHERE Orden.estado = estado_string;
END //
DELIMITER ;