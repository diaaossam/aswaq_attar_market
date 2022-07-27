import 'package:aswaq_attar_market/shared/helper/bloc_observer.dart';
import 'package:aswaq_attar_market/shared/services/local/cache_helper.dart';
import 'package:aswaq_attar_market/shared/services/network/dio_helper.dart';
import 'package:aswaq_attar_market/shared/styles/styles.dart';
import 'package:aswaq_attar_market/ui/screens/splash_screen/splash_screen.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      await CachedHelper.init();
      DioHelper.init();
      runApp(MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter E-Commerce',
      theme: ThemeManger.setLightTheme(),
      home: SplashScreen(),
    );
  }
}
