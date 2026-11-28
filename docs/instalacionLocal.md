# Instalacion local (sin contenedores)

La infraestructura (PostgreSQL, Qdrant y n8n) se instala y arranca desde el repositorio `backend-sistema-incidentes`. La guia completa, con versiones, puertos y verificacion, esta en `docs/instalacionLocal.md` de ese repositorio.

## Uso desde este repositorio
1. Seguir la guia del backend hasta tener PostgreSQL arriba, la base `incidentes` creada y las migraciones aplicadas (`npm run prisma:aplicarMigraciones` en el backend).
2. Exportar `DATABASE_URL` con la misma cadena del `.env` del backend.
3. Cargar y verificar los articulos de conocimiento (historia 1.4):
   ```bash
   psql "$DATABASE_URL" -v ON_ERROR_STOP=1 -f seeds/datosArticulosConocimiento.sql
   psql "$DATABASE_URL" -v ON_ERROR_STOP=1 -f verificacion/verificarArticulosConocimiento.sql
   ```
4. El resto de los datos iniciales se carga con `node scripts/cargarDatosIniciales.js` cuando Dev2 termine la historia 1.7.2.

## Requisito
Cliente `psql` de PostgreSQL disponible en el `PATH`.
