import 'package:firebase_database/firebase_database.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_app/providers/data.dart';

class Transaction {
  int amount;
  DateTime date;

  bool moneyIn;
  String accountName;
  String id;

  Transaction({required this.amount,
    required this.date,
    required this.moneyIn,
    required this.accountName,
    required this.id});
}

class TransactionGroup {
  final String type;
  final int amount;

  const TransactionGroup(this.type, this.amount);
}

Future<void> pushExpenditure(Transaction newTransaction) async {
  return Future.value();
}

List<Transaction> filterTransactions(List<Transaction> transactions,
    {DateTime? filterDate,
      DateTime? filterDateOnly,
      DateTime? filterDateTo,
      bool? filterMoneyIn,
      String? filterPurpose,
      int? filterAmount}) {
  return [...transactions]..retainWhere((expenditure) {
    if (filterDate != null) {
      if (filterDate.compareTo(expenditure.date) > 0 &&
          !compareDays(filterDate, expenditure.date)) {
        return false;
      }
    }
    return true;
  })..retainWhere((expenditure) {
    if (filterDateOnly != null) {
      return (compareDays(filterDateOnly, expenditure.date));
    }
    return true;
  })..retainWhere((expenditure) {
    if (filterDateTo != null) {
      if (filterDateTo.compareTo(expenditure.date) < 0) {
        return false;
      }
    }
    return true;
  })..retainWhere((expenditure) {
    if (filterMoneyIn != null) {
      if (expenditure.moneyIn != filterMoneyIn) {
        return false;
      }
    }
    return true;
  });
}

void listenForTransactions(Function action) {
  action(
      [
        Transaction(amount: 100,
            date: DateTime.now(),
            accountName: 'Test',
            moneyIn: false,
            id: 'qweqrqwer'),
        Transaction(amount: 200,
            date: DateTime.now(),
            accountName: 'Test2',
            moneyIn: true,
            id: 'qw234qwer')
      ]);
}

Future<void> getTransactions(Function action) async {
  action(
      [
        Transaction(amount: 100,
            date: DateTime.now(),
            accountName: 'Test',
            moneyIn: false,
            id: 'qweqrqwer'),
        Transaction(amount: 200,
            date: DateTime.now(),
            accountName: 'Test2',
            moneyIn: true,
            id: 'qw234qwer')
      ]);
  return Future.value();
}

Future<void> deleteTransaction(String id) async {
  return Future.value();
}

String capitalizeFirstLetter(String string) {
  List<String> newString = string.split('');
  newString[0] = newString[0].toUpperCase();
  return newString.join();
}

bool compareDays(DateTime a, DateTime b) {
  return a.day == b.day && a.month == b.month && a.year == b.year;
}

class TransactionsGroupedByDates {
  DateTime date;
  List<Transaction> expenditures;

  TransactionsGroupedByDates({required this.date, required this.expenditures});

  int getTotalAmount() {
    if (expenditures.isNotEmpty) {
      return expenditures
          .map((e) => e.amount)
          .reduce((value, element) => value + element);
    }
    return 0;
  }
}

List<TransactionsGroupedByDates> groupedByDates(List<Transaction> data) {
  List<TransactionsGroupedByDates> groupedByDates = [];

  for (int i = 0; i < 7; i++) {
    DateTime date = DateTime.now().subtract(Duration(days: i));
    List<Transaction> filtered = filterTransactions(data, filterDateOnly: date);

    groupedByDates
        .add(TransactionsGroupedByDates(date: date, expenditures: filtered));
  }

  return groupedByDates..sort((a, b) => a.date.compareTo(b.date));
}

String getTransactionChangeInLast7Days(List<Transaction> data) {
  if (data.isNotEmpty) {
    List<TransactionsGroupedByDates> _groupedByDates = groupedByDates(data);
    int start = _groupedByDates
        .firstWhere((element) => element.expenditures.isNotEmpty)
        .getTotalAmount();
    int fin = _groupedByDates[_groupedByDates.length - 1].getTotalAmount();
    int result = (((fin - start) / start) * 100).round();
    String sign = result > 0 ? '+' : '';

    return '$sign$result%';
  }
  return '0%';
}

List<FlSpot> getSpots(List<Transaction> data) {
  if (data.isNotEmpty) {
    List<TransactionsGroupedByDates> _groupedByDates = groupedByDates(data);
    return List.generate(
        _groupedByDates.length,
            (index) =>
            FlSpot(index.toDouble(),
                _groupedByDates[index].getTotalAmount().toDouble()));
  }
  return [];
}

List<DateTime> getSpotDates(List<Transaction> data) {
  if (data.isNotEmpty) {
    List<DateTime> groups = [];
    for (int i = 0; i < 7; i++) {
      DateTime date = DateTime.now().subtract(Duration(days: i));
      groups.add(date);
    }

    return groups..sort((a, b) => b.compareTo(a));
  }
  return [];
}
