import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'HomePage.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}


    class MyApp extends StatelessWidget {
      const MyApp({Key? key}) : super(key: key);

      @override
      Widget build(BuildContext context) {
        return MaterialApp(
          title: 'Mobile Phone Authentication',
          theme: ThemeData(
            primarySwatch: Colors.yellow
          ),
          home: MyHomePage(title: '',)

        );
      }
    }
