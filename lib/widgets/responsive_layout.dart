import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? watch;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.watch,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Determinar o tipo de dispositivo baseado no tamanho da tela
        if (isWatchScreen(constraints)) {
          return watch ?? mobile;
        }
        return mobile;
      },
    );
  }

  bool isWatchScreen(BoxConstraints constraints) {
    // Smartwatches geralmente têm telas menores e mais quadradas
    final width = constraints.maxWidth;
    final height = constraints.maxHeight;
    final aspectRatio = width / height;
    
    // Smartwatch: tela pequena e mais quadrada
    return width < 400 && height < 400 && aspectRatio > 0.8 && aspectRatio < 1.2;
  }
}

// Widget específico para smartwatch
class WatchLayout extends StatelessWidget {
  final Widget child;
  
  const WatchLayout({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: child,
      ),
    );
  }
} 