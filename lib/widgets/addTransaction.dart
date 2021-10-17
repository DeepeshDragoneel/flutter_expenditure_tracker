import "package:flutter/material.dart";

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

  void submitTransaction() {
    if (titleChangeController.text.isEmpty ||
        amountChangeController.text.isEmpty) {
      return;
    }
    widget.addNewTransaction(
        titleChangeController.text, double.parse(amountChangeController.text));
    Navigator.of(context).pop();
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
              TextButton(
                onPressed: submitTransaction,
                child: Text("Add"),
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.blue)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
