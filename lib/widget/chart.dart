import 'package:flutter/material.dart';
import 'package:personal_expenses/widget/ChartBar.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  //drust krdne listek ka pek hatbe la rozhakane hafta
  final List<Transaction> recentTransactions;
  Chart(this.recentTransactions);
  List<Map<String, Object>> get groupeTransactionValue {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(
        Duration(days: index),
      );

      double totalsum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++)
        if (recentTransactions[i].date.day == weekday.day &&
            recentTransactions[i].date.month == weekday.month &&
            recentTransactions[i].date.year == weekday.year) {
          totalsum += recentTransactions[i].amount;
        }

      return {
        'day': DateFormat.E().format(weekday).substring(0, 2),
        'amount': totalsum
      };
    }).reversed.toList();
  }

  double get totalspending {
    return groupeTransactionValue.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Card(
        elevation: 6,
        margin: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: groupeTransactionValue.map((data) {
            return Container(
              width: 50,
              child: ChartBar(
                (data['day'] as String),
                (data['amount'] as double),
               totalspending==0.0?0.0: (data['amount'] as double) / totalspending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
