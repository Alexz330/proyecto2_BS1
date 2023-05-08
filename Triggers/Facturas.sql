DELIMITER //

CREATE TRIGGER tr_insert_Facturas AFTER INSERT ON Facturas
FOR EACH ROW
BEGIN
    INSERT INTO HistorialTransacciones (fecha, descripcion, tipo)
    VALUES (NOW(), 'Se ha insertado una fila en la tabla Facturas', 'INSERT');
END //

CREATE TRIGGER tr_update_Facturas AFTER UPDATE ON Facturas
FOR EACH ROW
BEGIN
    INSERT INTO HistorialTransacciones (fecha, descripcion, tipo)
    VALUES (NOW(), 'Se ha actualizado una fila en la tabla Facturas', 'UPDATE');
END //

CREATE TRIGGER tr_delete_Facturas AFTER DELETE ON Facturas
FOR EACH ROW
BEGIN
    INSERT INTO HistorialTransacciones (fecha, descripcion, tipo)
    VALUES (NOW(), 'Se ha eliminado una fila en la tabla Facturas', 'DELETE');
END //
 
DELIMITER ;