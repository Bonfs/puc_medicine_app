import 'package:flutter/material.dart';
import 'package:lembrete_remedio/ui/common/widgets.dart';
import 'package:lembrete_remedio/ui/core/app_view_model.dart';
import 'package:lembrete_remedio/ui/screens/home_screen/views.dart';
import 'package:provider/provider.dart';

void main() => runApp(ChangeNotifierProvider(
      create: (context) => AppViewModel(),
      child: const MyApp(),
    ));

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
      home: const Scaffold(
        appBar: CustomAppBar(),
        drawer: HomeDrawer(),
        body: HomeScreen(),
        floatingActionButton: HomeFloatingButton(),
      ),
    );
  }
}
