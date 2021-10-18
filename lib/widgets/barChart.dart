import 'package:flutter/material.dart';

class BarChart extends StatelessWidget {
  final String day;
  final double cost;
  final double costPercentage;

  BarChart(this.day, this.cost, this.costPercentage);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        FittedBox(child: Text("₹${cost.toStringAsFixed(0)}")),
        Container(
            height: 60,
            width: 10,
            margin: EdgeInsets.all(5),
            child: Stack(
              children: [
                Container(
                    decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(15),
                )),
                FractionallySizedBox(
                  heightFactor: costPercentage,
                  child: Container(
                      decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(15),
                  )),
                )
              ],
            )),
        Text(day),
      ],
    ));
  }
}
