DELIMITER //

CREATE PROCEDURE AgregarItem(
  IN p_idOrden INT,
  IN p_tipoProducto CHAR(1),
  IN p_producto INT,
  IN p_cantidad INT,
  IN p_observacion VARCHAR(255)
)
BEGIN
  DECLARE v_estado VARCHAR(50);
  DECLARE v_cobertura BOOLEAN;
  DECLARE v_validProduct BOOLEAN;
  DECLARE v_precio DECIMAL(10,2);
  DECLARE v_total DECIMAL(10,2);
  
  -- Validar que la orden exista y su estado sea válido.
  SELECT estado INTO v_estado FROM Orden WHERE id_Orden = p_idOrden;
  IF v_estado IS NULL THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La orden no existe';
  END IF;
  
  IF v_estado != 'INICIADA' THEN
    SIGNAL SQLSTATE '45001' SET MESSAGE_TEXT = 'No se puede agregar un ítem a una orden que ya fue finalizada o que se encuentra en camino para entregarse al cliente';
  END IF;
  
  -- Validar que la orden tenga cobertura.
  IF v_estado = 'SIN COBERTURA' THEN
    SIGNAL SQLSTATE '45002' SET MESSAGE_TEXT = 'La orden no tiene cobertura';
  END IF;
  
  -- Validar el tipo de producto y que sea un producto que exista.
  IF p_tipoProducto NOT IN ('C', 'E', 'B', 'P') THEN
    SIGNAL SQLSTATE '45003' SET MESSAGE_TEXT = 'Tipo de producto inválido';
  END IF;

  SET v_validProduct = FALSE;

  IF p_tipoProducto = 'C' THEN
    SELECT COUNT(*) INTO v_validProduct FROM Menu WHERE id_menu = CONCAT('C', p_producto);
  ELSEIF p_tipoProducto = 'E' THEN
    SELECT COUNT(*) INTO v_validProduct FROM Menu WHERE id_menu = CONCAT('E', p_producto);
  ELSEIF p_tipoProducto = 'B' THEN
    SELECT COUNT(*) INTO v_validProduct FROM Menu WHERE id_menu = CONCAT('B', p_producto);
  ELSEIF p_tipoProducto = 'P' THEN
    SELECT COUNT(*) INTO v_validProduct FROM Menu WHERE id_menu = CONCAT('P', p_producto);
  END IF;
  
  IF NOT v_validProduct THEN
    SIGNAL SQLSTATE '45004' SET MESSAGE_TEXT = 'El producto no existe';
  END IF;
  
  -- Validar que la cantidad sea un entero positivo.
  IF p_cantidad < 1 OR p_cantidad % 1 != 0 THEN
    SIGNAL SQLSTATE '45005' SET MESSAGE_TEXT = 'Cantidad inválida';
  END IF;
  
  -- Obtener el precio del producto y calcular el total.
  IF p_tipoProducto = 'C' THEN
    SELECT precio INTO v_precio FROM Menu WHERE id_menu = CONCAT('C', p_producto);
  ELSEIF p_tipoProducto = 'E' THEN
    SELECT precio INTO v_precio FROM Menu WHERE id_menu = CONCAT('E', p_producto);
  ELSEIF p_tipoProducto = 'B' THEN
    SELECT precio INTO v_precio FROM Menu WHERE id_menu = CONCAT('B', p_producto);
  ELSEIF p_tipoProducto = 'P' THEN
    SELECT precio INTO v_precio FROM Menu WHERE id_menu = CONCAT('P', p_producto);
  END IF;
  
  -- SET v_total = v_precio * p_cantidad;

  -- Insertar el ítem en el detalle de la orden.
  INSERT INTO detalleOrden (id_Orden, tipo_producto, producto, cantidad, precio_unitario, observacion)
  VALUES (p_idOrden, p_tipoProducto, p_producto, p_cantidad, v_precio, p_observacion);

    -- Actualizar el total de la orden.
  -- UPDATE orden SET total = total + v_total WHERE id_Orden = p_idOrden;

    UPDATE Orden SET estado = 'AGREGANDO' WHERE id_Orden = p_idOrden;


    -- Devolver mensaje de éxito.
  SELECT 'Ítem agregado correctamente.' AS mensaje;

END //
DELIMITER ;