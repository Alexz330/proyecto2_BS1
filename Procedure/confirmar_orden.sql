DELIMITER //

CREATE PROCEDURE ConfirmarOrden(
    p_idOrden INT,
    p_formaPago CHAR(1), 
    p_idRepartidor INT
) 
BEGIN
  DECLARE v_estado VARCHAR(20);
  DECLARE v_cantidad INT;
  DECLARE v_precio DECIMAL(10,2);
  DECLARE v_total DECIMAL(10,2);
  DECLARE v_iva DECIMAL(10,2);
  DECLARE v_totalConIva DECIMAL(10,2);
  DECLARE v_numSerie VARCHAR(20);
  DECLARE v_lugar VARCHAR(50);
  DECLARE v_fecha DATETIME;
  DECLARE v_nit VARCHAR(20);
  DECLARE v_formaPago VARCHAR(10);
  DECLARE v_idFactura INT;
  DECLARE v_idCliente bigint(20);
  DECLARE v_municipio VARCHAR(100);
  DECLARE v_id_direccion INT;

  -- Verificar que el id de la orden sea válido
  SELECT estado, id_direccion, dpi_cliente INTO v_estado, v_id_direccion, v_idCliente
  FROM Orden
  WHERE id_Orden = p_idOrden;

  IF v_estado IS NULL THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: La orden no existe.';
  END IF;

  IF v_estado != 'INICIADA' THEN
    SIGNAL SQLSTATE '45005' SET MESSAGE_TEXT = 'Error: La orden no está en proceso.';
  END IF;

  -- Verificar que el id del repartidor sea válido
  SELECT COUNT(*) INTO v_cantidad
  FROM Empleados e
  JOIN PuestosDeTrabajo t ON e.id_puesto  = t.id_puesto 
  WHERE e.id_empleado = p_idRepartidor AND t.nombre = 'Repartidor';

  IF v_cantidad = 0 THEN
    SIGNAL SQLSTATE '45005' SET MESSAGE_TEXT = 'Error: el id del repartidor no es válido.';
  END IF;

  -- Calcular el total de la orden a partir de los detalles
  SELECT SUM(cantidad * precio_unitario) INTO v_total
  FROM DetalleOrden
  WHERE id_Orden = p_idOrden;

  -- Verificar que la forma de pago sea válida
  IF p_formaPago NOT IN ('E', 'T') THEN
    SIGNAL SQLSTATE '45005' SET MESSAGE_TEXT = 'Error: Método de pago inválido.';
  END IF;

  -- Obtener el NIT del cliente
  SELECT nit INTO v_nit
  FROM Clientes
  WHERE dpi_cliente = v_idCliente;

  -- Obtener el municipio
  SELECT municipio INTO v_municipio
  FROM Direcciones 
  WHERE id_direccion = v_id_direccion;

  -- Generar el encabezado de la factura
  SET v_iva = v_total * 0.12;
  SET v_totalConIva = v_total + v_iva;
  SET v_fecha = NOW();
  SET v_formaPago = CASE p_formaPago WHEN 'E' THEN 'Efectivo' WHEN 'T' THEN 'Tarjeta' ELSE 'Desconocido' END;
  SET v_numSerie = CONCAT(YEAR(v_fecha), '-', p_idOrden);
-- Insertar la información de la factura en la base de datos
  INSERT INTO Facturas (id_orden, no_serie, monto_total, lugar, fecha_actual, nit_cliente, tipo_pago)
  VALUES (p_idOrden, v_numSerie, v_totalConIva, v_municipio, v_fecha, v_nit, p_formaPago);

-- Actualizar el estado de la orden a "EN CAMINO" y asignar el id del repartidor
  UPDATE Orden SET estado = 'EN CAMINO', id_empleado = p_idRepartidor WHERE id_Orden = p_idOrden;

-- RETURN CONCAT('Se confirmó la orden ', p_idOrden, ' y se generó la factura con número de serie ', v_numSerie, '.');
  SELECT 'Se confirmó la orden ', p_idOrden, ' y se generó la factura con número de serie ', v_numSerie, '.' AS mensaje;
END //

DELIMITER ;