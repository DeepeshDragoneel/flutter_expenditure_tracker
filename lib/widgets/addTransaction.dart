import "package:flutter/material.dart";
import "package:intl/intl.dart";

class AddTransaction extends StatefulWidget {
  // const AddTransaction({Key? key}) : super(key: key);
  final Function addNewTransaction;
  AddTransaction(this.addNewTransaction);

  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final titleChangeController = TextEditingController();

  final amountChangeController = TextEditingController();

  DateTime? datePicked;

  void submitTransaction() {
    if (titleChangeController.text.isEmpty ||
        amountChangeController.text.isEmpty ||
        datePicked == null) {
      return;
    }
    widget.addNewTransaction(titleChangeController.text,
        double.parse(amountChangeController.text), datePicked);
    Navigator.of(context).pop();
  }

  void openDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        datePicked = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: "Title"),
                controller: titleChangeController,
                onSubmitted: (_) => submitTransaction(),
              ),
              TextField(
                decoration: InputDecoration(labelText: "Amount"),
                controller: amountChangeController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => submitTransaction(),
              ),
              Container(
                height: 80,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        datePicked == null
                            ? ("No date Chosed!")
                            : 'Date: ${DateFormat.yMd().format(datePicked!)}',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      OutlinedButton(
                          onPressed: openDatePicker,
                          child: Text(
                            "Choose Date",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all(
                                  Theme.of(context).primaryColor),
                              side: MaterialStateProperty.all(BorderSide(
                                  color: Theme.of(context).primaryColor))))
                    ]),
              ),
              ElevatedButton(
                onPressed: submitTransaction,
                child: Text("Add"),
                // style: ButtonStyle(
                //     foregroundColor: MaterialStateProperty.all(Colors.blue)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
