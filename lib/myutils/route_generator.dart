import 'package:amsapp/screens/attendance_form_page.dart';
import 'package:amsapp/screens/attendance_present_page.dart';
import 'package:flutter/material.dart';
import 'package:amsapp/screens/login_page.dart';

import '../screens/attendance_leave_page.dart';
import '../screens/change_password_page.dart';
import '../screens/edit_profile_page.dart';
import '../screens/profile_page.dart';
// import 'package:amsapp/screens/';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.initPage:
        return MaterialPageRoute(
            builder: (context) => const LoginPage(), settings: settings);
      case RouteNames.loginPage:
        return MaterialPageRoute(
            builder: (context) => const LoginPage(), settings: settings);
      case RouteNames.profilePage:
        return MaterialPageRoute(
            builder: (context) => const ProfilePage(), settings: settings);
      case RouteNames.changePasswordPage:
        return MaterialPageRoute(
            builder: (context) => const ChangePasswordPage(),
            settings: settings);
      case RouteNames.editProfilePage:
        return MaterialPageRoute(
            builder: (context) => const EditProfilePage(), settings: settings);
      case RouteNames.attendanceFormPage:
        return MaterialPageRoute(
            builder: (context) => const AttendanceFormPage(),
            settings: settings);
      case RouteNames.attendancePresentPage:
        return MaterialPageRoute(
            builder: (context) => const AttendancePresentPage(),
            settings: settings);
      case RouteNames.attendanceLeavePage:
        return MaterialPageRoute(
            builder: (context) => const AttendanceLeavePage(),
            settings: settings);
    }
    return _errorRoute();
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Error"),
        ),
        body: const Center(
          child: Text("Route Error"),
        ),
      );
    });
  }
}

class RouteNames {
  static const initPage = "/";
  static const loginPage = "login";
  static const changePasswordPage = "changePassword";
  static const profilePage = "profile";
  static const editProfilePage = "editProfile";
  static const attendanceFormPage = "attendanceForm";
  static const attendancePresentPage = "attendancePresent";
  static const attendanceLeavePage = "attendanceLeave";
}
