DELIMITER //

CREATE PROCEDURE ListarRestaurantes()
BEGIN
  SELECT id_restaurante, direccion, municipio, zona, telefono, personal_maximo, 
  CASE 
    WHEN tiene_parqueo THEN 'Sí' 
    ELSE 'No' 
  END AS tiene_parqueo
  FROM Restaurantes;
END //

DELIMITER ;