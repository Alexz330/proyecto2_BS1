DELIMITER //

CREATE TRIGGER tr_insert_Direcciones AFTER INSERT ON Direcciones
FOR EACH ROW
BEGIN
    INSERT INTO HistorialTransacciones (fecha, descripcion, tipo)
    VALUES (NOW(), 'Se ha insertado una fila en la tabla Direcciones', 'INSERT');
END //

CREATE TRIGGER tr_update_Direcciones AFTER UPDATE ON Direcciones
FOR EACH ROW
BEGIN
    INSERT INTO HistorialTransacciones (fecha, descripcion, tipo)
    VALUES (NOW(), 'Se ha actualizado una fila en la tabla Direcciones', 'UPDATE');
END //

CREATE TRIGGER tr_delete_Direcciones AFTER DELETE ON Direcciones
FOR EACH ROW
BEGIN
    INSERT INTO HistorialTransacciones (fecha, descripcion, tipo)
    VALUES (NOW(), 'Se ha eliminado una fila en la tabla Direcciones', 'DELETE');
END //
 
DELIMITER ;