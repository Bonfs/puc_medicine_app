import 'dart:async';
import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lembrete_remedio/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lembrete_remedio/ui/core/core.dart';

class AppViewModel with ChangeNotifier {
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  AppState _state = AppState();
  bool get isLoading => _state.isLoading;
  UnmodifiableListView<Medicine> get medicines => UnmodifiableListView(_state.medicines);
  String? get error => _state.error;
  
  final StreamController<AppIntent> _intentController = StreamController<AppIntent>();
  StreamSubscription<AppIntent>? _intentListener;

  AppViewModel() {
    _intentListener = _intentController.stream.listen((intent) => handleIntents(intent));
  }

  void startIntent(AppIntent intent) => handleIntents(intent);

  void handleIntents(AppIntent intent) {
    switch (intent) {
      case SaveMedicineIntent():
        _handleSaveMedicine(intent);
        break;
      case DeleteMedicineIntent():
      case GetRemoteMedicinesIntent():
        _handleGetRemoteMedicines();
        break;
    }
  }

  void _handleGetRemoteMedicines() async {
    _setLoading(true);
    QuerySnapshot querySnapshot =
      await _db.collection('users').doc(_auth.currentUser!.uid).collection('medicines').get();

    List<Medicine> medicines = [];
    for (var doc in querySnapshot.docs) {
      if (doc.data() != null) {
        medicines.add(Medicine.fromMap(doc.data() as Map<String, dynamic>));
      }
    } 
    _state = _state.copyWith(medicines: medicines, isLoading: false);
    notifyListeners();
  }

  void _handleSaveMedicine(SaveMedicineIntent intent) {
    List<Medicine> medicinesCopy = List.from(_state.medicines);
    _db
    .collection('users')
    .doc(_auth.currentUser!.uid)
    .collection('medicines')
    .add(intent.newMedicine.toMap())
    .then((event) {
      medicinesCopy.add(intent.newMedicine);
      _state = _state.copyWith(medicines: medicinesCopy);
      notifyListeners();
    });
  }

  void updateMedicines(List<Medicine> newMedicines) {
    _state = _state.copyWith(medicines: newMedicines);
    notifyListeners();
  }

  void _setLoading(bool isLoading) {
    _state = _state.copyWith(isLoading: isLoading);
    notifyListeners();
  }

  @override
  void dispose() {
    _intentListener?.cancel();
    super.dispose();
  }
}