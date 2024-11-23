import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:lembrete_remedio/models/models.dart';

class AppViewModel with ChangeNotifier {
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
        List<Medicine> medicinesCopy = List.from(_state.medicines);
        medicinesCopy.add(intent.newMedicine);
        _state = _state.copyWith(medicines: medicinesCopy);
        notifyListeners();
        break;
      case AddNewMedicineIntent():
    }
  }

  void updateMedicines(List<Medicine> newMedicines) {
    _state = _state.copyWith(medicines: newMedicines);
    notifyListeners();
  }

  @override
  void dispose() {
    _intentListener?.cancel();
    super.dispose();
  }
}