from pydantic import BaseModel
from typing import Optional

class Cancha(BaseModel):
    nombre: str
    precio_hora:str
    disponible:str
    tipo_id:Optional[bool] = None
