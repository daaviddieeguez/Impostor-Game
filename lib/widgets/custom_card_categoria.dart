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
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: isSelected 
            ? Border.all(color: AppTheme.actionAccent, width: 4) 
            : Border.all(color: Colors.transparent, width: 0),
        boxShadow: [
          if (isSelected)
            BoxShadow(color: Colors.green.withOpacity(0.4), blurRadius: 10, spreadRadius: 2)
        ],
      ),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: isSelected ? 10 : 5,
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
                  if (isSelected)
                    Container(
                      color: AppTheme.overlayDark,
                      child: const Center(
                        child: Icon(Icons.check_circle, color: AppTheme.white, size: 40),
                      ),
                    ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              color: isSelected ? AppTheme.selectedBgLight : AppTheme.white,
              alignment: Alignment.center,
              child: Text(
                name,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: isSelected ? AppTheme.selectedTextDark : AppTheme.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}