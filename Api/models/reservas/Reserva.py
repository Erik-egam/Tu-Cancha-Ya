from pydantic import BaseModel
from typing import Optional
from models.usuarios import Usuario
from datetime import date,datetime

class Reserva(BaseModel):
    usuario_id: int
    cancha_id:int
    fecha:date
    hora_inicio:datetime
    hora_fin:datetime
    estado:enumerate
    valor_reserva: float
  
