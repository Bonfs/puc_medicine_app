import 'package:lembrete_remedio/models/models.dart';

sealed class AppIntent {}

class DeleteMedicineIntent extends AppIntent {
  final int index;

  DeleteMedicineIntent(this.index);
}

class GetRemoteMedicinesIntent extends AppIntent {}

class SaveMedicineIntent extends AppIntent {
  final Medicine newMedicine;

  SaveMedicineIntent(this.newMedicine);
}
