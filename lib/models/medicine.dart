import 'package:flutter/material.dart';
import 'package:lembrete_remedio/models/models.dart';

class Medicine {
  final String name;
  final TimeOfDay time;


  Medicine({
    required this.name,
    required this.time,
  });

  factory Medicine.fromMap(Map<String, dynamic> map) {
    return Medicine(
      name: map['name'] ?? '',
      time: TimeOfDay(hour:int.parse(map['time'].split(":")[0]),minute: int.parse(map['time'].split(":")[1])),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'time': "${time.hour}:${time.minute}",
    };
  }
}