

class RiverData {
  final String name;
  final double waterLevel;
  final double flowRate;
  final String weatherCondition;
  final double temperature;
  final String status;
  final DateTime timestamp;

  RiverData({
    required this.name,
    required this.waterLevel,
    required this.flowRate,
    required this.weatherCondition,
    required this.temperature,
    required this.status,
    required this.timestamp,
  });

  factory RiverData.fromJson(Map<String, dynamic> json) {
    return RiverData(
      name: json['name'] as String,
      waterLevel: (json['waterLevel'] as num).toDouble(),
      flowRate: (json['flowRate'] as num).toDouble(),
      weatherCondition: json['weatherCondition'] as String,
      temperature: (json['temperature'] as num).toDouble(),
      status: json['status'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'waterLevel': waterLevel,
      'flowRate': flowRate,
      'weatherCondition': weatherCondition,
      'temperature': temperature,
      'status': status,
      'timestamp': timestamp.toIso8601String(),
    };
  }
} 