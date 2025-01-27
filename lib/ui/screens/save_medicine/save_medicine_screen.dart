import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lembrete_remedio/main.dart';
import 'package:lembrete_remedio/models/models.dart';
import 'package:provider/provider.dart';
import 'package:timezone/timezone.dart' as tz;

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

  Future<void> scheduleDailyAlarm(Medicine medicine) async {
    // Configuração da notificação para Android
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'daily_alarm_channel', // ID do canal
      'Alarme Diário', // Nome do canal
      channelDescription: 'Notificação para alarme diário',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    // Converta o TimeOfDay para DateTime
    final now = DateTime.now();
    final alarmTime = DateTime(
      now.year,
      now.month,
      now.day,
      medicine.time.hour,
      medicine.time.minute,
    );

    // Se o horário já passou hoje, agende para o próximo dia
    final scheduleTime = alarmTime.isBefore(now)
        ? alarmTime.add(const Duration(days: 1))
        : alarmTime;

    // Agendar a notificação diária
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0, // ID da notificação
      'TOMAR REMÉDIO', // Título
      'Está na hora de tomar o remédio ${medicine.name}', // Corpo da notificação
      tz.TZDateTime.from(scheduleTime, tz.local),
      platformChannelSpecifics,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time, // Repetição diária
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle, 
    );
  }

  @override
  Widget build(BuildContext context) {
    void closeNavigator() => Navigator.pop(context);

    return Consumer<AppViewModel>(builder: (context, viewModel, child) {
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
                      if (_selectedTime24Hour != null) {
                        timeController.text = _selectedTime24Hour!.format(context);
                      } 
                      _focusNode.unfocus();
                  },
                ),
                const SizedBox(height: 24,),
                ElevatedButton(
                  onPressed: () {
                    if (_selectedTime24Hour != null) {
                      final newMedicine = Medicine(
                        name: medicineNameController.text, 
                        time: _selectedTime24Hour!, 
                        createdAt: DateTime.now().millisecondsSinceEpoch
                      );
                      viewModel.startIntent(SaveMedicineIntent(newMedicine));
                      scheduleDailyAlarm(newMedicine);
                    }
                    closeNavigator();
                  },
                  child: const Text('Criar lembrete'),
                ),
              ],
          ),
        ),
      );
    });
  }
}