import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import "../models/transaction.dart";

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  TransactionList(this.transactions);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 400,
        child: ListView.builder(
          itemBuilder: (context, idx){
            return Card(
                child: Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 17),
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: Colors.lightBlue,
                    width: 2,
                  )),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    '₹ ${transactions[idx].cost.toStringAsFixed(2)}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.lightBlue[600]),
                  ),
                ),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(transactions[idx].title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          )),
                      Text(DateFormat().format(transactions[idx].date),
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                            color: Colors.grey,
                          )),
                    ])
              ],
            ));
          },
          itemCount: transactions.length,
        ));
  }
}
