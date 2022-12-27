// ignore_for_file: library_prefixes

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:amsapp/myutils/constant.dart';
import 'package:amsapp/myutils/locale_provider.dart';
import 'package:amsapp/myutils/preference.dart';
import 'package:amsapp/myutils/route_generator.dart';

import 'app_localizations.dart';

bool isLoggedIn = false;
bool isFirstTime = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Preference.load();
  isLoggedIn = Preference.getBool(Constant.spIsLogin);
  isFirstTime = Preference.getBool(Constant.spIsFirstTime, def: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String page = "/";
    if (isFirstTime) {
      page = RouteNames.loginPage;
    } else if (isLoggedIn) {
      page = RouteNames.attendanceFormPage;
    } else {
      page = RouteNames.loginPage;
    }
    // if (kDebugMode) {
    //   page = RouteNames.updateVehiclePage;
    // }
    return ChangeNotifierProvider(
      create: (context) => LocaleProvider(),
      builder: (context, child) {
        final provider = Provider.of<LocaleProvider>(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Attendance Sys',
          theme: ThemeData(
            textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
            primarySwatch: Colors.indigo,
          ),
          initialRoute: page,
          onGenerateRoute: RouteGenerator.generateRoute,
          locale: provider.locale,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            AppLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', 'EN'),
            Locale('ne', 'NP'),
          ],
          localeResolutionCallback: (locale, supportedLocales) {
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale?.languageCode &&
                  supportedLocale.countryCode == locale?.countryCode) {
                return supportedLocale;
              }
            }
            return null;
          },
        );
      },
    );
  }
}
