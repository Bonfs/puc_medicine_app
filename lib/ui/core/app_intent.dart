import 'package:lembrete_remedio/models/models.dart';

sealed class AppIntent {}

class DeleteMedicineIntent extends AppIntent {}

class GetRemoteMedicinesIntent extends AppIntent {}

class SaveMedicineIntent extends AppIntent {
  final Medicine newMedicine;

  SaveMedicineIntent(this.newMedicine);
}
