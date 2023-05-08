DELIMITER //

CREATE TRIGGER tr_insert_Empleados AFTER INSERT ON Empleados
FOR EACH ROW
BEGIN
    INSERT INTO HistorialTransacciones (fecha, descripcion, tipo)
    VALUES (NOW(), 'Se ha insertado una fila en la tabla Empleados', 'INSERT');
END //

CREATE TRIGGER tr_update_Empleados AFTER UPDATE ON Empleados
FOR EACH ROW
BEGIN
    INSERT INTO HistorialTransacciones (fecha, descripcion, tipo)
    VALUES (NOW(), 'Se ha actualizado una fila en la tabla Empleados', 'UPDATE');
END //

CREATE TRIGGER tr_delete_Empleados AFTER DELETE ON Empleados
FOR EACH ROW
BEGIN
    INSERT INTO HistorialTransacciones (fecha, descripcion, tipo)
    VALUES (NOW(), 'Se ha eliminado una fila en la tabla Empleados', 'DELETE');
END //
 
DELIMITER ;