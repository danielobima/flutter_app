import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/providers/transaction_provider.dart';
import 'package:flutter_app/utilities/colors.dart';
import 'package:intl/intl.dart';

import '../providers/data.dart';

class Home extends StatefulWidget {
  final int availableBalance;
  final List<Transaction> transactions;
  final String username;
  final Function refresh;

  const Home(
      {Key? key,
      required this.availableBalance,
      required this.transactions,
      required this.username,
      required this.refresh})
      : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String userName = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Your balance',
                  style: TextStyle(color: Color(mayaBlue), fontSize: 18)),
              const AutoSizeText(
                'KES 30,000.00',
                maxLines: 1,
                style: TextStyle(
                    color: Color(prussianBlue),
                    fontSize: 38,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(24)),
                              border: Border.all(
                                color: Colors.red,
                                width: 1,
                              )),
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(16.0, 16, 16, 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                AutoSizeText(
                                  'KES 300',
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 26,
                                  ),
                                ),
                                AutoSizeText(
                                  'spent in the last 7 days',
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: Color(prussianBlue),
                                    fontSize: 16,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )),
                  Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(24)),
                              border: Border.all(
                                color: Colors.green,
                                width: 1,
                              )),
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(16.0, 16, 16, 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                AutoSizeText(
                                  'KES 300',
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 26,
                                  ),
                                ),
                                AutoSizeText(
                                  'received in the last 7 days',
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: Color(prussianBlue),
                                    fontSize: 16,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Color(0xffC6EAFF),
                            borderRadius:
                                BorderRadius.all(Radius.circular(24))),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16.0, 8, 16, 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Transactions in the last 7 days',
                                style: TextStyle(
                                  color: Color(prussianBlue),
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: 120,
                                  child: SimpleLineChart(
                                    spots: getSpots(widget.transactions),
                                    dates: getSpotDates(widget.transactions),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const AutoSizeText(
                    'Recent transactions',
                    maxLines: 1,
                    style: TextStyle(
                        color: Color(prussianBlue),
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'SEE ALL',
                      style: TextStyle(color: Color(mayaBlue)),
                    ),
                  )
                ],
              ),
              ListBody(
                children: List.generate(widget.transactions.length, (index) {
                  return Column(
                    children: [
                      TransactionListItem(
                        transaction: widget.transactions[index],
                      ),
                      const Divider()
                    ],
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TransactionListItem extends StatelessWidget {
  final Transaction transaction;

  const TransactionListItem({Key? key, required this.transaction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              transaction.accountName,
              style: const TextStyle(
                  color: Color(prussianBlue), fontWeight: FontWeight.w500),
            ),
            Text(
              DateFormat.yMMMMd('en_US').add_jm().format(transaction.date),
              style: const TextStyle(
                  color: Color(prussianBlue), fontWeight: FontWeight.w400),
            ),
          ],
        ),
        Text(
          '${transaction.moneyIn ? '+' : '-'}KES ${transaction.amount}',
          style: TextStyle(
              color: transaction.moneyIn ? Colors.green : Colors.red,
              fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}

class SimpleLineChart extends StatefulWidget {
  final List<FlSpot> spots;
  final List<DateTime> dates;

  const SimpleLineChart({Key? key, required this.spots, required this.dates})
      : super(key: key);

  @override
  State<SimpleLineChart> createState() => _SimpleLineChartState();
}

class _SimpleLineChartState extends State<SimpleLineChart> {
  String getDate(DateTime date) {
    return '${date.day}${getDayOfMonthSuffix(date.day)}';
  }

  @override
  Widget build(BuildContext context) {
    double highest = widget.spots.isNotEmpty
        ? widget.spots
            .map((e) => e.y)
            .reduce((value, element) => value > element ? value : element)
        : 20;
    double lowest = widget.spots.isNotEmpty
        ? widget.spots
            .map((e) => e.y)
            .reduce((value, element) => value < element ? value : element)
        : 10;
    double interval = ((highest - lowest) / 5);

    return LineChart(
      LineChartData(
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
              spots: widget.spots,
              dotData: FlDotData(
                  show: true,
                  getDotPainter: (spot, doub, data, integer) =>
                      FlDotCirclePainter(
                          color: const Color(mayaBlue),
                          strokeColor: const Color(mayaBlue))),
              isCurved: false,
              color: const Color(mayaBlue),
              shadow: const Shadow(
                  color: Color(mayaBlue),
                  blurRadius: 3,
                  offset: Offset(0, 1.5)))
        ],
        gridData: FlGridData(
            show: true, drawVerticalLine: false, horizontalInterval: interval),
        titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                    getTitlesWidget: (val, meta) => Text(
                          widget.dates.isNotEmpty
                              ? getDate(widget
                                  .dates[widget.dates.length - 1 - val.toInt()])
                              : '10th',
                          style: const TextStyle(
                              color: Color(prussianBlue),
                              fontWeight: FontWeight.w500,
                              fontSize: 12),
                        ),
                    showTitles: true,
                    interval: 1)),
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false))),
      ),
    );
  }
}
