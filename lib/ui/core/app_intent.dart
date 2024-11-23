import 'package:lembrete_remedio/models/models.dart';

sealed class AppIntent {}

class AddNewMedicineIntent extends AppIntent {}

class SaveMedicineIntent extends AppIntent {
  final Medicine newMedicine;

  SaveMedicineIntent(this.newMedicine);
}
