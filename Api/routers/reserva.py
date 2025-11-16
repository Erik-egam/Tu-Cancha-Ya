from fastapi import APIRouter, HTTPException,status
from models.reservas import Funciones_reserva
from models.reservas.Reserva import Reserva

router = APIRouter()
#listarusuario
@router.get("/canchas")
def get_canchas():
    usuarios = Funciones_reserva.listar_reserva()
    if usuarios:
        return usuarios
    raise HTTPException(status_code=404, detail="No hay canchas registradas")


@router.post("/registrar/reserva/")
def registrar_reserva(reserva: Reserva):
    Funciones_reserva.reservar_cancha(reserva)
    return {
        "mensaje": "reservado correctamente"
    }



