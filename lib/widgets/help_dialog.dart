// Archivo: lib/widgets/help_dialog.dart
import 'package:flutter/material.dart';

void showHelpDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.help_outline, color: Colors.red),
            SizedBox(width: 10),
            Text('¿Cómo Jugar?', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Image(image: AssetImage('assets/Ayuda.png'), width: 260,),
              SizedBox(height: 15),
              _Step(num: '1', text: 'Configurad los jugadores y elegid categorías.'),
              _Step(num: '2', text: 'Pasad el móvil. Todos verán una palabra secreta menos EL IMPOSTOR.'),
              _Step(num: '3', text: 'Haced preguntas o descripciones sutiles sobre la palabra.'),
              _Step(num: '4', text: 'Al final del tiempo o de las rondas, ¡votad para atrapar al impostor!'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('¡Entendido!', style: TextStyle(color: Colors.red, fontSize: 16)),
          ),
        ],
      );
    },
  );
}

// Widget auxiliar para que quede bonita la lista de pasos
class _Step extends StatelessWidget {
  final String num;
  final String text;

  const _Step({required this.num, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 12,
            backgroundColor: Colors.red.shade100,
            child: Text(num, style: const TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }
}