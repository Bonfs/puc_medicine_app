import 'package:flutter/material.dart';
import 'package:lembrete_remedio/models/models.dart';
import 'package:lembrete_remedio/ui/core/core.dart';
import 'package:lembrete_remedio/ui/screens/save_medicine/view.dart';
import 'package:provider/provider.dart';

class HomeFloatingButton extends StatelessWidget {
  const HomeFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(builder: (context, state, child) {
      return FloatingActionButton(
        onPressed: () => {
          // state.startIntent(SaveMedicineIntent(Medicine(name: 'tylenol'))),
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return SaveMedicineScreen();
            },
          )
        },
        tooltip: 'adicionar novo remédio',
        child: const Icon(Icons.add),
      );
    });
  }
}
