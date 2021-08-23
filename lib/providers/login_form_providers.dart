import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  String email = '';
  String password = '';

  //el change notifier es for widget and form no
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm() {
    // emeail obtener
    print(email + 'and ' + password);

    //
    print(formKey.currentState?.validate() ?? false);
    //si el form is valited
    return formKey.currentState?.validate() ?? false;
  }
}
