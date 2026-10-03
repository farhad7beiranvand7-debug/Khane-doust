import 'package:shamsi_date/shamsi_date.dart';

class JalaliUtils {
  static Map<String, int> calculateExactAge(int year, int month, int day) {
    final today = Jalali.now();
    int ageYears = today.year - year;
    int ageMonths = today.month - month;
    int ageDays = today.day - day;

    if (ageDays < 0) {
      ageMonths--;
      ageDays += 30; 
    }
    if (ageMonths < 0) {
      ageYears--;
      ageMonths += 12;
    }

    return {
      'years': ageYears < 0 ? 0 : ageYears,
      'months': ageMonths < 0 ? 0 : ageMonths,
      'days': ageDays < 0 ? 0 : ageDays,
    };
  }

  static String formatAge(int year, int month, int day) {
    final age = calculateExactAge(year, month, day);
    if (age['years']! > 0) return '${age['years']} سال';
    if (age['months']! > 0) return '${age['months']} ماه';
    return '${age['days']} روز';
  }
}
