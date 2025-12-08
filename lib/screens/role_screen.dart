import 'package:fl_impostor/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:fl_impostor/data/players_data.dart';
import 'package:fl_impostor/data/game_state.dart';

class RolesScreen extends StatefulWidget {
  const RolesScreen({super.key});

  @override
  State<RolesScreen> createState() => _RolesScreenState();
}

class _RolesScreenState extends State<RolesScreen> {
  // Variables de Estado para controlar el flujo:
  int currentIndex = 0;
  bool isRevealed = false;
  bool haVistoRol = false;

  void showRole() {
    setState(() {
      isRevealed = true;
    });
    // Ocultar el rol después de 0.5 segundos (500 ms)
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        // mounted verifica que el widget siga en pantalla
        setState(() {
          isRevealed = false;
          haVistoRol = true;
        });
      }
    });
  }

  void nextPlayer() {
    setState(() {
      currentIndex++;
      haVistoRol = false;
      isRevealed = false;
    });
  }

  void finishGame() {
    // Navegar a la pantalla de inicio y borrar todo el historial anterior
    // para que al dar "atrás" no vuelvan al juego.
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentPlayerName = currentPlayers[currentIndex];
    final bool isLastPlayer = currentIndex == currentPlayers.length - 1;

    // Asignación de rol:
    final String playerRole = (currentPlayerName == impostorName)
        ? '¡ERES EL IMPOSTOR!'
        : keyword; // Si no es impostor, se le da la Palabra Clave

    return Scaffold(
      appBar: AppBar(
        title: Text('Jugador ${currentIndex + 1} de ${currentPlayers.length}'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 1. Mostrar quién debe mirar
            Text('Turno de:', style: TextStyle(fontSize: 20)),
            Text(
              currentPlayerName,
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 50),

            // 2. El botón de revelación
            ElevatedButton(
              onPressed: showRole,
              child: const Text(
                'VER MI PALABRA SECRETA',
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 50),

            // 3. Área de revelación (se muestra o se oculta)
            if (isRevealed)
              Text(
                playerRole,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                  color: Colors.deepPurple,
                ),
              )
            else if (!haVistoRol)
              const Text(
                'PULSA EL BOTÓN',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),

            if (haVistoRol && !isLastPlayer) const SizedBox(height: 80),

            // 4. Botón para avanzar (solo visible cuando el rol ya se ocultó)
            if (haVistoRol && !isLastPlayer)
              ElevatedButton(
                onPressed: nextPlayer,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: const Text(
                  'PASAR AL SIGUIENTE JUGADOR',
                  style: TextStyle(fontSize: 16),
                ),
              ),

            // 5. Botón para finalizar (visible solo en el último jugador)
            if (haVistoRol && isLastPlayer)
              ElevatedButton(
                onPressed: finishGame,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text(
                  'SALIR A LA PANTALLA DE INICIO',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
