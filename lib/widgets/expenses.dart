import 'package:flutter/material.dart'; // this will oPen many widgets and utility function 
import 'package:new_expenses/widgets/chart/chart.dart';
import 'package:new_expenses/widgets/expenses_list/expenses_list.dart';
import 'package:new_expenses/modals/expense.dart';
import 'package:new_expenses/widgets/new_expense.dart';

 // 1st File Step 0

class Expenses extends StatefulWidget{
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
       return _ExpensesState();
  }
}
 // Step 1 : Create  this State class (used scaffold at start coz it has general base style)

class _ExpensesState extends State<Expenses>{                   // (This line means _expenseState connect with Widget Expense)

   final List<Expense> _registeredExpense = [                   // Step 3
       Expense(
          title: 'Flutter Course',
          amount: 20.67,
          date: DateTime.now(),
           category: Category.work,
           ),
       Expense(
          title: 'Cinema',
          amount: 78.61,
          date: DateTime.now(),
          category: Category.food,
           ),
   ]; 

   void _addNewExpense(){                                        // step 16 
  showModalBottomSheet(

    useSafeArea: true, /// step 9 ->     flutter had builtin mechanism to protect from device features(front camera etc) when use this here then widget automatically handle internally this situation 

    isScrollControlled: true,    // 41 modal overlY take full hwieht & width 
    context: context,
     builder: (ctx){                // The builder parameter takes a function that returns the widget tree for the bottom sheet // ctx is a local variable representing the context within the builder function.
       // return const Text('Modal Bottom Sheet');
        return   NewExpense(onAddExpense: _addExpense,);          // Step 18 Passed here   // 40
  },);     // this builder means has to Pass function as value
   }

   void _addExpense(Expense expense){                     // 39
         setState(() {
           _registeredExpense.add(expense);  // registered exVense k sath new wala add krega 
         }); 
   }

   void _removeExpense(Expense expense){    // 42 bcoz our expense remove but data store  internally and throw an error
   final expenseIndex = _registeredExpense.indexOf(expense); // 49
       setState(() {
         _registeredExpense.remove(expense);
       }
       );
       ScaffoldMessenger.of(context).clearSnackBars();   // 51 jo bhi exPense delete hoga to turant msg ayega(means Pehka exese delte aur uske badd 2 ra kiya to Pehelwale ka msg 4 second rhega Phir uske badd  2 ra delete wala info ayega . is chiz ko fast krne k liye ye use kiya hai maine ) 
       ScaffoldMessenger.of(context).showSnackBar(   // 48 is for when we delete expense then it show info message at bottom (of is method)
        SnackBar(
          content: const Text('Expense deleted successfully !'),
               duration: const Duration(seconds: 4),  // 4 second k badd undo but hat jaega 
               action: SnackBarAction(
                label: 'Undo',
                onPressed: (){
                  setState(() {
                    _registeredExpense.insert(expenseIndex,expense);  // 50 Passed here inside insert
                  }
                  );
                },
                ),
          ),
       );
   }

  @override
  Widget build(BuildContext context) {

   // step 4
   //print(MediaQuery.of(context).size.width);  // by using print we can actually see size of height and width in debug console(on rotate value chamge)
    //print(MediaQuery.of(context).size.height);

    final width = MediaQuery.of(context).size.width;

    Widget mainContent = const Center(   // 45 when there is no expense in list
      child: Text('No Expense found. Start adding !'),
    );

    if(_registeredExpense.isNotEmpty){
      mainContent = ExpensesList(              // 46
              expenses:_registeredExpense,
              onRemoveExpense: _removeExpense,
               );
    }

    return  Scaffold(
      appBar: AppBar(                                     // Step 15(it simply an toolbar widget,leading,actions,title above the bottom in any )
      title: const Text(' Expense Tracker'),
        actions: [
          IconButton(onPressed: _addNewExpense,          // 16 Passed here
           icon: const Icon(Icons.add),),
         ]),

      body: width < 600 ? Column(
        children: [
        // const Text(' Expenses Chart ',),
        Chart(expenses: _registeredExpense), // chart is widget
             Expanded(child: mainContent,   // 47 Passed here
               ),      // Step 7      //43         // (here i should has to add _registeredExpense but -> )// Step 4 Created a custom widget for Expense list so that code should be clean 
      ])
      : Row(                           // step 5
        children: [
          Expanded(child:Chart(expenses: _registeredExpense),),  // step 6 wrap with expanded(// if parent takes an double.infinity value so child will also takes that value & result in vacant content so getting rid from this is to wrap with Expanded works3)
             Expanded(child: mainContent,   
               ), 
        ],
      ),

      );
  }
}