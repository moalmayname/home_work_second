import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:home_work_second/DB/DbHelper.dart';
import 'package:home_work_second/UI/View/HomePage.dart';
import 'package:home_work_second/Services/themeServices.dart';
import 'package:home_work_second/UI/theme.dart';


Future <void> main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.initDb();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeSerivce().theme,








      home:  HomePage(),


    );
  }
}


