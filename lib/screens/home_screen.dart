import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/location_service.dart';
import '../widgets/monitoring_card.dart';
import '../widgets/status_widget.dart';
import 'about_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LocationService _locationService = LocationService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();

    // Inisialisasi LocationService
    _locationService.init();

    // Debug Firebase Auth
    try {
      print('Firebase Auth instance: $_auth');
      print('Current user: ${_auth.currentUser}');
    } catch (e) {
      print('Error checking Firebase Auth: $e');
    }
  }

  @override
  void dispose() {
    _locationService.dispose(); // jangan lupa dispose untuk timer dan stream
    super.dispose();
  }

  // Perbaiki fungsi autentikasi
  Future<void> _authenticateUser() async {
    try {
      const email = 'bark@upi.edun'; // perbaiki email
      const password = 'barlenstudy098';

      // Cek apakah sudah login
      if (_auth.currentUser == null) {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        print('Authentication successful'); // tambah log untuk debugging
      } else {
        print('Already authenticated as: ${_auth.currentUser?.email}');
      }
    } catch (e) {
      print('Authentication error: $e');
      throw Exception('Gagal autentikasi: $e');
    }
  }

  // Modifikasi fetch function untuk menggunakan StreamBuilder
  Stream<Map<String, dynamic>> streamSensorValues() {
    print("streamSensorValues() dipanggil"); // <-- Debug 1
    final ref = FirebaseDatabase.instance.ref('devices/252833888/value');
    return ref.onValue.map((event) {
      print("onValue fired: ${event.snapshot.value}"); // <-- Debug 2
      if (event.snapshot.exists) {
        return Map<String, dynamic>.from(event.snapshot.value as Map);
      } else {
        throw Exception('Data tidak ditemukan');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print("🔄 HomeScreen build() dipanggil");
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder<void>(
        future: _authenticateUser(),
        builder: (context, authSnapshot) {
          if (authSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            );
          }

          if (authSnapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Error autentikasi: ${authSnapshot.error}',
                  style: const TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          // Setelah autentikasi berhasil, gunakan StreamBuilder untuk data sensor
          return SafeArea(
            child: StreamBuilder<LocationData>(
              stream: _locationService.locationStream,
              builder: (context, locationSnapshot) {
                final locationData =
                    locationSnapshot.data ??
                    LocationData(
                      city: 'Tangerang',
                      dateTime: DateTime.now(),
                      temperature: 29.0, // fallback temperature
                      formattedDate: DateFormat(
                        'd MMMM',
                      ).format(DateTime.now()),
                      iconUrl:
                          'https://openweathermap.org/img/wn/01d@2x.png', // fallback icon
                    );

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header with background image
                      Container(
                        height: 250,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.blue.shade900, Colors.black],
                          ),
                          // Menggunakan background image Sungai Cisadane
                          image: DecorationImage(
                            image: const AssetImage(
                              'assets/images/sungaicisadane.jpeg',
                            ),
                            fit: BoxFit.cover,
                            opacity: 0.7,
                            onError: (exception, stackTrace) {
                              // Gambar tidak ditemukan, gunakan gradient saja
                              print(
                                'Gambar sungai tidak ditemukan: $exception',
                              );
                            },
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Sistem Monitoring',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                          Icons.more_vert,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                                      const AboutScreen(),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${locationData.city}, ${locationData.formattedDate}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      // River section with StreamBuilder
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16),

                            // Ganti FutureBuilder dengan StreamBuilder
                            StreamBuilder<Map<String, dynamic>>(
                              stream: streamSensorValues(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                    ),
                                  );
                                }

                                if (snapshot.hasError) {
                                  return Text(
                                    'Error: ${snapshot.error}',
                                    style: const TextStyle(color: Colors.white),
                                  );
                                }

                                if (!snapshot.hasData) {
                                  return const Text(
                                    'Data kosong',
                                    style: TextStyle(color: Colors.white),
                                  );
                                }

                                final sensorData = snapshot.data!;
                                final val1 = sensorData['val1'] ?? 0;
                                final val2 =
                                    (sensorData['val2'] ?? 0).toDouble();

                                final val3 = sensorData['val3'] ?? 0;

                                String status = "Aman";

                                if (val1 < 30) {
                                  status = "Bahaya";
                                } else if (val1 >= 30 && val1 <= 60) {
                                  status = "Waspada";
                                } else {
                                  status =
                                      "Aman"; // default kalau lebih dari 60
                                }
                                // Debug log
                                print("val1: $val1 → Status: $status");

                                return Column(
                                  children: [
                                    GridView.count(
                                      shrinkWrap: true,
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 16,
                                      mainAxisSpacing: 16,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      children: [
                                        MonitoringCard(
                                          icon: Icons.water,
                                          title: 'Ketinggian Debit Air',
                                          value: '$val1 Cm',
                                          iconColor: Colors.blue,
                                        ),
                                        MonitoringCard(
                                          icon: Icons.speed,
                                          title: 'Kecepatan Arus Air',
                                          value:
                                              '${val2.toStringAsFixed(2)} L/m',

                                          iconColor: Colors.orange,
                                        ),
                                        MonitoringCard(
                                          icon:
                                              val3 == 1
                                                  ? Icons.water_drop
                                                  : Icons.wb_sunny,
                                          title: 'Keadaan Cuaca',
                                          value: val3 == 1 ? 'Hujan' : 'Cerah',
                                          iconColor:
                                              val3 == 1
                                                  ? Colors.blue
                                                  : Colors.yellow,
                                        ),
                                        MonitoringCard(
                                          icon:
                                              Icons
                                                  .thermostat, // tetap perlu untuk fallback
                                          iconWidget: Image.network(
                                            locationData.iconUrl,
                                            width: 40,
                                            height: 40,
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    Icon(Icons.error),
                                          ),
                                          title: 'Suhu Lingkungan',
                                          value:
                                              '${locationData.temperature.toStringAsFixed(1)} °C',
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 24),
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Status',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    StatusWidget(status: status),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
