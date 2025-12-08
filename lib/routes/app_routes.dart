import 'package:fl_impostor/models/models.dart';
import 'package:fl_impostor/screens/screens.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const initialRoute = 'home';

  static final MenuOptions = <MenuOption>[
    // 1. Opción para configurar jugadores
    MenuOption(
      route: 'jugadores',
      icon: Icons.group_outlined,
      name: 'Configurar Jugadores',
      screen: const JugadoresScreen(),
    ),
    
    // 2. Opción para Jugar (Lleva a la pantalla de Categorías)
    MenuOption(
      route: 'categorias',
      icon: Icons.play_circle_fill_outlined,
      name: 'Jugar',
      screen: const CategoriasScreen(),
    ),
  ];

  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};
    
    // Añadimos la ruta 'home' manualmente para que la app sepa dónde empezar,
    // pero NO la añadimos a la lista MenuOptions para que no salga el botón.
    appRoutes.addAll({'home': (BuildContext context) => const HomeScreen()});

    for (final option in MenuOptions) {
      appRoutes.addAll({option.route: (BuildContext context) => option.screen});
    }

    return appRoutes;
  }

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => const AlertScreen());
  }
}