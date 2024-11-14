import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  // Menambahkan method untuk navigasi ke halaman login
  void _logout(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/login'); // Pastikan rute '/login' ada
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Background color set to black
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Color(0xFFB9E5E8),
                child: Icon(
                  Icons.person,
                  size: 60,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Ihza Tawaqal', // Ganti dengan nama pengguna dinamis jika diperlukan
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // White text color
                ),
              ),
              SizedBox(height: 10),
              Text(
                '152022261', // Ganti dengan email pengguna dinamis jika diperlukan
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[400], // Gray text color for email
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () => _logout(context), // Aksi logout
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  backgroundColor: Colors.redAccent, // Warna tombol logout
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
