from fastapi import APIRouter, HTTPException,status
from models.canchas import Funciones_canchas
from models.canchas.Cancha import Cancha

router = APIRouter()
#listarusuario
@router.get("/canchas")
def get_canchas():
    usuarios = Funciones_canchas.listar_cancha()
    if usuarios:
        return usuarios
    raise HTTPException(status_code=404, detail="No hay canchas registradas")


