import 'package:fl_impostor/routes/app_routes.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final menuOptions = AppRoutes.MenuOptions;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Menú Principal'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: 'impostorLogo',
                child: Image.asset(
                  'assets/Impostor.png',
                  height: 180,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'IMPOSTOR',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),

              // Generamos los botones dinámicamente según AppRoutes
              ...menuOptions.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                      ),
                    ),
                    icon: Icon(item.icon, size: 28),
                    label: Text(
                      item.name, 
                      style: const TextStyle(fontSize: 20)
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, item.route);
                    },
                  ),
                ),
              )).toList(),
            ],
          ),
        ),
      ),
    );
  }
}