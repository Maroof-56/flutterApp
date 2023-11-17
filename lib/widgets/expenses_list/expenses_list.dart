

// step 4 ; Created this custom widgte
import 'package:flutter/material.dart';
import 'package:new_expenses/modals/expense.dart';
import 'package:new_expenses/widgets/expenses_list/expense_item.dart';

class ExpensesList extends StatelessWidget{
  const ExpensesList({super.key,required this.expenses,required this.onRemoveExpense});

  final List<Expense> expenses ;                        // Step 5: Make this so that can access List here exPense.dart wali
  final void Function(Expense expense) onRemoveExpense;     // 43
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount:expenses.length ,
     // itemBuilder: (ctx,index)=> Text(expenses[index].title));                    6            
      //itemBuilder: (ctx,index)=> ExpenseItem(expenses[index]),   // step 10    // Step 6: instead of Column i used this widget coz i dont know the length of app here so it is good practice(to know more abt listview and inside constructor functioncheck it on document)
      itemBuilder: (ctx,index)=> Dismissible(            // 42 our wisget or expesne should be dismissible or remove
        background: Container(             // 55 when delete expense it will show some color while swiPing
          color: Theme.of(context).colorScheme.error.withOpacity(0.5),   //  error is inbuilt in dart 
          // margin: const EdgeInsets.symmetric(horizontal: 15), margin coming from maindart file
          margin: EdgeInsets.symmetric(
            horizontal: Theme.of(context).cardTheme.margin!.horizontal,
            ),
          ),
        key: ValueKey(expenses[index]),
        onDismissed: (direction) {               // 44
          onRemoveExpense(expenses[index]);
        },
       child:ExpenseItem(expenses[index],
       ), 
       ),       
      ); 
  }                                                             // used with .builder constructor func(specaial constr) is scrollabe and build when item is visibe not when it is not visible 

}
