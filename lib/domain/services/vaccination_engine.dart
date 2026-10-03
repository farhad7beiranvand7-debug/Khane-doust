import '../models/person.dart';
import '../../core/utils/jalali_utils.dart';

class VaccinationItem {
  final String title;
  final String dueAge;

  VaccinationItem(this.title, this.dueAge);
}

class VaccinationEngine {
  static List<VaccinationItem> getUpcomingVaccines(Person person) {
    final age = JalaliUtils.calculateExactAge(
        person.birthYear, person.birthMonth, person.birthDay);
    
    List<VaccinationItem> vaccines = [];
    
    if (age['years']! == 0 && age['months']! == 0) {
      vaccines.add(VaccinationItem('بدو تولد (ب ث ژ، فلج اطفال، هپاتیت ب)', 'بدو تولد'));
    }
    if (age['years']! == 0 && age['months']! < 2) {
      vaccines.add(VaccinationItem('دو ماهگی (پنج‌گانه، فلج اطفال)', '۲ ماهگی'));
    }
    if (age['years']! == 0 && age['months']! < 6) {
      vaccines.add(VaccinationItem('شش ماهگی', '۶ ماهگی'));
    }
    if (age['years']! < 1 || (age['years']! == 1 && age['months']! == 0)) {
       vaccines.add(VaccinationItem('دوازده ماهگی (MMR)', '۱۲ ماهگی'));
    }

    return vaccines;
  }
}
