import 'package:flutter/foundation.dart';
import '../models/step_data.dart';
import '../services/health_connect_service.dart';

enum StepsState { initial, loading, loaded, error, noPermissions }

class StepsViewModel extends ChangeNotifier {
  final HealthConnectService _healthConnectService;
  
  StepsState _state = StepsState.initial;
  StepData? _stepData;
  String _errorMessage = '';
  bool _isHealthConnectAvailable = false;

  StepsViewModel(this._healthConnectService);

  // Getters
  StepsState get state => _state;
  StepData? get stepData => _stepData;
  String get errorMessage => _errorMessage;
  bool get isHealthConnectAvailable => _isHealthConnectAvailable;
  int get steps => _stepData?.steps ?? 0;
  String get source => _stepData?.source ?? 'N/A';

  // Initialize the ViewModel
  Future<void> initialize() async {
    _setState(StepsState.loading);
    
    try {
      // Check if Health Connect is available
      _isHealthConnectAvailable = await _healthConnectService.isAvailable();
      
      if (!_isHealthConnectAvailable) {
        _setState(StepsState.error);
        _errorMessage = 'Health Connect não está disponível neste dispositivo';
        return;
      }

      // Check permissions
      final hasPermissions = await _healthConnectService.hasPermissions();
      
      if (!hasPermissions) {
        _setState(StepsState.noPermissions);
        return;
      }

      // Load initial data
      await loadSteps();
      
    } catch (e) {
      _setState(StepsState.error);
      _errorMessage = 'Erro ao inicializar: $e';
    }
  }

  // Request permissions
  Future<void> requestPermissions() async {
    _setState(StepsState.loading);
    
    try {
      final granted = await _healthConnectService.requestPermissions();
      
      if (granted) {
        await loadSteps();
      } else {
        _setState(StepsState.noPermissions);
        _errorMessage = 'Permissões negadas pelo usuário';
      }
    } catch (e) {
      _setState(StepsState.error);
      _errorMessage = 'Erro ao solicitar permissões: $e';
    }
  }

  // Load steps data
  Future<void> loadSteps() async {
    _setState(StepsState.loading);
    
    try {
      final stepData = await _healthConnectService.getSimulatedSteps();
      
      if (stepData != null) {
        _stepData = stepData;
        _setState(StepsState.loaded);
      } else {
        _setState(StepsState.error);
        _errorMessage = 'Não foi possível carregar os dados de passos';
      }
    } catch (e) {
      _setState(StepsState.error);
      _errorMessage = 'Erro ao carregar dados: $e';
    }
  }

  // Refresh data
  Future<void> refresh() async {
    await loadSteps();
  }

  // Revoke permissions
  Future<void> revokePermissions() async {
    try {
      await _healthConnectService.revokePermissions();
      _setState(StepsState.noPermissions);
      _stepData = null;
    } catch (e) {
      _errorMessage = 'Erro ao revogar permissões: $e';
      notifyListeners();
    }
  }

  // Helper method to update state
  void _setState(StepsState newState) {
    _state = newState;
    notifyListeners();
  }

  // Get formatted date
  String get formattedDate {
    if (_stepData == null) return 'N/A';
    
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dataDate = DateTime(_stepData!.date.year, _stepData!.date.month, _stepData!.date.day);
    
    if (dataDate == today) {
      return 'Hoje';
    } else if (dataDate == today.subtract(const Duration(days: 1))) {
      return 'Ontem';
    } else {
      return '${_stepData!.date.day}/${_stepData!.date.month}/${_stepData!.date.year}';
    }
  }

  // Get formatted time
  String get formattedTime {
    if (_stepData == null) return 'N/A';
    return '${_stepData!.date.hour.toString().padLeft(2, '0')}:${_stepData!.date.minute.toString().padLeft(2, '0')}';
  }
} 