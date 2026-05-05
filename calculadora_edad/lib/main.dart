import 'package:flutter/material.dart';

void main() => runApp(const AppEdad());

// Raíz de la aplicación

class AppEdad extends StatelessWidget {
  const AppEdad({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de Edad',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const PantallaEdad(),
    );
  }
}


// Widget con estado (StatefulWidget)
class PantallaEdad extends StatefulWidget {
  const PantallaEdad({super.key});

  @override
  State<PantallaEdad> createState() => _PantallaEdadState();
}


class _PantallaEdadState extends State<PantallaEdad> {
  final _controller = TextEditingController();

  int? _edad;
  String? _error;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  void _calcular() {
    final texto = _controller.text.trim();
    final anio = int.tryParse(texto);
    final anioActual = DateTime.now().year;

    setState(() {
      if (anio == null) {
        _error = 'Ingresa un año válido';
        _edad = null;
      } else if (anio < 1900 || anio > anioActual) {
        _error = 'El año debe estar entre 1900 y $anioActual';
        _edad = null;
      } else {
        // Todo correcto → calcular edad
        _error = null;
        _edad = anioActual - anio;
      }
    });
  }



  // ── Interfaz ──
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de Edad'),
        backgroundColor: colors.primaryContainer,
        foregroundColor: colors.onPrimaryContainer,
      ),

      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              maxLength: 4,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Año de nacimiento',
                hintText: 'Ej: 1995',
                prefixIcon: const Icon(Icons.cake),
                errorText: _error,
              ),
            ),

            const SizedBox(height: 16),

            FilledButton.icon(
              onPressed: _calcular,
              icon: const Icon(Icons.calculate),
              label: const Text('Calcular edad'),
            ),

            const SizedBox(height: 24),

            if (_edad != null)
              Card(
                color: colors.secondaryContainer,
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Icon(
                        Icons.celebration,
                        size: 48,
                        color: colors.secondary,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Tu edad es de',
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        '$_edad años',
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colors.onSecondaryContainer,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}