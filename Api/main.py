from fastapi import FastAPI
from config import crear_conexion
from fastapi.middleware.cors import CORSMiddleware

# Crear instancia de la app
app = FastAPI(title="TuCanchaYa API")

# Conexión a la base de datos
conexion = crear_conexion()

# Middleware CORS para permitir peticiones desde Flutter
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Puedes poner tu IP o dominio en producción
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Importar los routers DESPUÉS de crear la conexión
from routers import usuario
from routers import cancha
from routers import reserva

# Incluir el router de usuarios
app.include_router(usuario.router, tags=["usuarios"])
app.include_router(cancha.router, tags=["canchas"])
app.include_router(reserva.router, tags=["reserva"])

# Ruta raíz opcional para probar conexión
@app.get("/")
async def root():
    return {"mensaje": "API TuCanchaYa activa y conectada"}

# ejemplo de verificación
import bcrypt

def verificar_password(password_plain: str, password_hashed: str) -> bool:
    return bcrypt.checkpw(password_plain.encode('utf-8'), password_hashed.encode('utf-8'))

