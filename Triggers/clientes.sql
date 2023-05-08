DELIMITER //

CREATE TRIGGER tr_insert_Clientes AFTER INSERT ON Clientes
FOR EACH ROW
BEGIN
    INSERT INTO HistorialTransacciones (fecha, descripcion, tipo)
    VALUES (NOW(), 'Se ha insertado una fila en la tabla Clientes', 'INSERT');
END //

CREATE TRIGGER tr_update_Clientes AFTER UPDATE ON Clientes
FOR EACH ROW
BEGIN
    INSERT INTO HistorialTransacciones (fecha, descripcion, tipo)
    VALUES (NOW(), 'Se ha actualizado una fila en la tabla Clientes', 'UPDATE');
END //

CREATE TRIGGER tr_delete_Clientes AFTER DELETE ON Clientes
FOR EACH ROW
BEGIN
    INSERT INTO HistorialTransacciones (fecha, descripcion, tipo)
    VALUES (NOW(), 'Se ha eliminado una fila en la tabla Clientes', 'DELETE');
END //
 
DELIMITER ;