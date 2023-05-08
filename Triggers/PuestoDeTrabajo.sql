DELIMITER //

CREATE TRIGGER tr_insert_PuestosDeTrabajo AFTER INSERT ON PuestosDeTrabajo
FOR EACH ROW
BEGIN
    INSERT INTO HistorialTransacciones (fecha, descripcion, tipo)
    VALUES (NOW(), 'Se ha insertado una fila en la tabla PuestosDeTrabajo', 'INSERT');
END //

CREATE TRIGGER tr_update_PuestosDeTrabajo AFTER UPDATE ON PuestosDeTrabajo
FOR EACH ROW
BEGIN
    INSERT INTO HistorialTransacciones (fecha, descripcion, tipo)
    VALUES (NOW(), 'Se ha actualizado una fila en la tabla PuestosDeTrabajo', 'UPDATE');
END //

CREATE TRIGGER tr_delete_PuestosDeTrabajo AFTER DELETE ON PuestosDeTrabajo
FOR EACH ROW
BEGIN
    INSERT INTO HistorialTransacciones (fecha, descripcion, tipo)
    VALUES (NOW(), 'Se ha eliminado una fila en la tabla PuestosDeTrabajo', 'DELETE');
END //
 
DELIMITER ;