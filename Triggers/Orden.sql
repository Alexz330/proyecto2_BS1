DELIMITER //

CREATE TRIGGER tr_insert_Orden AFTER INSERT ON Orden
FOR EACH ROW
BEGIN
    INSERT INTO HistorialTransacciones (fecha, descripcion, tipo)
    VALUES (NOW(), 'Se ha insertado una fila en la tabla Orden', 'INSERT');
END //

CREATE TRIGGER tr_update_Orden AFTER UPDATE ON Orden
FOR EACH ROW
BEGIN
    INSERT INTO HistorialTransacciones (fecha, descripcion, tipo)
    VALUES (NOW(), 'Se ha actualizado una fila en la tabla Orden', 'UPDATE');
END //

CREATE TRIGGER tr_delete_Orden AFTER DELETE ON Orden
FOR EACH ROW
BEGIN
    INSERT INTO HistorialTransacciones (fecha, descripcion, tipo)
    VALUES (NOW(), 'Se ha eliminado una fila en la tabla Orden', 'DELETE');
END //
 
DELIMITER ;