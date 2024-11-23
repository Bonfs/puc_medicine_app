import 'package:flutter/material.dart';
import 'package:lembrete_remedio/ui/core/app_view_model.dart';
import 'package:lembrete_remedio/ui/common/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AppViewModel>();
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: viewModel.medicines.length,
      itemBuilder: (BuildContext context, int index) => MedicineItem(viewModel.medicines[index]),
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
