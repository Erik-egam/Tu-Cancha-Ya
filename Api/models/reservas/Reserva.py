from pydantic import BaseModel
from typing import Optional
from models.usuarios import Usuario
from datetime import date,datetime

class Reserva(BaseModel):
    usuario_id: int
    cancha_id:int
    fecha:str
    hora_inicio: str
    hora_fin: str
    estado: Optional[str] = None
    valor_reserva: Optional[float] = None
  
