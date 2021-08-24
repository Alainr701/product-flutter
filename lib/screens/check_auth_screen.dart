import 'package:flutter/material.dart';
import 'package:login/screens/home_screen.dart';
import 'package:login/screens/login_screen.dart';
import 'package:login/services/auth_services.dart';
import 'package:provider/provider.dart';

class CheckAuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthServices>(context, listen: false);
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: authService.readToken(),
          builder: (context, AsyncSnapshot<String> snapshot) {
            if (!snapshot.hasData) {
              return Text('Espere');
            }
            if (snapshot.data == '') {
              Future.microtask(() {
                Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => LoginScreen(),
                        transitionDuration: Duration(seconds: 0)));
                // Navigator.of(context).pushReplacementNamed('login');
              }); //si termina
            } else {
              Future.microtask(() {
                Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => HomeScreen(),
                        transitionDuration: Duration(seconds: 0)));
              }); //
            }

            return Container();
          },
        ),
      ),
    );
  }
}
