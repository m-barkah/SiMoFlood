import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        elevation: 0,
        title: const Text(
          'Tentang Aplikasi',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header blue gradient
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.blue.shade800, Colors.blue.shade900],
                ),
              ),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white24,
                    child: Icon(
                      Icons.person,
                      size: 60,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'SIMOFLOOD',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Sistem Monitoring Banjir',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Versi 1.0.0',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white60,
                    ),
                  ),
                ],
              ),
            ),
            
            // Profile information
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('Pengembang'),
                  _buildProfileItem(
                    icon: Icons.person,
                    title: 'Nama',
                    value: 'Muhammad Barkah AL-Gibran',
                  ),
                  _buildProfileItem(
                    icon: Icons.school,
                    title: 'NIM',
                    value: '2104498',
                  ),
                  _buildProfileItem(
                    icon: Icons.location_on,
                    title: 'Institusi',
                    value: 'Universitas Pendidikan Indonesia',
                  ),
                  
                  const SizedBox(height: 30),
                  _buildSectionTitle('Tentang Aplikasi'),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'SIMOFLOOD adalah aplikasi untuk memantau ketinggian air sungai, kecepatan arus air, dan kondisi cuaca secara real-time. Aplikasi ini menggunakan data dari sensor IoT yang terhubung ke Firebase untuk memberikan peringatan dini tentang potensi banjir.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                        height: 1.5,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 30),
                  _buildSectionTitle('Fitur Aplikasi'),
                  _buildFeatureItem('Monitoring ketinggian air sungai'),
                  _buildFeatureItem('Monitoring kecepatan arus air'),
                  _buildFeatureItem('Monitoring cuaca'),
                  _buildFeatureItem('Peringatan status banjir'),
                  _buildFeatureItem('Pembaruan data real-time'),
                ],
              ),
            ),
            
            // Copyright footer
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: Colors.grey[900],
              child: const Text(
                '© 2025 - Teknik Komputer Universitas Pendidikan Indonesia',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
  
  Widget _buildProfileItem({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue, size: 24),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white60,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildFeatureItem(String feature) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.blue, size: 18),
          const SizedBox(width: 12),
          Text(
            feature,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
} 