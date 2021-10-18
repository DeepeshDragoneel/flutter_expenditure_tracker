import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import "../models/transaction.dart";

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;
  TransactionList(this.transactions, this.deleteTransaction);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 400,
        child: transactions.isEmpty
            ? Column(children: [
                Text("No transactions Yet!",
                    style: Theme.of(context).textTheme.title),
                Container(
                    height: 200,
                    margin: EdgeInsets.all(25),
                    child: Image.asset(
                      "assets/images/waiting.png",
                      fit: BoxFit.cover,
                    ))
              ])
            : ListView.builder(
                itemBuilder: (context, idx) {
                  return Card(
                      child: Row(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 17),
                        decoration: BoxDecoration(
                            border: Border.all(
                          color: Theme.of(context).primaryColor,
                          width: 2,
                        )),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          '₹ ${transactions[idx].cost.toStringAsFixed(2)}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              transactions[idx].title,
                              style: Theme.of(context).textTheme.title,
                            ),
                            Text(DateFormat().format(transactions[idx].date),
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: Colors.grey,
                                )),
                          ]),
                      Spacer(),
                      IconButton(
                          onPressed: () =>
                              deleteTransaction(transactions[idx].id),
                          icon: Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                          ))
                    ],
                  ));
                },
                itemCount: transactions.length,
              ));
  }
}
