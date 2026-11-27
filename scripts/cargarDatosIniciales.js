/**
 * Carga en orden los scripts SQL de /seeds en PostgreSQL usando el cliente "psql" (viene con PostgreSQL).
 *
 * Responsable: Dev2 | Historia ClickUp: 1.7.2 | RF01, RF06
 *
 * Uso: DATABASE_URL=postgresql://usuario:clave@localhost:5432/incidentes node scripts/cargarDatosIniciales.js
 *
 * TODO: recorrer los archivos en este orden: datosCatalogos.sql, datosArticulosConocimiento.sql, datosIncidentesHistoricos.sql.
 * TODO: ejecutar cada uno con child_process.spawnSync('psql', [urlBaseDatos, '-v', 'ON_ERROR_STOP=1', '-f', archivo]).
 * TODO: detenerse al primer error y mostrar que archivo fallo.
 */
console.log('Pendiente de implementar: ver historias 1.4.2, 1.7.1 y 1.7.2.');
