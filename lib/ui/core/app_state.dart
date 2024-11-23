import 'package:lembrete_remedio/models/medicine.dart';

class AppState {
  final bool isLoading;
  final List<Medicine> medicines;
  final String? error;

  AppState({this.isLoading = false, this.medicines = const [], this.error});

  AppState copyWith({bool? isLoading, List<Medicine>? medicines, String? error}) {
    return AppState(
      isLoading: isLoading ?? this.isLoading,
      medicines: medicines ?? this.medicines,
      error: error ?? this.error,
    );
  }
}