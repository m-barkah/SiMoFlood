import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/river_data.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _useFirebase = true;
  FirebaseService() {
    
    // Try to access Firebase to determine if we can use it
    _firestore.collection('sensor').get().catchError((error) {
      // If we have an error accessing Firebase, use dummy data instead
      _useFirebase = false;
      print('Using dummy data due to Firebase error: $error');
    });
  }

  // Stream river data for a specific river
  Stream<RiverData> streamRiverData(String riverName) {
 
    return _firestore
        .collection('sensor')
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        final data = snapshot.docs.first.data();
        
        // Mengonversi data sensor
        final waterLevel = (data['jarak'] ?? 0).toDouble();
        final flowRate = (data['flowRate'] ?? 0).toDouble();
        final weatherValue = data['cuaca'] ?? 0;
        final totalLiters = (data['totalLiters'] ?? 0).toDouble();
        
        // Konversi nilai cuaca (1/0) menjadi Hujan/Tidak Hujan
        final weatherCondition = weatherValue == 1 ? 'Hujan' : 'Tidak Hujan';
        
        // Menentukan status berdasarkan ketinggian air
        String status = 'Aman';
        if (waterLevel < 100) {
          status = 'Bahaya';
        } else if (waterLevel < 150) {
          status = 'Waspada';
        } else if (waterLevel < 200) {
          status = 'Siaga';
        }
        
        // Menggunakan status dari Firebase jika tersedia
        final customStatus = data['status'];
        if (customStatus != null && customStatus.toString().isNotEmpty) {
          status = customStatus.toString();
        }
        
        return RiverData(
          name: riverName,
          waterLevel: waterLevel,
          flowRate: flowRate,
          weatherCondition: weatherCondition,
          temperature: 29 + (DateTime.now().hour % 5), // Simulasi suhu berdasarkan waktu
          status: status,
          timestamp: DateTime.now(),
        );
      } else {
        // Return default data if no documents exist
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

  // Stream all river data
  Stream<List<RiverData>> streamAllRivers() {

    return _firestore.collection('rivers').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        
        // Mengonversi data sensor
        final waterLevel = (data['waterLevel'] ?? 0).toDouble();
        final flowRate = (data['flowRate'] ?? 0).toDouble();
        final weatherValue = data['weatherCondition'] ?? 0;
        
        // Konversi nilai cuaca (1/0) menjadi Hujan/Tidak Hujan
        final weatherCondition = weatherValue == 1 ? 'Hujan' : 'Tidak Hujan';
        
        // Suhu dari sensor
        final temperature = (data['temperature'] ?? 29).toDouble();
        
        // Menentukan status berdasarkan ketinggian air
        String status = 'Aman';
        if (waterLevel > 180) {
          status = 'Bahaya';
        } else if (waterLevel > 150) {
          status = 'Waspada';
        } else if (waterLevel > 100) {
          status = 'Siaga';
        }
        
        // Menggunakan status dari Firebase jika tersedia
        final customStatus = data['status'];
        if (customStatus != null && customStatus.toString().isNotEmpty) {
          status = customStatus.toString();
        }
        
        return RiverData(
          name: doc.id,
          waterLevel: waterLevel,
          flowRate: flowRate,
          weatherCondition: weatherCondition,
          temperature: temperature,
          status: status,
          timestamp: data['timestamp'] != null 
              ? DateTime.fromMillisecondsSinceEpoch(data['timestamp']) 
              : DateTime.now(),
        );
      }).toList();
    });
  }

  // Stream status info
  Stream<String> streamStatus() {
    return _firestore
        .collection('status')
        .doc('current')
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists && snapshot.data() != null) {
        return snapshot.data()!['status'] ?? 'Aman';
      } else {
        return 'Aman';
      }
    });
  }
} 