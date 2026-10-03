import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../domain/models/person.dart';

class LocalStorage {
  static const String _key = 'family_members';

  Future<void> savePersons(List<Person> persons) async {
    final prefs = await SharedPreferences.getInstance();
    final String data = jsonEncode(persons.map((p) => p.toJson()).toList());
    await prefs.setString(_key, data);
  }

  Future<List<Person>> loadPersons() async {
    final prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString(_key);
    if (data == null) return [];
    
    final List<dynamic> decoded = jsonDecode(data);
    return decoded.map((item) => Person.fromJson(item)).toList();
  }
}
