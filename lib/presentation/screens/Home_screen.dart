import 'package:flutter/material.dart';
import '../../domain/models/person.dart';
import '../../data/local_storage.dart';
import '../../core/utils/jalali_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LocalStorage _storage = LocalStorage();
  List<Person> _family = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final data = await _storage.loadPersons();
    setState(() {
      _family = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('خانواده من'),
        centerTitle: true,
      ),
      body: _family.isEmpty
          ? const Center(child: Text('هنوز عضوی اضافه نشده است.'))
          : ListView.builder(
              itemCount: _family.length,
              itemBuilder: (context, index) {
                final person = _family[index];
                final ageStr = JalaliUtils.formatAge(
                  person.birthYear, person.birthMonth, person.birthDay);
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text('${person.firstName} ${person.lastName}'),
                    subtitle: Text('سن: $ageStr'),
                    onTap: () {
                      // Navigate to details
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Navigate to Add Person Screen
        },
        label: const Text('افزودن عضو'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
