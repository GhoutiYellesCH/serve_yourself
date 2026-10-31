
import 'package:serveyourself/models/meal.dart';


class Daymodel {
  final List<String> dayMeals; // pour stoker le id des meals corespandant au jour
  final DateTime date; // pour stoker la date 
  Daymodel({required this.date,required this.dayMeals});
}
