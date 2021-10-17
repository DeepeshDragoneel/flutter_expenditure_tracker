import 'package:flutter/material.dart';
import './addTransaction.dart';
import './transactionList.dart';
import "../models/transaction.dart";

class UserTransaction extends StatefulWidget {
  const UserTransaction({Key? key}) : super(key: key);

  @override
  _UserTransactionState createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  final List<Transaction> transactions = [
    Transaction("t1", "Book", 180, DateTime.now()),
    Transaction("t2", "Shirt", 2000, DateTime.now()),
    Transaction("t3", "Shoes", 4000, DateTime.now()),
  ];

  @override
  void addNewTransaction(String title, double amount) {
    final newTransaction =
        Transaction(DateTime.now().toString(), title, amount, DateTime.now());

    setState(() {
      transactions.add(newTransaction);
    });
  }

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AddTransaction(addNewTransaction),
        TransactionList(transactions),
      ],
    );
  }
}
