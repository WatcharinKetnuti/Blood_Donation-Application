import 'package:blood_donation_application/screens/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';
import '../services/authenthication_manager.dart';
import '../widgets/bottom_navbar.dart';

class AuthenScreen extends StatelessWidget {
  final AuthenticationManager _authmanager = Get.put(AuthenticationManager());

  Future<void> initializeSettings() async {
    _authmanager.checkLoginStatus();

    await Future.delayed(Duration(seconds: 3));
  }

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => LoginController());
    return FutureBuilder(
      future: initializeSettings(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return waitingView();
        } else {
          if (snapshot.hasError)
            return errorView(snapshot);
          else
            {
              AuthenticationManager auth = Get.find();
              return auth.isLogged.value
                  ? BottomNavBar()
                  : LoginScreen();
            }
        }
      },
    );
  }

  Widget errorView(AsyncSnapshot<Object?> snapshot) {
    return Scaffold(
        body: Center(child: Text('Error: ${snapshot.error}')));
  }

  Widget waitingView() {
    return Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CircularProgressIndicator(),
              ),
              Text('Loading...'),
            ],
          ),
        ));
  }
}