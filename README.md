# SIMOFLOOD - Sistem Monitoring Banjir

SiMoFlood adalah aplikasi mobile android untuk memantau ketinggian air sungai, kecepatan arus air, dan kondisi cuaca secara real-time. Aplikasi SiMoFlood menggunakan data dari sensor IoT yang terhubung ke Firebase untuk memberikan peringatan dini tentang potensi banjir.

## Fitur

- Pantau ketinggian air sungai secara real-time
- Informasi kecepatan arus air
- Status cuaca terkini
- Pemantauan suhu menggunakan API
- Peringatan status banjir (Aman, Siaga, Waspada, Bahaya)
- Detail monitoring untuk aliran sungai

## Teknologi

- Flutter untuk pengembangan cross-platform
- Firebase Firestore untuk database real-time
- StreamBuilder untuk pembaruan data secara otomatis

## Struktur Data Firebase

Struktur koleksi Firestore yang digunakan:

```
rivers/
  |-- Sungai Cisadane/
      |-- waterLevel: 123 (data dari sensor ketinggian air dalam cm)
      |-- flowRate: 19.45 (data dari sensor kecepatan arus air dalam L/m)
      |-- weatherCondition: 1 (data dari sensor cuaca: 1 = Hujan, 0 = Tidak Hujan)
      |-- temperature: 30.5 (data dari API suhu, dalam celsius)
      |-- status: "Aman/Waspada/BAHAYA" (Berdasarkan Hasil Pembacaan Prototipe)
      |-- timestamp: Timestamp (waktu data terakhir diperbarui)

status/
  |-- current/
      |-- status: "Aman" (Status umum: Aman, Siaga, Waspada, Bahaya)
```

Keterangan Status Berdasarkan Jarak Sensor Kepada Tinggi Muka Air:
- **Aman** - ketinggian air > 60 cm
- **Waspada** - ketinggian air 31-60 cm
- **Bahaya** - ketinggian air < 30 cm

## About Apps
Versi Aplikasi 0.0.1  
Pengembang Apllikasi:  
© Muhammad Barkah AL Gibran  
2104498  
Universitas Pendidikan Indonesia  
2025  