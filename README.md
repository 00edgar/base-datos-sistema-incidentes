# base-datos-sistema-incidentes

Scripts SQL del sistema inteligente de analisis de incidentes (PostgreSQL local).

> El esquema y las migraciones se gestionan con Prisma en `backend-sistema-incidentes/prisma/schema.prisma`. Este repositorio contiene los scripts que se ejecutan sobre ese esquema.

## Estructura
```
seeds/          datosCatalogos.sql, datosArticulosConocimiento.sql, datosIncidentesHistoricos.sql
analitica/      consultasIndicadores.sql (los 7 indicadores, SQL real)
verificacion/   verificarIntegridadDatos.sql, verificarIndicadoresContraDatos.sql
scripts/        cargarDatosIniciales.js
docs/           diagramaEntidadRelacion.md, instalacionLocal.md
```

## Uso
1. Crear la base y aplicar las migraciones desde el repositorio backend.
2. Copiar `.env.example` a `.env`.
3. Cargar datos: `node scripts/cargarDatosIniciales.js` (requiere `psql`).
4. Comprobar con los scripts de `verificacion/`.

Datos iniciales minimos: 150 incidentes, 25 articulos tecnicos, 5 categorias y 10 usuarios (sinteticos y documentados).
Cada archivo indica su responsable y su historia de ClickUp. Normas en `docs/convencionesNombres.md` y `docs/flujoGit.md`.
