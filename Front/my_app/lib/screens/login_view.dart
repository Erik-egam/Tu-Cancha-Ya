import 'package:flutter/material.dart';
import 'package:my_app/screens/reservs_csnchs.dart';
import 'registro_usuario.dart';
import 'package:my_app/services/api_servivios.dart';

// ---------------------- LOGIN ----------------------
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _cargando = false;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // Control del giro del balón
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _iniciarSesion() async {
    final apiService = ApiService();

    setState(() {
      _cargando = true;
      _controller.repeat(); // Empieza a girar el balón
    });

    try {
      final exito = await apiService.login(
        emailController.text,
        passwordController.text,
      );

      if (exito) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Inicio de sesión exitoso'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ReservaCanchas()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('❌ Correo o contraseña incorrectos'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print('⚠️ Error de conexión: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error de conexión con el servidor'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _cargando = false;
        _controller.stop(); // Detiene la rotación
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Iniciar Sesión")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _cargando
                ? RotationTransition(
                    turns: _controller,
                    child: const Icon(
                      Icons.sports_soccer,
                      color: Color(0xFF4CAF50),
                      size: 80,
                    ),
                  )
                : const Icon(
                    Icons.sports_soccer,
                    color: Color(0xFF4CAF50),
                    size: 80,
                  ),
            const SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Correo',
                filled: true,
                fillColor: const Color(0xFF2C2C2C),
                labelStyle: const TextStyle(color: Colors.white70),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                filled: true,
                fillColor: const Color(0xFF2C2C2C),
                labelStyle: const TextStyle(color: Colors.white70),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _cargando ? null : _iniciarSesion,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CAF50),
                foregroundColor: Colors.black,
              ),
              child: _cargando
                  ? const Text("Cargando...")
                  : const Text("Ingresar"),
            ),
            TextButton(
              onPressed: _cargando
                  ? null
                  : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterPage()),
                      );
                    },
              child: const Text(
                'Crear cuenta',
                style: TextStyle(color: Color(0xFF4CAF50)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
