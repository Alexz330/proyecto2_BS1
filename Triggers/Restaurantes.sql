DELIMITER //

CREATE TRIGGER tr_insert_Restaurantes AFTER INSERT ON Restaurantes
FOR EACH ROW
BEGIN
    INSERT INTO HistorialTransacciones (fecha, descripcion, tipo)
    VALUES (NOW(), 'Se ha insertado una fila en la tabla Restaurantes', 'INSERT');
END //

CREATE TRIGGER tr_update_Restaurantes AFTER UPDATE ON Restaurantes
FOR EACH ROW
BEGIN
    INSERT INTO HistorialTransacciones (fecha, descripcion, tipo)
    VALUES (NOW(), 'Se ha actualizado una fila en la tabla Restaurantes', 'UPDATE');
END //

CREATE TRIGGER tr_delete_Restaurantes AFTER DELETE ON Restaurantes
FOR EACH ROW
BEGIN
    INSERT INTO HistorialTransacciones (fecha, descripcion, tipo)
    VALUES (NOW(), 'Se ha eliminado una fila en la tabla Restaurantes', 'DELETE');
END //
 
DELIMITER ;