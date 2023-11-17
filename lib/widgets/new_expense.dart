import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; // cupertino refers to ios style when suddenly meet 
import 'package:intl/intl.dart';
import 'package:new_expenses/modals/expense.dart';      // steP 8


final formatter = DateFormat.yMd();
class NewExpense extends StatefulWidget{
   const NewExpense({super.key,required this.onAddExpense});

   final Function(Expense expense) onAddExpense;      // 37 Passing func as a value
   @override
  State<NewExpense> createState() {
        return _NewExpenseState();
}
}

class _NewExpenseState extends State<NewExpense>{

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime ? _selectedDate;
  Category  _selectedCategory = Category.leisure;

  void _presentDatePicker() async{
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1,now.month,now.day);

    final pickedDate = await showDatePicker(context: context,
     initialDate: now,
      firstDate: firstDate,
       lastDate: now
       );
       setState(() {
         _selectedDate = pickedDate;
       });
  }

  void _showDialog(){
    if(Platform.isIOS){
            showCupertinoDialog(             // step 14 cupertino -> ios style 
              context: context,
               builder: (ctx) => CupertinoAlertDialog(
                 title: const Text('Invalid Input'),    // copied from below
        content: const Text(' Please make sure that all details are filled correctly & not vacant'),
              actions: [
                TextButton(onPressed: (){
                    Navigator.pop(ctx);
                 }, 
                 child: const Text('Okay'),
                ),
              ],
               ),
               );

    }
    else{
      showDialog(context: context,
       builder: (ctx) => AlertDialog(
        title: const Text('Invalid Input'),
        content: const Text(' Please make sure that all details are filled correctly & not vacant'),
              actions: [
                TextButton(onPressed: (){
                    Navigator.pop(ctx);
                 }, 
                 child: const Text('Okay'),
                ),
              ],
       ),
       );

    }
  }

  void _submitExpenseData(){
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <=0;
         // trim helps to remove whitespace from begn  end 
    if(_titleController.text.trim().isEmpty || amountIsInvalid || _selectedDate == null){
            _showDialog();            // step 15 cut both dialog from here and paste in void funtion & pass value here
            
     
       return; // iska mtlb ye h ki iske baad koi func execute nhi hoga
    }
    widget.onAddExpense(Expense(                     // 38 widget is method to acces above class Paramter here
      title: _titleController.text,
       amount: enteredAmount,
        date: _selectedDate!,
         category: _selectedCategory
         ),
         );
         Navigator.pop(context);         // after submitting it can close dynamiclly
  }

  @override
  Widget build(BuildContext context){
    // step 6 for keyboard when open in landscape view it might disgusting
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(builder: (ctx,constraints){  //  step 10 :  this widget is also used like mediaquery (we can say alternate methiod)
    
     // put below code here all
    //  print(constraints.minWidth);     // with help of this wen can set accordingly by seig on debug
    //  print(constraints.maxWidth);
    //  print(constraints.minHeight);
    //  print(constraints.maxWidth);

    final width = constraints.maxWidth;    // step 11

    return SizedBox(                  // coz it take whole height input field from top
      child: SingleChildScrollView(    // input field should scrollable that will good in landscape view
        child: Padding(                         // step 7 wrap this padding with singleChilsScrollview widget and also wrap this widget with sizedbox
         // padding: const EdgeInsets.fromLTRB(15,40,15,15),        // 41
          padding:  EdgeInsets.fromLTRB(15,40,15, keyboardSpace + 15),        // step 8
          child: Column(
            children: [
                // SizedBox(
                  if (width >= 600)     // step 12 no curly braces here !
                    Row(              // textfield also copied here for this width
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Expanded(
                           child: TextField(
                           controller: _titleController,
                           maxLength: 30,
                           decoration: const  InputDecoration(
                           label:Text('title' ,style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,),),
                                              ),
                           ),
                         ),
                         const SizedBox(width: 24,),  // step 13
                      ],
                    )
                    else
                //  SizedBox(
                //    child:
                    TextField(
                    controller: _titleController,
                    maxLength: 30,
                    decoration: const  InputDecoration(
                      label:Text('title' ,style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,),),
                       ),
                           ),
                //  ),
              //  ),
            const SizedBox(height: 10,),
              if(width >= 600)                     // step 13 we want dropdown we built accorgin to width so it look good
                Row(
                  children: [
                    DropdownButton(                  
                      value: _selectedCategory, 
                      items: Category.values.map(
                        (category) => DropdownMenuItem(
                          value: category, 
                          child: Text(
                            category.name.toUpperCase(),
                          ),
                          ),
                          ).toList(), 
                            onChanged: (value){
                           if(value == null){   
                            return;
                           }
                           setState(() {
                             _selectedCategory = value;  
                           });
                        },
                        ),
                        const SizedBox(width: 24,),
                   Expanded(                              // step 14 paste here 
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                       Text(_selectedDate == null ? 'No Date Selected' : formatter.format(_selectedDate!)),
                       IconButton(onPressed:_presentDatePicker,
                       icon: const Icon(Icons.calendar_month),
                       ),
                      ],
                    ),
                  ),

              ],
              )

              else
              Row(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                   child:   SizedBox(
                    // width: 0.0,
                      child:  TextField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        decoration: const  InputDecoration(
                          prefixText
                          : '\$',
                          label: Text('Enter Amount',style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,),),
                          ),
                      ),
                    ),
                 ),
                  const SizedBox(width: 20,),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                       Text(_selectedDate == null ? 'No Date Selected' : formatter.format(_selectedDate!)),
                       IconButton(onPressed:_presentDatePicker,
                       icon: const Icon(Icons.calendar_month),
                       ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
      
              // SizedBox(
              //   child:
                 Row(
                  children: [
                  
            Row(
                  children:[
                     DropdownButton(                  // value: hum apni slect kri hui category dekh Payeyenge )
                      value: _selectedCategory, // jo category select krenge to usko  store krna Padaega noemalt\y conrtoller se ho jata h but yaha suPPorted nhi hai isliye manually kiya humne
                      items: Category.values.map(
                        (category) => DropdownMenuItem(
                          value: category, // when u will not Provide this value dart doesnot know what to execute so it will throw assertion error 
                          child: Text(
                            category.name.toUpperCase(),
                          ),
                          ),
                          ).toList(), 
                            onChanged: (value){
                           if(value == null){    // if user ne kch nhi select kiya to uske liyehai ye check
                            return;
                           }
                           setState(() {
                             _selectedCategory = value;  //(ani category select krne k liye)  ye value Pass nhi krenge setstate k ander to user select nhi kr Payegs aPni category 
                           });
                        },
                        ),
                  ]
                ),
                const Spacer(),
                  TextButton(onPressed: (){
                    Navigator.pop(context);
                  },
                   child:const  Text('Cancel'),),
                  //  const Spacer(),
                  const SizedBox(width: 10,),
                   Row( 
                    children: [
                      ElevatedButton(onPressed: (){
                        // print(_titleController.text);
                        // print(_amountController.text);
                        _submitExpenseData();
                      },
                       child: const Text('save expense'),
                       ),
                    ],
                   ),
                  ],
                ),
              // ),
            ],
          ),
        ),
      ),
    );
    });
  }
}