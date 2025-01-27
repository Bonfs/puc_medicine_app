import 'package:flutter/material.dart';

class Medicine {
  final String? id;
  final String name;
  final TimeOfDay time;
  final int createdAt;


  Medicine({
    this.id,
    required this.name,
    required this.time,
    required this.createdAt,
  });

  factory Medicine.fromMap(Map<String, dynamic> map, String id) {
    return Medicine(
      id: id,
      name: map['name'] ?? '',
      createdAt: int.parse(map['createdAt'] ?? 0) ,
      time: TimeOfDay(hour:int.parse(map['time'].split(":")[0]),minute: int.parse(map['time'].split(":")[1])),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'time': "${time.hour}:${time.minute}",
      'createdAt': createdAt.toString(),
    };
  }

  Medicine copyWith({
    String? id,
    String? name,
    TimeOfDay? time,
    int? createdAt,
  }) {
    return Medicine(
      id: id ?? this.id,
      name: name ?? this.name,
      time: time ?? this.time,
      createdAt: createdAt ?? this.createdAt
    );
  }
}