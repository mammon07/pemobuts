import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 6), () {
      Navigator.of(context).pushReplacementNamed('/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54, // Background hitam ke abu-abu
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Kartu memanjang berwarna biru cyan
            Container(
              width: MediaQuery.of(context).size.width * 0.8, // Lebar kartu 80% dari lebar layar
              padding: EdgeInsets.symmetric(vertical: 48), // Jarak vertikal yang sama di atas dan bawah
              decoration: BoxDecoration(
                color: Color(0xFFB9E5E8), // Warna biru cyan
                borderRadius: BorderRadius.circular(16), // Radius sudut kartu
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Judul aplikasi di atas foto
                  Text(
                    'KalkulaThor',
                    style: TextStyle(
                      fontSize: 36, // Ukuran font lebih besar
                      fontWeight: FontWeight.w900, // Bold maksimal
                      fontFamily: 'BebasNeue', // Ganti dengan font Bebas Neue
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 16),
                  // Menampilkan foto dalam bentuk CircleAvatar
                  CircleAvatar(
                    radius: 40, // Ukuran avatar
                    backgroundImage: AssetImage('assets/images/ihza.jpeg'), // Ganti dengan path foto
                  ),
                  SizedBox(height: 16),
                  // Nama Pengguna
                  Text(
                    'Ihza Tawaqal', // Ganti dengan nama dinamis
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold, // Kembali ke bold default
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  // NIM Pengguna
                  Text(
                    '152022261', // Ganti dengan NIM dinamis
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal, // Kembali ke font normal
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 24),
                  SpinKitWave(
                    color: Colors.black,
                    size: 50.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
