# Datos iniciales: 25 articulos tecnicos (historia 1.4, RF02)

Los 25 articulos de `seeds/datosArticulosConocimiento.sql` son **sinteticos**: se redactaron para el proyecto y no provienen de ninguna organizacion real. Sirven para indexar en Qdrant y para probar el asistente RAG.

## Contenido
Cada articulo tiene `titulo`, `problema`, `sintomas`, `causa` y `solucion`, mas `fecha`, `estado` y `verificado`.

| Categoria | Articulos | Activos y verificados | Activos no verificados | Inactivos verificados | Inactivos no verificados |
|---|---|---|---|---|---|
| Software | 5 | 3 | 1 | 1 | 0 |
| Hardware | 5 | 3 | 1 | 0 | 1 |
| Conectividad | 5 | 4 | 0 | 1 | 0 |
| Aplicaciones | 5 | 3 | 1 | 0 | 1 |
| Servicios informaticos | 5 | 4 | 1 | 0 | 0 |
| **Total** | **25** | **17** | **4** | **2** | **2** |

Solo los articulos con estado `Activo` y `verificado = true` (17) pueden usarse como fuente del asistente y entrar al indice de Qdrant. Los otros 8 existen para probar la regla de exclusion (RF03 y RF04).

## Categoria de cada articulo
El modelo `ArticuloConocimiento` de `prisma/schema.prisma` no tiene columna de categoria. Por eso el titulo empieza con la categoria entre corchetes, por ejemplo `[Hardware] Disco duro con ruidos y lectura lenta`. Si Dev2 agrega una relacion con `Categoria` en la historia 1.5.2, se debe reemplazar el prefijo por la clave foranea y ajustar `verificacion/verificarArticulosConocimiento.sql`.

## Dependencia del nombre de tablas
El script usa los nombres que genera Prisma hoy: tabla `"ArticuloConocimiento"`, enumerado `"EstadoArticulo"` con los valores `Activo` e `Inactivo`. Si Dev2 cambia `@@map` o los valores del enumerado, hay que actualizar el script.

## Carga y verificacion
Con la base creada y las migraciones aplicadas:

```bash
psql "$DATABASE_URL" -v ON_ERROR_STOP=1 -f seeds/datosArticulosConocimiento.sql
psql "$DATABASE_URL" -v ON_ERROR_STOP=1 -f verificacion/verificarArticulosConocimiento.sql
```

- La carga es idempotente: usa `ON CONFLICT ("id") DO UPDATE`, asi que se puede repetir sin duplicar y deja la secuencia del `id` por encima de 25.
- La verificacion falla con un mensaje claro si no hay 25 articulos, si alguna categoria no tiene 5, si hay campos vacios, titulos repetidos o la mezcla de estados es insuficiente. Con datos correctos imprime `Articulos de conocimiento consistentes` y una tabla resumen por categoria.
