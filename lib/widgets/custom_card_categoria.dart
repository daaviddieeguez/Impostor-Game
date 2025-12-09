import 'package:fl_impostor/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CustomCardCategoria extends StatelessWidget {
  final String imageUrl;
  final String name;
  final bool isSelected;

  const CustomCardCategoria({
    super.key,
    required this.imageUrl,
    required this.name,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Color textColor = theme.textTheme.bodyMedium!.color!;
    final Color cardColor = theme.cardColor;
    
    // Si la tarjeta está seleccionada, usar los colores fijos de selección (verde)
    final Color nameBgColor = isSelected ? AppTheme.selectedBgLight : cardColor;
    final Color nameTextColor = isSelected ? AppTheme.selectedTextDark : textColor;

    // ELIMINAMOS EL ANIMATEDCONTAINER EXTERIOR
    return Card(
      // --- CAMBIO CLAVE: USAMOS EL BORDE DEL CARD ---
      // Si está seleccionado, definimos el borde verde. Si no, transparente.
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: isSelected 
            ? BorderSide(color: AppTheme.actionAccent, width: 4) 
            : BorderSide(color: Colors.transparent, width: 0),
      ),
      // --- MOVEMOS LA ELEVACIÓN Y SOMBRA AQUÍ ---
      elevation: isSelected ? 10 : 5,
      // MOVEMOS LA SOMBRA AQUÍ (para simular el AnimatedContainer)
      shadowColor: isSelected ? Colors.green.withOpacity(0.4) : null,
      
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                FadeInImage(
                  image: ResizeImage(AssetImage(imageUrl), width: 350),
                  placeholder: const AssetImage('assets/jar-loading.gif'),
                  fit: BoxFit.cover,
                  fadeInDuration: const Duration(milliseconds: 300),
                ),
                // Overlay sutil sobre la imagen
                Container(
                  color: Colors.black.withOpacity(0.1), 
                ),
                
                // Si la tarjeta está seleccionada, el check verde se muestra
                if (isSelected)
                  Container(
                    color: AppTheme.overlayDark.withOpacity(0.8), 
                    child: const Center(
                      child: Icon(Icons.check_circle, color: AppTheme.actionAccent, size: 40),
                    ),
                  ),
              ],
            ),
          ),
          // --- PARTE INFERIOR CON EL NOMBRE ---
          Container(
            padding: const EdgeInsets.all(10),
            color: nameBgColor, 
            alignment: Alignment.center,
            child: Text(
              name,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: nameTextColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}