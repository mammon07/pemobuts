import 'package:flutter/material.dart';
import 'login_page.dart';
import 'registration_page.dart';
import 'splash_screen.dart';
import 'home_page.dart'; // Pastikan HomePage tetap di sini
import 'calculator_page.dart'; // Impor CalculatorPage
import 'conversion_page.dart'; // Impor ConversionPage
import 'profile_page.dart'; // Impor ProfilePage
import 'notes_page.dart'; // Impor NotesPage
import 'package:device_preview/device_preview.dart';

void main() => runApp(
      DevicePreview(
        enabled: true,
        builder: (context) => MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter CRUD Demo',
      initialRoute: '/splash',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/splash':
            return fadeTransition(SplashScreen());
          case '/login':
            return slideTransition(LoginPage(), SlideDirection.right);
          case '/registration':
            return slideTransition(RegistrationPage(), SlideDirection.left);
          case '/home':
            return fadeTransition(HomePage()); // Menggunakan HomePage
          case '/calculator':
            return fadeTransition(CalculatorPage()); // Kalkulator
          case '/conversion':
            return fadeTransition(ConversionContent()); // Konversi
          case '/profile':
            return fadeTransition(ProfilePage()); // Profil
          case '/notes':
            return fadeTransition(NotesPage()); // Catatan
          default:
            return MaterialPageRoute(builder: (context) => LoginPage());
        }
      },
    );
  }

  PageRouteBuilder fadeTransition(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      transitionDuration: Duration(milliseconds: 1000),
    );
  }

  PageRouteBuilder slideTransition(Widget page, SlideDirection direction) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final offset = Offset(1.0, 0.0);
        final begin = direction == SlideDirection.left ? offset : -offset;
        final end = Offset.zero;
        final tween = Tween(begin: begin, end: end)
            .chain(CurveTween(curve: Curves.easeInOut));
        final slideAnimation = animation.drive(tween);

        return SlideTransition(position: slideAnimation, child: child);
      },
      transitionDuration: Duration(milliseconds: 500),
    );
  }
}

enum SlideDirection { left, right }
