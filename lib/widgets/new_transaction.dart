import 'package:expense_planner/widgets/adaptive_flat_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';

class NewTransaction extends StatefulWidget {

  final void Function(String, double, DateTime) addHandler;

  NewTransaction({required this.addHandler});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  void _submitData() {
    final title = _titleController.text;
    final amount = double.parse(_amountController.text);

    if(title.isEmpty || amount <= 0 || _selectedDate == null) {
      return;
    }

    // widget helps to access the properties of the widget class (NewTransaction), even in my state class (current)
    // because after all, all this is just a single widget
    widget.addHandler(title, amount, _selectedDate!);

    // Close modal upon clicking add
    //This context arg here gives access to context related to my widget
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime.now()
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(elevation: 5, child: Container(
        padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // const CupertinoTextField(placeholder: 'Title',),
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: _titleController,
              onSubmitted: (_) => _submitData(),
            ),
            // const CupertinoTextField(placeholder: 'Amount',),
            TextField(
              decoration: const InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),
            ),
            Container(
              height: 80,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                        _selectedDate == null
                            ? 'No Date Chosen'
                            : 'Chosen Date: ${DateFormat.yMd().format(_selectedDate!)}'
                    ),
                  ),
                 AdaptiveFlatButton(text: 'Choose Date', presentDatePickerHandler: _presentDatePicker)
                ],
              ),
            ),
            ElevatedButton(
                onPressed: _submitData,
                child: const Text('Add Transaction'),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
                    foregroundColor: MaterialStateProperty.all(Theme.of(context).textTheme.button?.color)
                ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}
