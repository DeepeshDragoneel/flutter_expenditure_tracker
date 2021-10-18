import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker_app/widgets/barChart.dart';
import "package:intl/intl.dart";
import "../models/transaction.dart";

class Chart extends StatelessWidget {
  final List<Transaction> weekTransactions;

  Chart(this.weekTransactions);

  List<Map<String, Object>> get groupTransactionsWeekly {
    double totalTransaction = 0.00;
    return List.generate(7, (index) {
      final today = DateTime.now().subtract(Duration(days: index));
      totalTransaction = 0.00;
      for (var i = 0; i < weekTransactions.length; i++) {
        if (weekTransactions[i].date.day == today.day &&
            weekTransactions[i].date.month == today.month &&
            weekTransactions[i].date.year == today.year) {
          // print('${today}->${weekTransactions[i].date}');
          totalTransaction += weekTransactions[i].cost;
        }
      }
      final dayTransaction = {
        "day": DateFormat.E().format(today).substring(0, 1),
        "cost": totalTransaction
      };
      // print(dayTransaction);
      return dayTransaction;
    }).reversed.toList();
  }

  double get spentPercentage {
    return groupTransactionsWeekly.fold(
        0.00,
        (previousValue, element) =>
            previousValue += (element["cost"] as double));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 6,
        margin: EdgeInsets.all(20),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupTransactionsWeekly
                .map((transaction) => Flexible(
                      fit: FlexFit.tight,
                      child: (BarChart(
                          transaction["day"].toString(),
                          (transaction["cost"] as double),
                          spentPercentage == 0.0
                              ? 0.0
                              : (transaction["cost"] as double) /
                                  spentPercentage)),
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}
