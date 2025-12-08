import 'package:flutter/material.dart';

class AlertScreen extends StatelessWidget {
  const AlertScreen({Key? key}) : super(key: key);

  void displayDialog(BuildContext context) {
    print('Hola mundo');
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Alerta a navegantes'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Aqui va el contenido de la alerta'),
              SizedBox(height: 20,),
              FlutterLogo(size: 100,)
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cerrar')
              )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text('Mostrar alerta', style: TextStyle(fontSize: 20)),
          ),
          onPressed: () => displayDialog(context),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.close_outlined),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}
