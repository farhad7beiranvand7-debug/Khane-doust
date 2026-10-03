class Person {
  final String id;
  final String firstName;
  final String lastName;
  final int birthYear;
  final int birthMonth;
  final int birthDay;
  final String gender;
  final List<String> conditions;
  final bool isPregnant;
  final int? lmpYear;
  final int? lmpMonth;
  final int? lmpDay;

  Person({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.birthYear,
    required this.birthMonth,
    required this.birthDay,
    required this.gender,
    required this.conditions,
    required this.isPregnant,
    this.lmpYear,
    this.lmpMonth,
    this.lmpDay,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'birthYear': birthYear,
        'birthMonth': birthMonth,
        'birthDay': birthDay,
        'gender': gender,
        'conditions': conditions,
        'isPregnant': isPregnant,
        'lmpYear': lmpYear,
        'lmpMonth': lmpMonth,
        'lmpDay': lmpDay,
      };

  factory Person.fromJson(Map<String, dynamic> json) => Person(
        id: json['id'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        birthYear: json['birthYear'],
        birthMonth: json['birthMonth'],
        birthDay: json['birthDay'],
        gender: json['gender'],
        conditions: List<String>.from(json['conditions'] ?? []),
        isPregnant: json['isPregnant'] ?? false,
        lmpYear: json['lmpYear'],
        lmpMonth: json['lmpMonth'],
        lmpDay: json['lmpDay'],
      );
}
