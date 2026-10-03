import '../models/person.dart';
import '../../core/utils/jalali_utils.dart';

class CareItem {
  final String title;
  final String timeText;
  final bool isHighPriority;

  CareItem(this.title, this.timeText, {this.isHighPriority = false});
}

class CareEngine {
  static List<CareItem> getUpcomingCares(Person person) {
    final age = JalaliUtils.calculateExactAge(
        person.birthYear, person.birthMonth, person.birthDay);
    List<CareItem> cares = [];

    // مراقبت‌های پایه سنی
    if (age['years']! >= 30) {
      cares.add(CareItem('غربالگری فشار خون و دیابت', 'سالی یک‌بار'));
    }
    
    // شرایط زمینه‌ای
    if (person.conditions.contains('دیابت')) {
      cares.add(CareItem('بررسی قند خون ناشتا (FBS)', 'هر ۳ ماه', isHighPriority: true));
      cares.add(CareItem('معاینه چشم (شبکیه)', 'سالی یک‌بار'));
    }
    if (person.conditions.contains('فشار خون بالا')) {
      cares.add(CareItem('اندازه‌گیری دوره‌ای فشار خون', 'هر ماه', isHighPriority: true));
    }

    // بارداری
    if (person.isPregnant && person.lmpYear != null) {
      cares.add(CareItem('مراقبت‌های دوره‌ای بارداری و سونوگرافی', 'طبق تقویم بارداری', isHighPriority: true));
    }

    if (cares.isEmpty) {
      cares.add(CareItem('مراقبت خاصی در پیش نیست', 'سبک زندگی سالم را رعایت کنید'));
    }

    return cares;
  }
}
