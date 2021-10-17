import "package:flutter/material.dart";

class AddTransaction extends StatelessWidget {
  // const AddTransaction({Key? key}) : super(key: key);
  final titleChangeController = TextEditingController();
  final amountChangeController = TextEditingController();
  final Function addNewTransaction;
  AddTransaction(this.addNewTransaction);

  void submitTransaction() {
    if (titleChangeController.text.isEmpty ||
        amountChangeController.text.isEmpty) {
      return;
    }
    addNewTransaction(
        titleChangeController.text, double.parse(amountChangeController.text));
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
                onSubmitted: (_)=>submitTransaction(),
              ),
              TextField(
                decoration: InputDecoration(labelText: "Amount"),
                controller: amountChangeController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_)=>submitTransaction(),
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
