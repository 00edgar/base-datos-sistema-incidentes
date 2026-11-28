DO $$
DECLARE
  total integer;
  categorias_distintas integer;
  articulos_incompletos integer;
  titulos_repetidos integer;
  activos_verificados integer;
  activos_no_verificados integer;
  inactivos_verificados integer;
  inactivos_no_verificados integer;
  categoria record;
BEGIN
  SELECT COUNT(*) INTO total FROM "ArticuloConocimiento" WHERE "id" BETWEEN 1 AND 25;
  IF total <> 25 THEN
    RAISE EXCEPTION 'Se esperaban 25 articulos con id de 1 a 25 y hay %', total;
  END IF;

  SELECT COUNT(DISTINCT substring("titulo" FROM '^\[([^\]]+)\]')) INTO categorias_distintas
  FROM "ArticuloConocimiento" WHERE "id" BETWEEN 1 AND 25;
  IF categorias_distintas <> 5 THEN
    RAISE EXCEPTION 'Se esperaban 5 categorias y hay %', categorias_distintas;
  END IF;

  FOR categoria IN
    SELECT substring("titulo" FROM '^\[([^\]]+)\]') AS nombre, COUNT(*) AS cantidad
    FROM "ArticuloConocimiento" WHERE "id" BETWEEN 1 AND 25
    GROUP BY 1
  LOOP
    IF categoria.cantidad <> 5 THEN
      RAISE EXCEPTION 'La categoria % debe tener 5 articulos y tiene %', categoria.nombre, categoria.cantidad;
    END IF;
  END LOOP;

  SELECT COUNT(*) INTO articulos_incompletos
  FROM "ArticuloConocimiento"
  WHERE "id" BETWEEN 1 AND 25
    AND (btrim("titulo") = '' OR btrim("problema") = '' OR btrim("sintomas") = ''
         OR btrim("causa") = '' OR btrim("solucion") = '');
  IF articulos_incompletos <> 0 THEN
    RAISE EXCEPTION 'Hay % articulos con campos vacios', articulos_incompletos;
  END IF;

  SELECT COUNT(*) INTO titulos_repetidos FROM (
    SELECT "titulo" FROM "ArticuloConocimiento" WHERE "id" BETWEEN 1 AND 25 GROUP BY "titulo" HAVING COUNT(*) > 1
  ) repetidos;
  IF titulos_repetidos <> 0 THEN
    RAISE EXCEPTION 'Hay % titulos repetidos', titulos_repetidos;
  END IF;

  SELECT
    COUNT(*) FILTER (WHERE "estado" = 'Activo' AND "verificado"),
    COUNT(*) FILTER (WHERE "estado" = 'Activo' AND NOT "verificado"),
    COUNT(*) FILTER (WHERE "estado" = 'Inactivo' AND "verificado"),
    COUNT(*) FILTER (WHERE "estado" = 'Inactivo' AND NOT "verificado")
  INTO activos_verificados, activos_no_verificados, inactivos_verificados, inactivos_no_verificados
  FROM "ArticuloConocimiento" WHERE "id" BETWEEN 1 AND 25;

  IF activos_verificados < 15 OR activos_no_verificados < 1 OR inactivos_verificados < 1 OR inactivos_no_verificados < 1 THEN
    RAISE EXCEPTION 'Mezcla de estados insuficiente: activos verificados %, activos no verificados %, inactivos verificados %, inactivos no verificados %',
      activos_verificados, activos_no_verificados, inactivos_verificados, inactivos_no_verificados;
  END IF;

  RAISE NOTICE 'Articulos de conocimiento consistentes: total %, activos verificados %, activos no verificados %, inactivos verificados %, inactivos no verificados %',
    total, activos_verificados, activos_no_verificados, inactivos_verificados, inactivos_no_verificados;
END
$$;

SELECT substring("titulo" FROM '^\[([^\]]+)\]') AS categoria,
       COUNT(*) AS articulos,
       COUNT(*) FILTER (WHERE "estado" = 'Activo' AND "verificado") AS elegibles_como_fuente
FROM "ArticuloConocimiento"
WHERE "id" BETWEEN 1 AND 25
GROUP BY 1
ORDER BY 1;
