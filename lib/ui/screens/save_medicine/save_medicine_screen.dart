import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/core.dart';

class SaveMedicineScreen extends StatefulWidget {
  const SaveMedicineScreen({super.key});

  @override
  State<SaveMedicineScreen> createState() => _SaveMedicineScreenState();
}

class _SaveMedicineScreenState extends State<SaveMedicineScreen> {
  final DateTime _now = DateTime.now();
  late TimeOfDay? _selectedTime24Hour;

  @override
  void initState() {
    super.initState();
    _selectedTime24Hour = TimeOfDay(hour: _now.hour, minute: _now.minute);
  }

  final medicineNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void closeNavigator() => Navigator.pop(context);

    return Consumer<AppViewModel>(builder: (context, state, child) {
      return SizedBox(
        height: 500,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              children: <Widget>[
                const SizedBox(height: 16),
                const Text('Nome da medicação'),
                TextFormField(
                  controller: medicineNameController,
                  decoration: const InputDecoration(labelText: 'Medicação'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insira o nome';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                const Text('Nome da medicação'),
                ElevatedButton(
                  onPressed: () async {
                      _selectedTime24Hour = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay(hour: _now.hour, minute: _now.minute),
                      builder: (BuildContext context, Widget? child) {
                        return MediaQuery(
                          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                          child: child!,
                        );
                      },
                    );
                  },
                  child: const Text('Close BottomSheet'),
                ),
              ],
          ),
        ),
      );
    });
  }
}