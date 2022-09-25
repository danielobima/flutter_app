import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

const int periodBalance = 3000;

const int changeInSavingsPercentage = 25;

const List<String> limitPeriods = [
  'Daily',
  'Weekly',
  'Monthly',
  'Yearly'
];

String? userID;

List sampleExpenditures = [
  {
    'Lunch': {'Amount': 300, 'Date': DateTime.now()}
  },
  {
    'Transport': {'Amount': 300, 'Date': DateTime.now()}
  },
  {
    'Airtime': {'Amount': 300, 'Date': DateTime.now()}
  },
  {
    'Other': {'Amount': 300, 'Date': DateTime.now()}
  }
];
List sampleHistory = [
  {
    'Lunch': {'Amount': 300, 'Date': DateTime.now(), 'Account': 'Cash'}
  },
  {
    'Transport': {'Amount': 300, 'Date': DateTime.now(), 'Account': 'Mpesa'}
  },
  {
    'Airtime': {'Amount': 300, 'Date': DateTime.now(), 'Account': 'Cash'}
  },
];

const Map walletData = {
  'Cash': {'balance': 3000, 'limitPeriod': 'Weekly', 'limit': 1000},
  'Mpesa': {'balance': 3000, 'limitPeriod': 'Weekly', 'limit': 1000},
};




bool checkSignIn() {


  return true;
}

Future<String> getUserName() async{
  return Future.value('Daniel');
}

String getDayOfMonthSuffix(int dayNum) {
  if(!(dayNum >= 1 && dayNum <= 31)) {
    throw Exception('Invalid day of month');
  }

  if(dayNum >= 11 && dayNum <= 13) {
    return 'th';
  }

  switch(dayNum % 10) {
    case 1: return 'st';
    case 2: return 'nd';
    case 3: return 'rd';
    default: return 'th';
  }
}

