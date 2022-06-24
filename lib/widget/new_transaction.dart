import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class newTransaction extends StatefulWidget {
  Function addnewtransaction;

  newTransaction(this.addnewtransaction);

  @override
  State<newTransaction> createState() => _newTransactionState();
}

class _newTransactionState extends State<newTransaction> {
var datetime;
  final _titleInput = TextEditingController();

  final _amountInput = TextEditingController();

  void submit() {

if(_amountInput.text.isEmpty)
{
  return;
}

    final entertitle = _titleInput.text;

    if (entertitle.isEmpty || double.parse(_amountInput.text) <= 0 || datetime==null) {
      return;
    }

    widget.addnewtransaction(entertitle, double.parse(_amountInput.text),datetime);

    Navigator.of(context).pop();
  }

  void _datatimePicker() {
   

    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019, 1, 1),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.amber, // header background color
              onPrimary: Colors.black, // header text color
              onSurface: Colors.black, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Theme.of(context).primaryColor, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    ).then((value) {
      if (value == null) {
        return;
      }

      setState(() {
        datetime = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.only(left: 10,top:10,right: 10,bottom: MediaQuery.of(context).viewInsets.bottom +10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(
                    labelText: 'Title',
                    labelStyle: TextStyle(
                      color: Theme.of(context).primaryColor,
                    )),
                cursorColor: Theme.of(context).primaryColor,
                controller: _titleInput,
                onSubmitted: (_) => submit,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Amount',
                  labelStyle: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                cursorColor: Theme.of(context).primaryColor,
                controller: _amountInput,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submit,
              ),
              Container(
                height:   MediaQuery.of(context).size.height 
                              * 0.2,
                child: Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Text(
                            datetime==null?
                          'No data chosen !':DateFormat.yMEd().format(datetime),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                    FlatButton(
                      onPressed: _datatimePicker,
                      child: Text(
                        'choose Data',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      textColor: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ),
              Container(
                height:  MediaQuery.of(context).size.height 
                              * 0.1,
                child: Center(
                  child: RaisedButton(
                    onPressed: submit,
                    child: Text(
                      "Add Transaction",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    color: Theme.of(context).secondaryHeaderColor,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
