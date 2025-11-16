from fastapi import APIRouter, HTTPException,status
from models.usuarios import Funciones_usuario
from models.usuarios.Usuario import UsuarioDB, LoginData



router = APIRouter()
#listarusuario
@router.get("/usuarios")
def get_usuarios():
    usuarios = Funciones_usuario.listar_usuarios()
    if usuarios:
        return usuarios
    raise HTTPException(status_code=404, detail="No hay usuarios registrados")

#registrar usuario
@router.post("/usuario/registrar",status_code=status.HTTP_201_CREATED)
async def registrar_usuario(usuario:UsuarioDB):
    await Funciones_usuario.registrar_usuario(usuario)
    return {
        "detail":f"usuario {usuario.nombre_completo} creado correctamente" 
    }

#login
@router.post("/usuario/login")
async def login(data: LoginData):
    usuario = await Funciones_usuario.login_usuario(data)
    return {
        "Usuario": f"{usuario['nombre_completo']}",
        "Usuario_id": f"{usuario['id']}"
    }

