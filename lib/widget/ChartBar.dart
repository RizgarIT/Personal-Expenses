import 'dart:ffi';

import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double SpendingAmount;
  final double SpendingPriceTotal;

  ChartBar(this.label, this.SpendingAmount, this.SpendingPriceTotal);

  @override
  Widget build(BuildContext context) {
    return  LayoutBuilder(builder: (ctx, constraint){
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: constraint.maxHeight *0.09,
          child: FittedBox(
            child: Text(
              '\$${SpendingAmount.toStringAsFixed(0)}',
            ),
          ),
        ),
        SizedBox(
          height: constraint.maxHeight *0.03,
        ),
        Container(
          width: 10,
          height: constraint.maxHeight *0.6,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Color.fromRGBO(220, 220, 220, 1),
                ),
              ),
              FractionallySizedBox(
                heightFactor: SpendingPriceTotal,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: constraint.maxHeight *0.05,
        ),
        Container(
          height: constraint.maxHeight *0.09,
          child: FittedBox(child: Text(label))),
      ],
    );
    });
  }
}
