import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'widgets/chart.dart';
import 'widgets/addTransaction.dart';
import 'widgets/transactionList.dart';
import 'models/transaction.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.red[300],
          fontFamily: "Quicksand",
          textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                fontFamily: "OpenSans",
                fontWeight: FontWeight.bold,
                fontSize: 20,
              )),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                      fontFamily: "OpenSans",
                      fontWeight: FontWeight.bold,
                      fontSize: 20)))),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> transactions = [
    Transaction("t1", "Book", 180, DateTime.now()),
    Transaction("t2", "Shirt", 2000, DateTime.now()),
    Transaction(
        "t3", "Shoes", 4000, DateTime.now().subtract(Duration(days: 1))),
  ];

  List<Transaction> get weekTransactions {
    return transactions.where((element) {
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  bool displayActive = false;

  void toggleDisplay() {
    setState(() {
      displayActive = !displayActive;
    });
  }

  @override
  void addNewTransaction(String title, double amount, DateTime date) {
    final newTransaction =
        Transaction(DateTime.now().toString(), title, amount, date);

    setState(() {
      transactions.add(newTransaction);
    });
  }

  void deleteTransaction(String id) {
    setState(() {
      transactions.removeWhere((element) => element.id == id);
    });
  }

  void startNewTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return GestureDetector(
          onTap: () {},
          child: AddTransaction(addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final appBar = AppBar(
      title: Text("Expense Tracker"),
      actions: [
        TextButton(
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.white)),
            onPressed: () => startNewTransaction(context),
            child: Icon(Icons.add_circle_outline)),
      ],
    );

    final TransactionListVar = Container(
        height: (MediaQuery.of(context).size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.7,
        child: TransactionList(transactions, deleteTransaction));
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            if (isLandscape)
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Show"),
                    Switch(
                        value: displayActive,
                        onChanged: (context) => toggleDisplay()),
                  ]),
            if (!isLandscape)
              Container(
                  height: (MediaQuery.of(context).size.height -
                          appBar.preferredSize.height -
                          MediaQuery.of(context).padding.top) *
                      0.3,
                  child: Chart(weekTransactions)),
            if (!isLandscape) TransactionListVar,
            if (isLandscape)
              !displayActive
                  ? Container(
                      height: (MediaQuery.of(context).size.height -
                              appBar.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.7,
                      child: Chart(weekTransactions))
                  : TransactionListVar,
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: () => startNewTransaction(context),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
    );
  }
}
