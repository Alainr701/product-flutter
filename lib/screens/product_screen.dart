import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login/providers/product_form_provider.dart';
import 'package:login/services/services.dart';
import 'package:login/ui/input_decoration.dart';
import 'package:login/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productServices = Provider.of<ProductsServices>(context);

    return ChangeNotifierProvider(
        create: (_) => ProductFormProvider(productServices.selectedProduct),
        child: _ProductScreenBody(productServices: productServices));
  }
}

class _ProductScreenBody extends StatelessWidget {
  const _ProductScreenBody({
    Key? key,
    required this.productServices,
  }) : super(key: key);

  final ProductsServices productServices;

  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ProductImage(url: productServices.selectedProduct.picture),
                  Positioned(
                    left: 12,
                    top: 12,
                    child: RoundedIcon(
                      icon: Icons.arrow_back_ios_new_outlined,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  Positioned(
                    right: 12,
                    top: 12,
                    child: RoundedIcon(
                      icon: Icons.camera,
                      onPressed: () async {
                        final picker = new ImagePicker();
                        final XFile? pickedFile = await picker.pickImage(
                            source: ImageSource.camera, imageQuality: 100);
                        if (pickedFile == null) {
                          print('No selecciono nada');
                          return;
                        }
                        print('Tenemos imagen ${pickedFile.path}');
                        productServices
                            .updateSelectedProductImage(pickedFile.path);
                      },
                    ),
                  ),
                  Positioned(
                    right: 55,
                    top: 12,
                    child: RoundedIcon(
                      icon: Icons.update,
                      onPressed: () {
                        print('object');
                      },
                    ),
                  ),
                ],
              ),
              Text(
                'Settings',
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    shadows: [Shadow(color: Colors.red, offset: Offset(2, 2))]),
              ),
              _ProductForm(),
              SizedBox(height: 100),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: productServices.isSaving
            ? null
            : () async {
                if (!productForm.isValidForm()) return;
                final String? imageUrl = await productServices.uploadImage();
                // print(imageUrl);
                if (imageUrl != null) productForm.product.picture = imageUrl;
                await productServices.saveOrCreateProduct(productForm.product);
              },
        child: productServices.isSaving
            ? CircularProgressIndicator(color: Colors.white)
            : Icon(Icons.save_alt_rounded),
      ),
    );
  }
}

class _ProductForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    final product = productForm.product;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: _buildBoxDecoration(),
      child: Form(
          key: productForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              SizedBox(height: 18),
              TextFormField(
                initialValue: product.name,
                onChanged: (value) => product.name = value,
                validator: (value) {
                  if (value == null || value.length < 1) {
                    return 'El nombre es obligatorio';
                  }
                },
                decoration: InputDecorations.authInputDecoration(
                    labelText: 'Nombre', hintText: 'Nombre del producto'),
              ),
              SizedBox(height: 18),
              TextFormField(
                initialValue: product.price.toString(),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^(\d+)?\.?\d{0,2}'))
                ],
                onChanged: (value) {
                  if (double.tryParse(value) == null) {
                    product.price = 0;
                  } else {
                    product.price = double.parse(value);
                  }
                },
                keyboardType: TextInputType.number,
                decoration: InputDecorations.authInputDecoration(
                    labelText: 'Precios', hintText: '\$150'),
              ),
              SizedBox(height: 18),
              SwitchListTile.adaptive(
                value: product.available,
                // onChanged: (value) => productForm.updateAvailable(value),//1form
                onChanged: productForm.updateAvailable, //2form
                activeColor: Colors.red,
                title: Text('Disponible'),
              )
            ],
          )),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration();
}
