import 'package:flutter/material.dart';
import 'package:lembrete_remedio/models/models.dart';
import 'package:lembrete_remedio/ui/core/core.dart';
import 'package:provider/provider.dart';

class HomeFloatingButton extends StatelessWidget {
  const HomeFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(builder: (context, state, child) {
      return FloatingActionButton(
        onPressed: () =>
            state.startIntent(SaveMedicineIntent(Medicine(name: 'tylenol'))),
        tooltip: 'adicionar novo remédio',
        child: const Icon(Icons.add),
      );
    });
  }
}
