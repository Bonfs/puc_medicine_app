import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lembrete_remedio/ui/core/app_view_model.dart';
import 'package:lembrete_remedio/ui/screens/home_screen/views.dart';
import 'package:lembrete_remedio/ui/screens/sign_in/views.dart';
import 'package:lembrete_remedio/ui/screens/sign_up/views.dart';
import 'package:lembrete_remedio/ui/screens/splash/views.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
      create: (context) => AppViewModel(),
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vitrine de Widgets - Pré-projeto',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/home': (context) => const HomeScreen(),
        '/sign_in': (context) => SignInScreen(),
        '/sign_up': (context) => SignUpScreen(),
      },
    );
  }
}
