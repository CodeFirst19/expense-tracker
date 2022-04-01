import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {

  final void Function(String, double) addHandler;

  NewTransaction({required this.addHandler});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitData() {
    final title = titleController.text;
    final amount = double.parse(amountController.text);

    if(title.isEmpty || amount <= 0) {
      return;
    }

    // widget helps to access the properties of the widget class (NewTransaction), even in my state class (current)
    // because after all, all this is just a single widget
    widget.addHandler(title, amount);

    // Close modal upon clicking add
    //This context arg here gives access to context related to my widget
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(elevation: 5, child: Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            decoration: const InputDecoration(labelText: 'Title'),
            controller: titleController,
            onSubmitted: (_) => submitData(),
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'Amount'),
            controller: amountController,
            keyboardType: TextInputType.number,
            onSubmitted: (_) => submitData(),
          ),
          TextButton(
              child: const Text('Add Transaction'),
              style: TextButton.styleFrom(primary: Colors.purple),
              onPressed: submitData,
          )
        ],
      ),
    ),
    );
  }
}
