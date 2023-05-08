DELIMITER //

CREATE TRIGGER tr_insert_DetalleOrden AFTER INSERT ON DetalleOrden
FOR EACH ROW
BEGIN
    INSERT INTO HistorialTransacciones (fecha, descripcion, tipo)
    VALUES (NOW(), 'Se ha insertado una fila en la tabla DetalleOrden', 'INSERT');
END //

CREATE TRIGGER tr_update_DetalleOrden AFTER UPDATE ON DetalleOrden
FOR EACH ROW
BEGIN
    INSERT INTO HistorialTransacciones (fecha, descripcion, tipo)
    VALUES (NOW(), 'Se ha actualizado una fila en la tabla DetalleOrden', 'UPDATE');
END //

CREATE TRIGGER tr_delete_DetalleOrden AFTER DELETE ON DetalleOrden
FOR EACH ROW
BEGIN
    INSERT INTO HistorialTransacciones (fecha, descripcion, tipo)
    VALUES (NOW(), 'Se ha eliminado una fila en la tabla DetalleOrden', 'DELETE');
END //
 
DELIMITER ;