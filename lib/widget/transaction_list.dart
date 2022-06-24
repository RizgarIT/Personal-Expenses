import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  Function deleteTx;
  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: transactions.isEmpty
          ? LayoutBuilder(builder: (ctx, constrain) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      height: constrain.maxHeight * 0.6,
                      child: Image.asset(
                        "assets/image/stopwatch.png",
                        fit: BoxFit.cover,
                      )),
                  Text("Not transactions add yet",
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                          fontWeight: FontWeight.bold))
                ],
              );
            })
          : ListView.builder(
              itemBuilder: (tx, index) {
                return Card(
                    elevation: 8,
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 35,
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FittedBox(
                            child: Text(
                              '\$' +
                                  transactions[index].amount.toStringAsFixed(2),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        transactions[index].title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text(
                        DateFormat.yMMMd().format(transactions[index].date),
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      trailing: MediaQuery.of(context).size.width > 450
                          ?FlatButton.icon(
                              onPressed: () {
                                deleteTx(transactions[index].id);
                              },
                              icon: Icon(Icons.delete),
                              textColor: Theme.of(context).errorColor,
                              label: Text("delete"),
                            ) 
                          : IconButton(
                              icon: Icon(Icons.delete),
                              color: Theme.of(context).errorColor,
                              onPressed: () {
                                deleteTx(transactions[index].id);
                              }),
                    ));
              },
              itemCount: transactions.length,
            ),
    );
  }
}
