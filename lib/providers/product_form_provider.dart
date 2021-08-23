import 'package:flutter/cupertino.dart';
import 'package:login/models/models.dart';

class ProductFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Product product;

  ProductFormProvider(this.product);

  updateAvailable(bool value) {
    print(value);
    this.product.available = value;
    notifyListeners();
  }

  bool isValidForm() {
    print(product.name);
    print(product.price);
    print(product.available);
    return formKey.currentState?.validate() ?? false;
  }
}
