import 'package:expense_planner/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {

  final List<Transaction> transactions;
  final void Function(String) deleteHandler;

  TransactionList({required this.transactions, required this.deleteHandler});

  @override
  Widget build(BuildContext context) {
    return  transactions.isEmpty ? LayoutBuilder(builder: (ctx, constraints) {
      return Column(
        children: [
          Text('No transactions added yet!', style: Theme.of(context).textTheme.headline6,),
          const SizedBox(height: 20,),
          Container(
              height: constraints.maxHeight * 0.6,
              child: Image.asset('assets/images/waiting.png', fit: BoxFit.cover,)),
        ],
      );
    })
     : ListView.builder(
      itemBuilder: (ctx, index) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
          elevation: 5,
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: Padding(padding: EdgeInsets.all(6),child: FittedBox(child: Text('R${transactions[index].amount}'))
              ),
            ),
            title: Text(transactions[index].title, style: Theme.of(context).textTheme.headline6,),
            subtitle: Text(DateFormat.yMMMd().format(transactions[index].date)),
            trailing: MediaQuery.of(context).size.width > 460
                ? TextButton.icon(
                onPressed: () => deleteHandler(transactions[index].id),
                icon: const Icon(Icons.delete),
                label: const Text('Delete'),
                style: TextButton.styleFrom(primary: Theme.of(context).errorColor),
            )
                : IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => deleteHandler(transactions[index].id),
              color: Theme.of(context).errorColor,),
          ),
        );
      },
      itemCount: transactions.length,
     );
  }
}
