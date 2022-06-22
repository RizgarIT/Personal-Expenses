import 'package:flutter/material.dart';
import 'package:personal_expenses/widget/chart.dart';
import 'package:personal_expenses/widget/new_transaction.dart';
import 'package:personal_expenses/models/transaction.dart';
import 'package:personal_expenses/widget/transaction_list.dart';
 



void main(List<String> args) {

  runApp(setup());

}

class setup extends StatelessWidget {
  const setup({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      title: 'Personal Expenses',
      theme: ThemeData(
        primaryColor: Colors.pink[900],
        
          scaffoldBackgroundColor:Colors.blue[50],
           fontFamily: "Roboto",
secondaryHeaderColor: Colors.amberAccent,
           
      ),
      home:myapp()
      );
  }
}



class myapp extends StatefulWidget {
 



  @override
  State<myapp> createState() => _myappState();
}
 

class _myappState extends State<myapp> {

  final List<Transaction> _transactions = [
    // Transaction( "t1", "New Shose", 69.99, DateTime.now()),
    // Transaction( "t2", "Weekly Grocerise",12.53, DateTime.now())
  ];

List<Transaction> get _recentTransaction{
  return _transactions.where((txt) {

    return txt.date.isAfter(DateTime.now().subtract(Duration(days: 7),
    ),
    
    );
  }).toList();
}

  void _addnewtransaction(String txtitle,double txamount,DateTime datetime)
  {

  
  setState(() {
    _transactions.add(Transaction(id: DateTime.now().toString(),title: txtitle,amount: txamount,date: datetime));
  });
  }

void _startnewtransaction(BuildContext ctx)
{
showModalBottomSheet(context: ctx, builder: (_)

{
  return newTransaction(_addnewtransaction);
},);

}

void _deleteTansaction(String id)
{
   setState(() {
     _transactions.removeWhere((tx) 
     
     {
      return tx.id == id;
     }
     );
   });
  
}

  @override
  Widget build(BuildContext context) {
  


    return  Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(onPressed: ()=>_startnewtransaction(context),
             icon: Icon(Icons.add))
          ],
          title: Text('Personal Expenses',),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body:
        SingleChildScrollView(child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
        Chart(_recentTransaction),
          TransactionList(_transactions,_deleteTansaction)
      
            
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add,color: Colors.black,
        ),
        onPressed: ()=>_startnewtransaction(context),
        backgroundColor:Theme.of(context).secondaryHeaderColor,


        ),
   
    );
  }
}
