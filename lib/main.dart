import 'package:flutter/material.dart';
import 'package:lembrete_remedio/ui/core/app_intent.dart';
import 'package:lembrete_remedio/models/medicine.dart';
import 'package:lembrete_remedio/ui/core/app_view_model.dart';
import 'package:lembrete_remedio/ui/screens/home_screen/home_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(
  ChangeNotifierProvider(
    create: (context) => AppViewModel(),
    child: const MyApp(),
  )
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vitrine de Widgets',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          primary: true,
          backgroundColor: Colors.orange,
          title: const Text('App de remédio'),
        ),
        body: const HomeScreen(),
        floatingActionButton: Consumer<AppViewModel>(
          builder: (context, state, child) {
            return FloatingActionButton(
              onPressed: () => state.startIntent(SaveMedicineIntent(Medicine(name: 'tylenol'))),
              tooltip: 'adicionar novo remédio',
              child: const Icon(Icons.add),
            );
          }
        ),
      ),
    );
  }
}
