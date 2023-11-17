import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';        // reload window on comand Platte => not getting error of unused url
import 'package:intl/intl.dart';               //  step 12  // intl package define Dateformat ,numberformat,bidiformat
 // Step 2 : making this folder inside modal
 
   final formatter = DateFormat.yMd();        //  step 12 : DateFormat is inbuilt funtion(for format dates)

   const uuid = Uuid();                        // this is inbuilt can see on Package documention of uuid(Made this outside of class but can use anywhere in this file) 

  enum Category { food,leisure,travel,work}      // enumerated tyPe :a type of data where only a set of predefined values exist.

  const categoryIcons = {
    Category.food:Icons.lunch_dining_rounded,
    Category.leisure:Icons.movie,                         // Step 11
    Category.travel:Icons.flight_takeoff,
    Category.work:Icons.work,
  };
 class Expense{                                  // that describe single expense
     
     Expense(                                    // this are the constructor function (here for id it cant require as Parameter bcoz i has to manage it dynamically whenever new ExPense added by using third party Package->uuid)
      {
        required this.title,
        required this.amount,                    // this are the Parameter
        required this.date,
        required this.category,
      }
      ):id = uuid.v4();                        //this is initializer &it is dart feature (this is changing id dynmically when new )

  final String id;
  final String title;                           // this is class
  final double amount;
  final DateTime date;
  final Category category;                      // for this i define it as enum coz user can selct exPense accordingly

  // can also method in class
    String get formattedDate {                   // step 13 get is inbuilt function
      return formatter.format(date);             // format is inbuilt function
    }
 }

 class ExpenseBucket {
  const ExpenseBucket({required this.expenses,required this.category});

    ExpenseBucket.forCategory(List<Expense> allExpense,this.category) : expenses = allExpense.where((expense) => expense.category == category ).toList();

    
    final Category category;
    final List<Expense> expenses;

    double get totalExpenses{         // getter access the value of object ProPerty ,it retrieve value without exPosing imPlementation detail
      double sum = 0;
 
      for(final expense in expenses){     // new varaiant of for looP
        sum += expense.amount;
      }
      return sum;

    }
}