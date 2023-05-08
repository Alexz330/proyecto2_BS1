DELIMITER $$
CREATE PROCEDURE ConsultarFacturas(IN dia INT, IN mes INT, IN anio INT)
BEGIN
    DECLARE fecha_consulta DATE;
    SET fecha_consulta = CONCAT(anio, '-', mes, '-', dia);

    IF NOT (fecha_consulta BETWEEN '2023-01-01' AND '2023-12-31') THEN
        SELECT 'Error: fecha inválida' AS Mensaje;
    ELSE
        SELECT no_serie, monto_total, lugar, fecha_actual, id_orden, IFNULL(nit_cliente, 'C/F') AS nit_cliente, 
        CASE tipo_pago WHEN 'E' THEN 'Efectivo' WHEN 'T' THEN 'Tarjeta' END AS forma_pago
        FROM Facturas
        WHERE fecha_actual = fecha_consulta;
    END IF;
END$$
DELIMITER ;