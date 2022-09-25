import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/providers/transaction_provider.dart';
import 'package:flutter_app/utilities/colors.dart';
import 'package:flutter_app/pages/home.dart';
import 'package:flutter_app/widgets/app_bar.dart';
import 'package:flutter_app/widgets/circle_icon_button.dart';
import 'package:intl/intl.dart';

class TransactionHistory extends StatefulWidget {
  final List<Transaction> expenditures;
  final Function refresh;
  final Function showToast;

  const TransactionHistory(
      {Key? key,
      required this.expenditures,
      required this.refresh,
      required this.showToast})
      : super(key: key);

  @override
  _TransactionHistoryState createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  int limitPeriod = 0;
  String selectedWallet = 'All wallets';

  List<String> timePeriods = [
    'Today',
    'This week',
    'This month',
    'This year',
    'All time'
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Transaction> filtered = filterTransactions(
      widget.expenditures,
    );

    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [



              const SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.fromLTRB(13.0, 0, 13, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DropdownButton(
                            value: limitPeriod,
                            style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Color(prussianBlue),
                                fontFamily: 'Montserrat'),
                            items: List.generate(
                                timePeriods.length,
                                (index) => DropdownMenuItem<int>(
                                      child: Text(timePeriods[index]),
                                      value: index,
                                    )),
                            onChanged: (int? value) {
                              setState(() {
                                limitPeriod = value!;
                              });
                            },
                            iconDisabledColor: const Color(prussianBlue),
                            iconEnabledColor: const Color(prussianBlue),
                          ),
                        ],
                      )),
                  ...filtered
                      .map((expenditure) => Column(
                            children: [
                              HistoryListItem(
                                transaction: expenditure,
                                limitPeriod: limitPeriod,
                                showToast: widget.showToast,
                              ),
                              const Divider()
                            ],
                          ))
                      .toList(),
                  if (filtered.isEmpty)
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              'You have not spent anything ${timePeriods[limitPeriod]}'),
                        ],
                      ),
                    )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class HistoryListItem extends StatefulWidget {
  final Transaction transaction;
  final int limitPeriod;
  final Function showToast;

  const HistoryListItem({
    Key? key,
    required this.transaction,
    required this.limitPeriod,
    required this.showToast,
  }) : super(key: key);

  @override
  State<HistoryListItem> createState() => _HistoryListItemState();
}

class _HistoryListItemState extends State<HistoryListItem> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      focusColor: const Color(prussianBlue),
      selectedColor: const Color(prussianBlue),
      onTap: () {},
      onLongPress: () {
        //delete
      },
      title: Text(
        widget.transaction.accountName,
        style: const TextStyle(color: Color(mayaBlue), fontSize: 18),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            'KES ${widget.transaction.amount}',
            maxLines: 1,
            style: const TextStyle(
                color: Color(prussianBlue),
                fontSize: 25,
                fontWeight: FontWeight.w500),
          ),
          Row(
            children: [
              const Icon(
                Icons.account_balance_wallet_outlined,
                color: Color(prussianBlue),
                size: 16,
              ),
              Text(
                widget.transaction.id,
                style:
                    const TextStyle(color: Color(prussianBlue), fontSize: 16),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                  widget.limitPeriod != 0
                      ? DateFormat.yMMMMd('en_US')
                          .add_jm()
                          .format(widget.transaction.date)
                      : DateFormat.Hm('en_US').format(widget.transaction.date),
                  style:
                      const TextStyle(color: Color(prussianBlue), fontSize: 16))
            ],
          )
        ],
      ),

      enabled: true,
    );
  }
}
