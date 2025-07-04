class StepData {
  final int steps;
  final DateTime date;
  final String source;

  StepData({
    required this.steps,
    required this.date,
    required this.source,
  });

  factory StepData.fromJson(Map<String, dynamic> json) {
    return StepData(
      steps: json['steps'] ?? 0,
      date: DateTime.parse(json['date']),
      source: json['source'] ?? 'unknown',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'steps': steps,
      'date': date.toIso8601String(),
      'source': source,
    };
  }

  @override
  String toString() {
    return 'StepData{steps: $steps, date: $date, source: $source}';
  }
} 