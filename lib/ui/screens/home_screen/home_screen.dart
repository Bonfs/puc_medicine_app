import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lembrete_remedio/main.dart';
import 'package:lembrete_remedio/ui/core/app_intent.dart';
import 'package:lembrete_remedio/ui/core/app_view_model.dart';
import 'package:lembrete_remedio/ui/common/widgets.dart';
import 'package:lembrete_remedio/ui/screens/home_screen/home_drawer.dart';
import 'package:lembrete_remedio/ui/screens/home_screen/home_floating_button.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
      final viewModel = Provider.of<AppViewModel>(context, listen: false);
      viewModel.startIntent(GetRemoteMedicinesIntent());
    });   
 }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AppViewModel>();
    return Scaffold(
        appBar: const CustomAppBar(),
        drawer: const HomeDrawer(),
        body: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: viewModel.medicines.length,
          itemBuilder: (BuildContext context, int index) => MedicineItem(index, viewModel.medicines[index]),
          separatorBuilder: (BuildContext context, int index) => const Divider(),
        ),
        floatingActionButton: const HomeFloatingButton(),
      );
  }
}
