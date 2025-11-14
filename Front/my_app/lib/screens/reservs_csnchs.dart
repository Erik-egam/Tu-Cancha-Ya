import 'package:flutter/material.dart';
import 'package:my_app/screens/login_view.dart';
import 'package:my_app/screens/cancha.dart'; // 👈 pantalla de detalle

class ReservaCanchas extends StatelessWidget {
  const ReservaCanchas({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reservar Cancha"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            tooltip: 'Cerrar sesión',
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          ),
        ],
      ),
      backgroundColor: const Color(0xFF1E1E1E),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Cancha 1
            Card(
              color: const Color(0xFF2C2C2C),
              margin: const EdgeInsets.all(10),
              child: ListTile(
                title: const Text(
                  'Fútbol 5',
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: const Text(
                  'Disponible',
                  style: TextStyle(color: Colors.white70),
                ),
                trailing: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CanchaScreen(
                          nombreCancha: 'Fútbol 5',
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF50),
                    foregroundColor: Colors.black,
                  ),
                  child: const Text('Ver'),
                ),
              ),
            ),

            // Cancha 2
            Card(
              color: const Color(0xFF2C2C2C),
              margin: const EdgeInsets.all(10),
              child: ListTile(
                title: const Text(
                  'Fútbol 7',
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: const Text(
                  'Disponible',
                  style: TextStyle(color: Colors.white70),
                ),
                trailing: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CanchaScreen(
                          nombreCancha: 'Fútbol 7',
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF50),
                    foregroundColor: Colors.black,
                  ),
                  child: const Text('Ver'),
                ),
              ),
            ),

            // Cancha 3
            Card(
              color: const Color(0xFF2C2C2C),
              margin: const EdgeInsets.all(10),
              child: ListTile(
                title: const Text(
                  'Fútbol 11',
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: const Text(
                  'Disponible',
                  style: TextStyle(color: Colors.white70),
                ),
                trailing: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CanchaScreen(
                          nombreCancha: 'Fútbol 11',
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF50),
                    foregroundColor: Colors.black,
                  ),
                  child: const Text('Ver'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
