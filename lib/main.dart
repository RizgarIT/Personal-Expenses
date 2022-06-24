import 'dart:io';
import 'package:flutter/material.dart';
import 'package:personal_expenses/widget/chart.dart';
import 'package:personal_expenses/widget/new_transaction.dart';
import 'package:personal_expenses/models/transaction.dart';
import 'package:personal_expenses/widget/transaction_list.dart';
import 'package:flutter/cupertino.dart';

void main(List<String> args) {
  runApp(setup());
}

class setup extends StatelessWidget {
  const setup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Personal Expenses',
        theme: ThemeData(
          primaryColor: Colors.pink[900],
          scaffoldBackgroundColor: Colors.blue[50],
          fontFamily: "Roboto",
          secondaryHeaderColor: Colors.amberAccent,
        ),
        home: myapp());
  }
}

class myapp extends StatefulWidget {
  @override
  State<myapp> createState() => _myappState();
}

class _myappState extends State<myapp> {
  bool _startchart = false;

  final List<Transaction> _transactions = [];

  List<Transaction> get _recentTransaction {
    return _transactions.where((txt) {
      return txt.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addnewtransaction(String txtitle, double txamount, DateTime datetime) {
    setState(() {
      _transactions.add(Transaction(
          id: DateTime.now().toString(),
          title: txtitle,
          amount: txamount,
          date: datetime));
    });
  }

  void _startnewtransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return newTransaction(_addnewtransaction);
      },
    );
  }

  void _deleteTansaction(String id) {
    setState(() {
      _transactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {


    final isLadscape =
        MediaQuery.of(context).orientation == Orientation.landscape;


    final  appBar =AppBar(
      actions: [
        IconButton(
            onPressed: () => _startnewtransaction(context),
            icon: Icon(Icons.add))
      ],
      title: Text(
        'Personal Expenses',
      ),
      backgroundColor: Theme.of(context).primaryColor,
    );
final txtwidget =Container(
                    height: (MediaQuery.of(context).size.height -
                            appBar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.4,
                    child: TransactionList(_transactions, _deleteTansaction));

                    final pageBody =SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
           if(isLadscape) Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Show Chart",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold)),
                Switch.adaptive(
                    value: _startchart,
                    onChanged: (val) {
                      setState(() {
                        _startchart = val;
                      });
                    })
              ],
            ),
          
            if(!isLadscape)Container(
                    height: (MediaQuery.of(context).size.height -
                            appBar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.4,
                    child: Chart(_recentTransaction)),
                     if(!isLadscape)txtwidget,
           if(isLadscape)
            _startchart
                ? Container(
                    height: (MediaQuery.of(context).size.height -
                            appBar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.4,
                    child: Chart(_recentTransaction))
                :txtwidget 
          ],
        ),
      );
    return Platform.isIOS? CupertinoPageScaffold(child: pageBody , navigationBar:CupertinoNavigationBar(middle:  Text(
        'Personal Expenses',
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
        GestureDetector(
          onTap:(){ _startnewtransaction(context);} ,
          child: Icon(CupertinoIcons.add),
        )
      ],),
      ),
      ): Scaffold(
      appBar: appBar,
      body: pageBody,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:Platform.isIOS ?Container(): FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
        onPressed: () => _startnewtransaction(context),
        backgroundColor: Theme.of(context).secondaryHeaderColor,
      ),
    );
  }
}
