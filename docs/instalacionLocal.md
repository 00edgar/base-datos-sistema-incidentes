# Instalacion local (sin contenedores)

> Responsable: Dev1 (historia 1.2). Completar con las versiones y los comandos reales del equipo.

## Requisitos
- Node.js 20 o superior
- PostgreSQL (servicio local), Qdrant (ejecutable local) y n8n (instalacion local)
- Proveedor de IA configurable (por ejemplo Ollama local) para embeddings y generacion

## Pasos
1. PostgreSQL: crear la base `incidentes` y un usuario del proyecto. (TODO: comandos)
2. Qdrant: descargar el ejecutable y arrancarlo en el puerto 6333. (TODO: comandos)
3. n8n: instalar y arrancar en el puerto 5678. (TODO: comandos)
4. Copiar `.env.example` a `.env` y completar.
5. Backend: `cd backend && npm install && npm run prisma:generar && npm run prisma:migrar`.
6. Datos iniciales: `npm run sembrar`.
7. Arrancar: `npm run desarrollo` y abrir http://localhost:3000.
8. Verificar: http://localhost:3000/api/salud debe responder `{"estado":"ok"}`.

## Puertos por defecto
| Servicio | Puerto |
|---|---|
| Backend + frontend | 3000 |
| PostgreSQL | 5432 |
| Qdrant | 6333 |
| n8n | 5678 |
