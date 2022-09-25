DateTime findFirstDateOfTheWeek(DateTime date){
  return date.subtract(Duration(days: date.weekday - 1));
}