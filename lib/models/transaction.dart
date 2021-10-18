import 'package:flutter/material.dart';

class Transaction {
  final String id;
  final String title;
  final double cost;
  final DateTime date;

  Transaction( this.id, this.title, this.cost, this.date);
}
