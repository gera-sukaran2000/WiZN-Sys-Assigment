import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wizn_system/model/model.dart';
import 'package:wizn_system/screens/screen1.dart';
import 'package:wizn_system/screens/screen2.dart';

int? fetchDataFromApi;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  fetchDataFromApi = preferences.getInt('fetchDataFromApi');
  await preferences.setInt('fetchDataFromApi', 1);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      builder: () => ChangeNotifierProvider(
        create: (context) => ModelList(),
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Inter'),
          home: Screen1(fetchDataFromApi),
        ),
      ),
    );
  }
}
