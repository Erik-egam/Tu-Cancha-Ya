from config import crear_conexion
from mysql.connector import IntegrityError
from fastapi import HTTPException,status
import models.canchas.Cancha 


def listar_cancha():
    conexion = crear_conexion()
    cursor = conexion.cursor(dictionary=True)
    cursor.execute("SELECT * FROM canchas")
    usuarios = cursor.fetchall()
    cursor.close()
    conexion.close()
    return usuarios
