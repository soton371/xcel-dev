import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/navbar_patient/bottom_navbar_patient.dart';
import 'pages/splash/splash_page.dart';
import 'services/db/db_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  String spColorValue = '';
  String email = '';
  String saveUser = '';

  @override
  void initState() {
    DBProvider().initDB();
    getValuesFromSP();
    super.initState();
  }

  void goToSpecificPage(String payload) {
    if (payload.isNotEmpty) {
      String clickAction = payload;
      debugPrint("clickAction : $clickAction");
      if (clickAction.isNotEmpty &&
          clickAction.startsWith("OPEN_CONSULTATION_PAGE")) {
        runApp(const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: BottomNavBarPatient(switchTabIndex: 1)));
      }
    }
  }

  Future getValuesFromSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      spColorValue = prefs.getString('spColorValue').toString();
      email = prefs.getString('email') ?? '';
      saveUser = prefs.getString('saveUser') ?? '';
    });
    debugPrint("email: $email, saveUser: $saveUser");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Xcel Medical Centre',
      theme: ThemeData(useMaterial3: true),
      home: SplashPage(
        email: email,
        saveUser: saveUser,
      ),
    );
  }
}
