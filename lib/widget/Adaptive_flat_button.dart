import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveFltaButton extends StatelessWidget {
final String txt;
var handler;

AdaptiveFltaButton(this.txt,this.handler);

  @override
  Widget build(BuildContext context) {
    return  Platform.isIOS?CupertinoButton(
                    onPressed: handler,
                      child: Text(
                       txt,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      color: Theme.of(context).primaryColor,)
                       :
                      FlatButton(
                      onPressed: handler,
                      child: Text(
                        txt,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      textColor: Theme.of(context).primaryColor,
                    );
  }
}