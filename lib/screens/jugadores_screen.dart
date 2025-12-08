import 'package:fl_impostor/data/players_data.dart';
import 'package:fl_impostor/theme/app_theme.dart';
import 'package:fl_impostor/widgets/widgets.dart';
import 'package:flutter/material.dart';

class JugadoresScreen extends StatefulWidget {
  const JugadoresScreen({Key? key}) : super(key: key);

  @override
  State<JugadoresScreen> createState() => _JugadoresScreenState();
}

class _JugadoresScreenState extends State<JugadoresScreen> {
  final myFormKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final Map<String, String> formValues = {'nombre': ''};

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _addPlayer() {
    if (!myFormKey.currentState!.validate()) {
      return;
    }

    String newPlayer = formValues['nombre']!.trim();

    if (currentPlayers.contains(newPlayer)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ese jugador ya existe'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() {
      currentPlayers.add(newPlayer);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Jugador "$newPlayer" añadido'),
        backgroundColor: AppTheme.action,
        duration: const Duration(milliseconds: 1000),
      ),
    );

    formValues['nombre'] = '';
    _nameController.clear();
  }

  void _deletePlayer(int index) {
    final deletedName = currentPlayers[index];
    setState(() {
      currentPlayers.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$deletedName eliminado'),
        backgroundColor: Colors.grey,
        duration: const Duration(milliseconds: 1000),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Configurar Equipo'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Center(
              child: Text(
                '${currentPlayers.length}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  offset: const Offset(0, 5),
                  blurRadius: 10,
                ),
              ],
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
            child: Form(
              key: myFormKey,
              child: Column(
                children: [
                  CustomTextFormField(
                    hintText: 'Ej: David, María...',
                    labelText: 'Nombre del Jugador',
                    icon: Icons.person_add_alt_1_outlined,
                    formProperty: 'nombre',
                    formValues: formValues,
                    controller: _nameController,
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton.icon(
                    onPressed: _addPlayer,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.action,
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 20,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    icon: const Icon(
                      Icons.add_circle_outline,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'AÑADIR AL JUEGO',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: currentPlayers.isEmpty
                ? _EmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.only(
                      top: 20,
                      left: 15,
                      right: 15,
                      bottom: 80,
                    ),
                    itemCount: currentPlayers.length,
                    itemBuilder: (context, index) {
                      final player = currentPlayers[index];
                      return _PlayerCard(
                        name: player,
                        onDelete: () => _deletePlayer(index),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _PlayerCard extends StatelessWidget {
  final String name;
  final VoidCallback onDelete;

  const _PlayerCard({required this.name, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppTheme.primary, 
          foregroundColor: Colors.white,
          child: Text(
            name.isNotEmpty ? name[0].toUpperCase() : '?', 
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline, color: Colors.grey),
          onPressed: onDelete,
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.groups_3_outlined, size: 100, color: Colors.grey[300]),
          const SizedBox(height: 20),
          Text(
            'No hay jugadores todavía',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[500],
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            '¡Añade a tus amigos arriba!',
            style: TextStyle(fontSize: 14, color: Colors.grey[400]),
          ),
        ],
      ),
    );
  }
}
