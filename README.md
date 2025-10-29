# 📝 Laporan Praktikum: FutureBuilder dan Fitur Interaktif pada Flutter

## Tujuan:
1. Memahami penggunaan widget FutureBuilder untuk menampilkan data dari API secara asynchronous.
2. Mengimplementasikan fitur pull-to-refresh agar pengguna dapat memuat ulang data dengan mudah.
3. Menambahkan tombol scroll-to-top untuk meningkatkan kenyamanan navigasi pada daftar berita yang panjang.

### A. FutureBuilder adalah widget Flutter yang digunakan untuk membangun tampilan (UI) berdasarkan hasil dari operasi asynchronous seperti pengambilan data dari API.
Widget ini secara otomatis memperbarui tampilan sesuai dengan status proses:
    a. ConnectionState.waiting → Menampilkan indikator loading saat data masih dimuat.
    b. snapshot.hasError → Menampilkan pesan kesalahan jika terjadi error.
    c. snapshot.hasData → Menampilkan data jika berhasil diterima dari API.
  Dengan FutureBuilder, pengembang tidak perlu menulis logika asynchronous secara manual, karena Flutter akan mengatur pembaruan UI sesuai perubahan state Future.

### B. RefreshIndicator digunakan untuk membuat fitur pull-to-refresh, yaitu aksi menarik layar ke bawah untuk memuat ulang data.
Ketika gesture tersebut dilakukan, fungsi onRefresh akan dipanggil, biasanya untuk memanggil ulang API agar data diperbarui.

### C. ScrollController dan FloatingActionButton
    a. ScrollController digunakan untuk memantau posisi scroll pada daftar (ListView).
    b. Dengan logika kondisi tertentu (misalnya offset > 300 pixel), aplikasi dapat menampilkan tombol FloatingActionButton secara otomatis.
    c. Tombol ini, saat ditekan, akan memanggil fungsi animateTo(0) untuk menggulir layar kembali ke atas dengan animasi halus.

### Hasil Program:
1. Saat aplikasi dijalankan, daftar berita berhasil dimuat dari API dan ditampilkan pada layar.
2. Pengguna dapat menarik layar ke bawah (pull-to-refresh) untuk memuat data terbaru.
3. Ketika pengguna menggulir ke bawah, muncul tombol panah ke atas di pojok kanan bawah. Saat tombol ditekan, tampilan akan kembali ke bagian atas daftar artikel dengan animasi.

#### Gambar 1
![alt text](https://github.com/Fauzanjundillah/Mobile-1/blob/main/dart1.png?raw=true)

#### Gambar 2
![alt text](https://github.com/Fauzanjundillah/Mobile-1/blob/main/dart%202.png?raw=true)
