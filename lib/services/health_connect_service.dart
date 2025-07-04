import 'dart:async';
import 'dart:math';
import '../models/step_data.dart';

class HealthConnectService {
  static const String _namespace = 'contador_pasos';
  bool _isInitialized = false;
  bool _hasPermissions = false;
  final Random _random = Random();

  HealthConnectService() {
    // Simular inicialização
    _isInitialized = true;
  }

  Future<bool> initialize() async {
    // Simular delay de inicialização
    await Future.delayed(const Duration(seconds: 1));
    _isInitialized = true;
    return true;
  }

  Future<bool> isAvailable() async {
    // Simular que o Health Connect está disponível
    await Future.delayed(const Duration(milliseconds: 500));
    return true;
  }

  Future<bool> requestPermissions() async {
    // Simular solicitação de permissões
    await Future.delayed(const Duration(seconds: 2));
    _hasPermissions = true;
    return true;
  }

  Future<bool> hasPermissions() async {
    // Simular verificação de permissões
    await Future.delayed(const Duration(milliseconds: 300));
    return _hasPermissions;
  }

  Future<StepData?> getStepsForLast24Hours() async {
    if (!_isInitialized) {
      await initialize();
    }
    
    if (!_hasPermissions) {
      return null;
    }
    
    try {
      // Simular delay de leitura de dados
      await Future.delayed(const Duration(seconds: 1));
      
      // Simular dados de passos (entre 1000 e 15000 passos)
      final steps = 1000 + _random.nextInt(14000);
      
      // Simular diferentes fontes
      final sources = [
        'com.google.android.wearable.healthservices',
        'com.samsung.android.health',
        'com.fitbit.FitbitMobile',
        'com.garmin.android.apps.connectmobile',
        'Health Connect'
      ];
      
      final source = sources[_random.nextInt(sources.length)];
      
      return StepData(
        steps: steps,
        date: DateTime.now(),
        source: source,
      );
    } catch (e) {
      print('Erro ao ler dados de passos: $e');
      return null;
    }
  }

  Future<void> revokePermissions() async {
    // Simular revogação de permissões
    await Future.delayed(const Duration(milliseconds: 500));
    _hasPermissions = false;
  }

  // Método para simular dados reais (para demonstração)
  Future<StepData?> getSimulatedSteps() async {
    await Future.delayed(const Duration(seconds: 1));
    
    // Simular dados mais realistas
    final now = DateTime.now();
    final hour = now.hour;
    
    // Simular mais passos durante o dia
    int baseSteps;
    if (hour >= 6 && hour <= 18) {
      // Horário ativo: mais passos
      baseSteps = 5000 + _random.nextInt(8000);
    } else {
      // Horário noturno: menos passos
      baseSteps = 500 + _random.nextInt(2000);
    }
    
    final sources = [
      'com.google.android.wearable.healthservices',
      'com.samsung.android.health',
      'com.fitbit.FitbitMobile',
      'com.garmin.android.apps.connectmobile',
      'Health Connect'
    ];
    
    return StepData(
      steps: baseSteps,
      date: now,
      source: sources[_random.nextInt(sources.length)],
    );
  }
} 