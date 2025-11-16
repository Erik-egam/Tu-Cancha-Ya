from config import crear_conexion
from mysql.connector import IntegrityError
from fastapi import HTTPException, status
from models.reservas.Reserva import Reserva


def listar_reserva():
    conexion = crear_conexion()
    cursor = conexion.cursor(dictionary=True)
    cursor.execute("SELECT * FROM reservas")
    reservas = cursor.fetchall()
    cursor.close()
    conexion.close()
    return reservas


def reservar_cancha(datos: Reserva):
    try:
        conexion = crear_conexion()
        cursor = conexion.cursor()

        sql = """INSERT INTO reservas (usuario_id, cancha_id, fecha, hora_inicio, hora_fin, estado, valor_reserva)
                VALUES (%s, %s, %s, %s, %s, 'pendiente', 20000);
                """

        valores = (
            datos.usuario_id,
            datos.cancha_id,
            datos.fecha,
            datos.hora_inicio,
            datos.hora_fin,
        )
        cursor.execute(sql, valores)
        conexion.commit()
        cursor.close()
        conexion.close()

    except IntegrityError as e:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail=f"Error: {e}"
        )
