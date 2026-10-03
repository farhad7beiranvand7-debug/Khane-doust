import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../domain/models/person.dart';
import '../../data/local_storage.dart';

class AddPersonScreen extends StatefulWidget {
  final VoidCallback onSaved;
  const AddPersonScreen({super.key, required this.onSaved});

  @override
  State<AddPersonScreen> createState() => _AddPersonScreenState();
}

class _AddPersonScreenState extends State<AddPersonScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();
  final _yearCtrl = TextEditingController();
  final _monthCtrl = TextEditingController();
  final _dayCtrl = TextEditingController();
  
  String _gender = 'مرد';
  bool _isPregnant = false;
  final List<String> _conditions = [];
  
  final LocalStorage _storage = LocalStorage();

  void _save() async {
    if (!_formKey.currentState!.validate()) return;

    final persons = await _storage.loadPersons();
    final newPerson = Person(
      id: const Uuid().v4(),
      firstName: _firstNameCtrl.text,
      lastName: _lastNameCtrl.text,
      birthYear: int.parse(_yearCtrl.text),
      birthMonth: int.parse(_monthCtrl.text),
      birthDay: int.parse(_dayCtrl.text),
      gender: _gender,
      conditions: _conditions,
      isPregnant: _gender == 'زن' ? _isPregnant : false,
    );

    persons.add(newPerson);
    await _storage.savePersons(persons);
    widget.onSaved();
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('افزودن عضو جدید')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            TextFormField(
              controller: _firstNameCtrl,
              decoration: const InputDecoration(labelText: 'نام', border: OutlineInputBorder()),
              validator: (v) => v!.isEmpty ? 'نام الزامی است' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _lastNameCtrl,
              decoration: const InputDecoration(labelText: 'نام خانوادگی', border: OutlineInputBorder()),
              validator: (v) => v!.isEmpty ? 'نام خانوادگی الزامی است' : null,
            ),
            const SizedBox(height: 24),
            const Text('تاریخ تولد شمسی:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(child: TextFormField(controller: _yearCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'سال (مثال: 1370)'))),
                const SizedBox(width: 8),
                Expanded(child: TextFormField(controller: _monthCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'ماه'))),
                const SizedBox(width: 8),
                Expanded(child: TextFormField(controller: _dayCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'روز'))),
              ],
            ),
            const SizedBox(height: 24),
            DropdownButtonFormField<String>(
              value: _gender,
              items: ['مرد', 'زن'].map((g) => DropdownMenuItem(value: g, child: Text(g))).toList(),
              onChanged: (v) => setState(() => _gender = v!),
              decoration: const InputDecoration(labelText: 'جنسیت', border: OutlineInputBorder()),
            ),
            if (_gender == 'زن') ...[
              SwitchListTile(
                title: const Text('آیا باردار هستید؟'),
                value: _isPregnant,
                onChanged: (v) => setState(() => _isPregnant = v),
              ),
            ],
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _save,
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(16)),
              child: const Text('ذخیره اطلاعات'),
            )
          ],
        ),
      ),
    );
  }
}
