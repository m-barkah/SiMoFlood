# SIMOFLOOD - Sistem Monitoring Banjir

Aplikasi mobile untuk memantau status sungai dan potensi banjir secara real-time dengan Firebase Realtime Database/Firestore.

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


© Muhammad Barkah AL Gibran 
Universitas Pendidikan Indonesia 
2025 
