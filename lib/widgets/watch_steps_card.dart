import 'package:flutter/material.dart';

class WatchStepsCard extends StatelessWidget {
  final int steps;
  final String source;
  final String date;
  final String time;

  const WatchStepsCard({
    super.key,
    required this.steps,
    required this.source,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue[800]!,
            Colors.blue[900]!,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Ícone de passos
            Icon(
              Icons.directions_walk,
              color: Colors.white,
              size: 24,
            ),
            
            const SizedBox(height: 8),
            
            // Número de passos
            Text(
              steps.toString(),
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 4),
            
            // Label "passos"
            Text(
              'PASSOS',
              style: TextStyle(
                fontSize: 10,
                color: Colors.white.withOpacity(0.8),
                fontWeight: FontWeight.w500,
                letterSpacing: 1,
              ),
            ),
            
            const SizedBox(height: 8),
            
            // Barra de progresso
            LinearProgressIndicator(
              value: _calculateProgress(),
              backgroundColor: Colors.white.withOpacity(0.3),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              minHeight: 3,
            ),
            
            const SizedBox(height: 4),
            
            // Meta
            Text(
              '${(steps / 10000 * 100).toInt()}%',
              style: TextStyle(
                fontSize: 10,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
            
            const SizedBox(height: 8),
            
            // Data/hora
            Text(
              '$date $time',
              style: TextStyle(
                fontSize: 8,
                color: Colors.white.withOpacity(0.6),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  double _calculateProgress() {
    const goal = 10000;
    return (steps / goal).clamp(0.0, 1.0);
  }
} 