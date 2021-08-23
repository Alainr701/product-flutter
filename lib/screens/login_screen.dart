import 'package:flutter/material.dart';
import 'package:login/providers/login_form_providers.dart';
import 'package:login/ui/input_decoration.dart';
import 'package:login/widgets/widgets.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        // color: Colors.white,
        child: Stack(
          children: [
            AuthBackground(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(height: 80),
                    CardContainer(
                      child: Column(
                        children: [
                          Text('Ingresar',
                              style: Theme.of(context).textTheme.headline4),
                          SizedBox(height: 30),
                          ChangeNotifierProvider(
                              create: (_) => LoginFormProvider(),
                              child: _LoginForm())
                        ],
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'No tienes cuenta Registrate ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 100)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    return Form(
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(children: [
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
                hintText: 'alain@gmail.com',
                labelText: 'Correo Electronico',
                icon: Icons.alternate_email),
            onChanged: (value) => loginForm.email = value,
            validator: (value) {
              String pattern =
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regExp = new RegExp(pattern);

              return regExp.hasMatch(value ?? '') ? null : 'Ingrese un correo';
            },
          ),
          SizedBox(height: 10.0),
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
                hintText: '************',
                labelText: 'Contrase;a',
                icon: Icons.lock_open_outlined),
            onChanged: (value) => loginForm.password = value,
            validator: (value) {
              return (value != null && value.length >= 6)
                  ? null
                  : 'La contraseña debe terner 6 caracteres';
            },
          ),
          SizedBox(height: 10.0),
          MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.red,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: Text(
                  'Ingresar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              onPressed: loginForm.isLoading
                  ? null
                  : () async {
                      if (!loginForm.isValidForm()) return;

                      //
                      loginForm.isLoading = true;
                      await Future.delayed(Duration(seconds: 2));
                      Navigator.pushReplacementNamed(context, 'home');
                    }),
        ]));
  }
}
