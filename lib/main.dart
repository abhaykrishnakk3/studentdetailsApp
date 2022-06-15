// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:student_management/model/data_model.dart';
// import 'package:student_management/screens/add_screen.dart';
// import 'package:student_management/screens/screen_edit.dart';
import 'package:student_management/screens/screen_home.dart';

void main()async{
 WidgetsFlutterBinding.ensureInitialized();
 await Hive.initFlutter();
 if(!Hive.isAdapterRegistered(StudentModelAdapter().typeId)){
    Hive.registerAdapter(StudentModelAdapter());
 }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      theme: ThemeData(primarySwatch: Colors.blue),
      home:const ScreenHome(),
      
    );
  }
}