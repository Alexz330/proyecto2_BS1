DELIMITER //

CREATE PROCEDURE RegistrarRestaurante (
    IN p_id VARCHAR(50),
    IN p_direccion VARCHAR(255),
    IN p_municipio VARCHAR(50),
    IN p_zona INT UNSIGNED,
    IN p_telefono BIGINT UNSIGNED,
    IN p_personal_maximo INT UNSIGNED,
    IN p_tiene_parqueo BOOLEAN
)
BEGIN
    INSERT INTO Restaurantes (id_restaurante, direccion, municipio, zona, telefono, personal_maximo, tiene_parqueo)
    VALUES (p_id, p_direccion, p_municipio, p_zona, p_telefono, p_personal_maximo, p_tiene_parqueo);
END //

DELIMITER ;
