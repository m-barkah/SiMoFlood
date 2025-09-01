import 'package:firebase_database/firebase_database.dart';
import '../models/river_data.dart';

class FirebaseRealtimeService {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  final String _deviceId = '252833888';

  // Stream river data from Realtime Database
  Stream<RiverData> streamRiverData(String riverName) {
    return _database.child('devices').child(_deviceId).onValue.map((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      
      if (data != null) {
        // Convert sensor data
        final waterLevel = (data['jarak'] ?? 0).toDouble();
        final flowRate = (data['flowRate'] ?? 0).toDouble();
        final weatherValue = data['cuaca'] ?? 0;
        final totalLiters = (data['totalLiters'] ?? 0).toDouble();
        
        // Convert weather value (1/0) to Rain/No Rain
        final weatherCondition = weatherValue == 1 ? 'Hujan' : 'Tidak Hujan';
        
        // Determine status based on water level
        String status = 'Aman';
        if (waterLevel < 100) {
          status = 'Bahaya';
        } else if (waterLevel < 150) {
          status = 'Waspada';
        } else if (waterLevel < 200) {
          status = 'Siaga';
        }
        
        return RiverData(
          name: riverName,
          waterLevel: waterLevel,
          flowRate: flowRate,
          weatherCondition: weatherCondition,
          temperature: (data['temperature'] ?? 29).toDouble(),
          status: status,
          timestamp: DateTime.now(),
        );
      } else {
        // Return default data if no data exists
        return RiverData(
          name: riverName,
          waterLevel: 0,
          flowRate: 0,
          weatherCondition: 'Tidak Hujan',
          temperature: 29,
          status: 'Aman',
          timestamp: DateTime.now(),
        );
      }
    });
  }
} 