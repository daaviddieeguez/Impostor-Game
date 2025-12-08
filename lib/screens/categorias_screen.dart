import 'dart:math';
// 1. IMPORTAMOS EL TEMA
import 'package:fl_impostor/theme/app_theme.dart'; 
import 'package:fl_impostor/data/game_data.dart';
import 'package:fl_impostor/data/game_state.dart';
import 'package:fl_impostor/data/players_data.dart';
import 'package:fl_impostor/screens/screens.dart';
import 'package:fl_impostor/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CategoriasScreen extends StatefulWidget {
  const CategoriasScreen({Key? key}) : super(key: key);

  @override
  State<CategoriasScreen> createState() => _CategoriasScreenState();
}

class _CategoriasScreenState extends State<CategoriasScreen> {
  
  final List<Map<String, String>> _categorias = [
    {'img': 'assets/AnimalesNaturaleza.png', 'name': 'Animales', 'key': 'Animales y Naturaleza'},
    {'img': 'assets/ComidaBebida.png', 'name': 'Comida', 'key': 'Comida y Bebida'},
    {'img': 'assets/VidaCotidiana.png', 'name': 'Vida Cotidiana', 'key': 'Vida Cotidiana'},
    {'img': 'assets/Navidad.png', 'name': 'Navidad', 'key': 'Misterio Navideño'},
    {'img': 'assets/CineTelevision.png', 'name': 'Cine y TV', 'key': 'Cine y Televisión'},
    {'img': 'assets/CuerpoSalud.png', 'name': 'Salud', 'key': 'Cuerpo y Salud'},
    {'img': 'assets/Deportes.png', 'name': 'Deportes', 'key': 'Deportes'},
    {'img': 'assets/Escuela.png', 'name': 'Escuela', 'key': 'Escuela'},
    {'img': 'assets/Fantasia.png', 'name': 'Fantasía', 'key': 'Fantasia'},
    {'img': 'assets/GenteFamosa.png', 'name': 'Famosos', 'key': 'Gente Famosa'},
    {'img': 'assets/VidaCotidiana.png', 'name': 'Juegos', 'key': 'Juegos'}, 
    {'img': 'assets/Marcas.png', 'name': 'Marcas', 'key': 'Marcas'},
    {'img': 'assets/ModaRopa.png', 'name': 'Moda', 'key': 'Moda y Ropa'},
    {'img': 'assets/MundoLugares.png', 'name': 'Lugares', 'key': 'Mundo y Lugares'},
    {'img': 'assets/Musica.png', 'name': 'Música', 'key': 'Musica'},
    {'img': 'assets/Personajes.png', 'name': 'Personajes', 'key': 'Personajes'},
    {'img': 'assets/Tecnologia.png', 'name': 'Tecnología', 'key': 'Tecnologia'},
    {'img': 'assets/TrabajoOficios.png', 'name': 'Trabajos', 'key': 'Trabajos y Oficios'},
    {'img': 'assets/Verano.png', 'name': 'Verano', 'key': 'Verano'},
    {'img': 'assets/Transporte.png', 'name': 'Transportes', 'key': 'Transportes'},
  ];

  final Set<String> _seleccionadas = {};

  void _toggleSelection(String key) {
    setState(() {
      if (_seleccionadas.contains(key)) {
        _seleccionadas.remove(key);
      } else {
        _seleccionadas.add(key);
      }
    });
  }

  void _iniciarJuego() {
    if (currentPlayers.length < 3) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          title: const Text(
            'Faltan jugadores',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          content: const Text(
            'Necesitas al menos 3 jugadores para iniciar.',
            style: TextStyle(color: Colors.black87),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Ok', style: TextStyle(color: AppTheme.primary)),
            )
          ],
        ),
      );
      return;
    }

    List<String> poolDePalabras = [];
    
    for (String key in _seleccionadas) {
      if (gameData.containsKey(key)) {
        poolDePalabras.addAll(gameData[key]!);
      }
    }

    if (poolDePalabras.isEmpty) return; 

    int keywordIndex = Random().nextInt(poolDePalabras.length);
    keyword = poolDePalabras[keywordIndex];

    if (_seleccionadas.length == 1) {
      selectedCategory = _seleccionadas.first; 
    } else {
      selectedCategory = "Mix de Categorías"; 
    }

    int impostorIndex = Random().nextInt(currentPlayers.length);
    impostorName = currentPlayers[impostorIndex];

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RolesScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Elige Categorías (${_seleccionadas.length})'),
        actions: [
          if (_seleccionadas.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_sweep),
              color: AppTheme.white, // Aseguramos que el icono sea blanco
              onPressed: () => setState(() => _seleccionadas.clear()),
            )
        ],
      ),
      
      floatingActionButton: _seleccionadas.isNotEmpty 
        ? FloatingActionButton.extended(
            onPressed: _iniciarJuego,
            backgroundColor: AppTheme.action, 
            icon: const Icon(Icons.play_arrow, color: AppTheme.white),
            label: const Text("JUGAR", style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.white)),
          )
        : null,
        
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.0, 
          ),
          cacheExtent: 500,
          itemCount: _categorias.length,
          itemBuilder: (context, index) {
            final item = _categorias[index];
            final isSelected = _seleccionadas.contains(item['key']);

            return GestureDetector(
              onTap: () => _toggleSelection(item['key']!),
              child: CustomCardCategoria(
                imageUrl: item['img']!,
                name: item['name']!,
                isSelected: isSelected,
              ),
            );
          },
        ),
      ),
    );
  }
}