DELIMITER //
CREATE PROCEDURE ConsultarEmpleado(
    IN p_id_empleado INT
)
BEGIN
    DECLARE v_id_empleado INT;
    DECLARE v_nombre_completo VARCHAR(100);
    DECLARE v_fecha_nacimiento DATE;
    DECLARE v_correo VARCHAR(50);
    DECLARE v_telefono BIGINT UNSIGNED;
    DECLARE v_direccion VARCHAR(100);
    DECLARE v_num_dpi BIGINT UNSIGNED;
    DECLARE v_nombre_puesto VARCHAR(50);
    DECLARE v_fecha_inicio DATE;
    DECLARE v_salario DECIMAL(10, 2);
    
    -- Validar que el empleado existe
    IF NOT EXISTS (SELECT * FROM Empleados WHERE id_empleado = p_id_empleado) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El empleado no existe';
    END IF;
    
    -- Obtener la información del empleado
    SELECT id_empleado, CONCAT(nombres, ' ', apellidos) AS nombre_completo, fecha_nacimiento, correo, telefono, direccion, num_dpi, nombre AS nombre_puesto, fecha_inicio, salario
    INTO v_id_empleado, v_nombre_completo, v_fecha_nacimiento, v_correo, v_telefono, v_direccion, v_num_dpi, v_nombre_puesto, v_fecha_inicio, v_salario
    FROM Empleados e
    JOIN PuestosDeTrabajo p ON e.id_puesto = p.id_puesto
    WHERE id_empleado = p_id_empleado;
    
    -- Mostrar resultados
    SELECT v_id_empleado, v_nombre_completo, v_fecha_nacimiento, v_correo, v_telefono, v_direccion, v_num_dpi, v_nombre_puesto, v_fecha_inicio, v_salario;
END //

DELIMITER ;

