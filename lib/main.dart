import 'package:flutter/material.dart';
import 'package:new_expenses/widgets/expenses.dart';
//import 'package:flutter/services.dart';     // this Package is used to lock orientation of our app  step 1

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(251, 167, 241, 241),);

  var kDarkColorScheme = ColorScheme.fromSeed(        // 54 For DarkMode
  brightness: Brightness.dark,
    seedColor:const Color.fromARGB(255, 5, 82, 35),
     );

void main(){

  // with the help of this mehtod we can allow user to use app in a way we want them to use 
  
  // WidgetsFlutterBinding.ensureInitialized();  // step 3 
  // SystemChrome.setPreferredOrientations([    // step 2
  //   DeviceOrientation.portraitUp,
  // ]).then((fn){
  //     // when runApp code put in this section then it set or lock the orientation of app , means even in landscape mode it see like i had created
  // });


  runApp(
    MaterialApp(
   debugShowCheckedModeBanner: false,       // this can use only in materialApp Cupertino

    darkTheme: ThemeData.dark().copyWith(    // 55 can also adding second theme here it is for dark theme
      useMaterial3: true,
      colorScheme: kDarkColorScheme,
      cardTheme:const  CardTheme().copyWith(      // 56 copy CardTheme from below coz when i run without this it throw an error like it is null,in expenselist i had set my margin not null i.e margin! 
      color: kDarkColorScheme.secondaryContainer,
      margin: const EdgeInsets.symmetric(vertical: 16,horizontal: 8),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: kDarkColorScheme.primaryContainer,
        foregroundColor: kDarkColorScheme.onPrimaryContainer,
      ),
      ),
    ),
    //theme: ThemeData(useMaterial3: true),   // after Applying this toolbar color will change from blue to white as default
    theme: ThemeData().copyWith(              // 52 some chamges are made when i use coPywithh
    useMaterial3: true,
    // scaffoldBackgroundColor: const Color.fromARGB(251, 167, 241, 241),
    colorScheme: kColorScheme,
    appBarTheme: const AppBarTheme().copyWith(
       backgroundColor: kColorScheme.onPrimaryContainer,  // iska Matlab hai ki text Pe nhi ayega 
      foregroundColor: kColorScheme.primaryContainer,  // isko hata denge to text nhi dekhwga
    ),
    cardTheme:const  CardTheme().copyWith(
      color: kColorScheme.secondaryContainer,
      margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: kColorScheme.primaryContainer,
      ),
      ),
      textTheme: ThemeData().textTheme.copyWith(
        titleLarge:  TextStyle(                             // Passed on steP 53
          fontWeight: FontWeight.bold,
          fontSize: 20,
         color: kColorScheme.onSecondaryContainer,  // this will not reflect here bcoz already set in appBar doesnot override
          )
      ),
    ), 
    themeMode: ThemeMode.system,   // theme according to system but also it is default
      home:const Expenses(),
    ),
  );
}

