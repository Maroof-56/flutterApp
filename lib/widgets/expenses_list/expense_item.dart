
import 'package:flutter/material.dart';
import 'package:new_expenses/modals/expense.dart';      // steP 8

class ExpenseItem extends StatelessWidget{
  const ExpenseItem(this.expense,{super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(                                      // card not had Padding so warP with Padding 
      child: Padding(                                    // step 9 wrap with Padding
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: Column(                                   // step 10
          crossAxisAlignment: CrossAxisAlignment.start,   //    54 take all title at start                                
          children: [
              Text(expense.title,
              style: Theme.of(context).textTheme.titleLarge,        // 53
              ),                      
              const SizedBox(height: 5,),
              Row(
                children: [
                  Text('\$${expense.amount.toStringAsFixed(2)}'), // means 2 digit after dot 67.77 // 1.$ will be Print as outPut 2.$ injection that line means it take as one value
                  const Spacer(),   // this will take all space betwn above text & below row
                  Row(
                    children: [
                       Icon(categoryIcons[expense.category]),      //step 14
                      const SizedBox(width: 7,),
                      Text(expense.formattedDate),
                    ],
                  )
                ],
              )
        ],)
      ),
      );
  }
}