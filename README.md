# SIMOFLOOD - Sistem Monitoring Banjir

Aplikasi mobile untuk memantau status sungai dan potensi banjir secara real-time dengan Firebase Realtime Database/Firestore.

## Fitur

- Pantau ketinggian air sungai secara real-time
- Informasi kecepatan arus air
- Status cuaca terkini
- Peringatan status banjir (Aman, Siaga, Waspada, Bahaya)
- Detail monitoring untuk setiap sungai

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
      |-- flowRate: 5 (data dari sensor kecepatan arus air dalam L/m)
      |-- weatherCondition: 1 (data dari sensor cuaca: 1 = Hujan, 0 = Tidak Hujan)
      |-- temperature: 29 (data dari sensor suhu dalam celsius)
      |-- status: "Aman" (opsional, jika tidak ada akan dihitung otomatis)
      |-- timestamp: Timestamp (waktu data terakhir diperbarui)

status/
  |-- current/
      |-- status: "Aman" (Status umum: Aman, Siaga, Waspada, Bahaya)
```

Keterangan Status:
- **Aman** - ketinggian air < 100 cm
- **Siaga** - ketinggian air 100-150 cm
- **Waspada** - ketinggian air 150-180 cm
- **Bahaya** - ketinggian air > 180 cm

Nilai `weatherCondition` dari sensor (1 atau 0) akan dikonversi menjadi teks "Hujan" atau "Tidak Hujan" dalam aplikasi.

## Setup Project

1. Clone repository
2. Jalankan `flutter pub get`
3. Konfigurasikan Firebase menggunakan `flutterfire configure`
4. Update `firebase_options.dart` dengan konfigurasi Anda
5. Jalankan aplikasi dengan `flutter run`

## Screenshots

[Tambahkan screenshot aplikasi di sini]

## Penggunaan Gambar Sungai Cisadane

Untuk menampilkan gambar Sungai Cisadane pada aplikasi:

1. Simpan gambar Jembatan Sungai Cisadane yang diberikan ke dalam direktori `assets/images/` dengan nama file `sungai_cisadane.png`
2. Pastikan ekstensi file adalah `.png`
3. Jalankan aplikasi dengan perintah `flutter run`

Jika gambar tidak ditemukan, aplikasi akan tetap berjalan dengan menampilkan latar belakang gradient warna sebagai pengganti.
