import 'package:flutter/material.dart';

class CanchaScreen extends StatefulWidget {
  final String nombreCancha;

  const CanchaScreen({super.key, required this.nombreCancha});

  @override
  State<CanchaScreen> createState() => _CanchaScreenState();
}

class _CanchaScreenState extends State<CanchaScreen> {
  DateTime? fechaSeleccionada;
  TimeOfDay? horaEntrada;
  TimeOfDay? horaSalida;

  // 🔥 Generamos horas disponibles cada 30 minutos
  final List<TimeOfDay> horasDisponibles = List.generate(
    32, // de 6:00 a 21:30
    (index) => TimeOfDay(hour: 6 + (index ~/ 2), minute: (index % 2) * 30),
  );

  Future<void> _seleccionarFecha(BuildContext context) async {
    final DateTime? fechaElegida = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF4CAF50),
              onSurface: Colors.white,
            ),
            dialogBackgroundColor: const Color(0xFF2C2C2C),
          ),
          child: child!,
        );
      },
    );

    if (fechaElegida != null) {
      setState(() => fechaSeleccionada = fechaElegida);
    }
  }

  Future<void> _seleccionarHora(BuildContext context, bool esEntrada) async {
    TimeOfDay? horaElegida;

    // 🔥 Si es la hora de salida y ya hay una entrada seleccionada,
    // filtramos las horas para que empiecen al menos 1 hora después.
    List<TimeOfDay> listaFiltrada = horasDisponibles;

    if (!esEntrada && horaEntrada != null) {
      listaFiltrada = horasDisponibles.where((hora) {
        final entradaMinutos = horaEntrada!.hour * 60 + horaEntrada!.minute;
        final salidaMinutos = hora.hour * 60 + hora.minute;
        // solo horas al menos 60 minutos después
        return salidaMinutos >= entradaMinutos + 60;
      }).toList();
    }

    await showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF2C2C2C),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SizedBox(
          height: 350,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  esEntrada
                      ? "Selecciona hora de entrada"
                      : "Selecciona hora de salida",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: listaFiltrada.length,
                  itemBuilder: (context, index) {
                    final hora = listaFiltrada[index];
                    return ListTile(
                      title: Text(
                        hora.format(context),
                        style: const TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        horaElegida = hora;
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );

    if (horaElegida != null) {
      setState(() {
        if (esEntrada) {
          horaEntrada = horaElegida;
          horaSalida = null; // 🧹 reiniciamos salida si cambia entrada
        } else {
          horaSalida = horaElegida;
        }
      });
    }
  }

  String getImagenCancha() {
    if (widget.nombreCancha.contains("5")) {
      return "https://rodala.com/images/canchas/2015_07_02_12_23_52_Aerosur_-_1Cancha.jpg";
    } else if (widget.nombreCancha.contains("7")) {
      return "https://www.tecdesa.com/wp-content/uploads/2018/03/circulo_solidario_01-370x230.jpg";
    } else {
      return "https://agorasport.es/wp-content/uploads/22-2.jpg";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        title: Text(widget.nombreCancha),
        backgroundColor: const Color(0xFF4CAF50),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  getImagenCancha(),
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                widget.nombreCancha,
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: () => _seleccionarFecha(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
                  foregroundColor: Colors.black,
                ),
                child: const Text('Seleccionar fecha'),
              ),
              const SizedBox(height: 10),
              if (fechaSeleccionada != null)
                Text(
                  '${fechaSeleccionada!.day}/${fechaSeleccionada!.month}/${fechaSeleccionada!.year}',
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () => _seleccionarHora(context, true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
                  foregroundColor: Colors.black,
                ),
                child: const Text('Seleccionar hora de entrada'),
              ),
              if (horaEntrada != null)
                Text(
                  'Entrada: ${horaEntrada!.format(context)}',
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: horaEntrada == null
                    ? null
                    : () => _seleccionarHora(context, false),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
                  foregroundColor: Colors.black,
                ),
                child: const Text('Seleccionar hora de salida'),
              ),
              if (horaSalida != null)
                Text(
                  'Salida: ${horaSalida!.format(context)}',
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                ),
              const SizedBox(height: 40),

              ElevatedButton(
                onPressed: (fechaSeleccionada == null ||
                        horaEntrada == null ||
                        horaSalida == null)
                    ? null
                    : () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '✅ Reserva confirmada el '
                              '${fechaSeleccionada!.day}/${fechaSeleccionada!.month}/${fechaSeleccionada!.year} '
                              'de ${horaEntrada!.format(context)} a ${horaSalida!.format(context)}',
                            ),
                            backgroundColor: Colors.green,
                          ),
                        );
                      Navigator.pop(context); 
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 50, vertical: 15),
                ),
                child: const Text('Confirmar reserva'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
