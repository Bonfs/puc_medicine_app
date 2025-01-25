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
  final timeController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    medicineNameController.dispose();
    timeController.dispose();
    _focusNode.dispose();
  }

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
                const Text('Horário da medicação'),
                TextFormField(
                  controller: timeController,
                  decoration: const InputDecoration(labelText: 'HH:MM'),
                  focusNode: _focusNode,
                  onTap: () async {
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
                      if (_selectedTime24Hour != null) timeController.text = "${_selectedTime24Hour!.hour}:${_selectedTime24Hour!.minute}";
                      _focusNode.unfocus();
                  },
                ),
                const SizedBox(height: 24,),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Criar lembrete'),
                ),
              ],
          ),
        ),
      );
    });
  }
}