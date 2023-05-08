DELIMITER //

CREATE PROCEDURE RegistrarPuesto (
    IN nombre_puesto VARCHAR(50),
    IN descripcion VARCHAR(200),
    IN salario DECIMAL(10,2) UNSIGNED
)
BEGIN
    INSERT INTO PuestosDeTrabajo (nombre, salario, descripcion)
    VALUES (nombre_puesto, salario, descripcion);
END //

DELIMITER ;