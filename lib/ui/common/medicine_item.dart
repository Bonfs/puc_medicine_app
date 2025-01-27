import 'package:flutter/material.dart';
import 'package:lembrete_remedio/models/models.dart';
import 'package:lembrete_remedio/ui/common/custom_list_file.dart';

class MedicineItem extends StatelessWidget {
  final Medicine _medicine;

  const MedicineItem(this._medicine, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          _MedicineBody(medicine: _medicine),
          const _MedicineItemButtons(),
        ],
      ),
    );
  }
}

class _MedicineBody extends StatelessWidget {
  final Medicine _medicine;

  const _MedicineBody({
    required Medicine medicine,
  }) : _medicine = medicine;


  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      height: 150,
      leading: Container(
        height: 150,
        width: 150,
        color: Colors.amber,
        child: Center(child: Text('${_medicine.name} imagem')),
      ),
      title: Text(_medicine.name),
      subtitle: Text('Todos os dias às ${_medicine.time.format(context)}'),
    
    );
  }
}

class _MedicineItemButtons extends StatelessWidget {
  const _MedicineItemButtons();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        TextButton(
          child: const Text('APAGAR'),
          onPressed: () {/* ... */},
        ),
        const SizedBox(width: 8),
        TextButton(
          child: const Text('EDITAR'),
          onPressed: () {/* ... */},
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}
