import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:login/models/models.dart';
import 'package:http/http.dart' as http;

class ProductsServices extends ChangeNotifier {
  final String _baseUrl = 'flutter-firebase-e407f-default-rtdb.firebaseio.com';
  final List<Product> products = [];
  //Second Screen Update
  late Product selectedProduct;
  //image
  File? newPictureFile;

  bool isLoading = true;
  bool isSaving = false;
  ProductsServices() {
    this.loadProducts();
  }

  Future<List<Product>> loadProducts() async {
    this.isLoading = true; //for is login
    notifyListeners();

    final url = Uri.https(_baseUrl, 'products.json');
    final resp = await http.get(url);

    final Map<String, dynamic> productsMap = json.decode(resp.body);

    productsMap.forEach((key, value) {
      final tempProduct = Product.fromMap(value);
      tempProduct.id = key;
      this.products.add(tempProduct); //agregamos anuestra lista
    });
    // print(this.products[0].name);
    this.isLoading = false;
    notifyListeners();
    return this.products;
  }

  //create or update
  Future saveOrCreateProduct(Product product) async {
    isSaving = true;
    notifyListeners();

    if (product.id == null) {
      await createProduct(product);
    } else {
      await updateProduct(product);
    }

    isSaving = false;
    notifyListeners();
  }

  Future<String> updateProduct(Product product) async {
    final url = Uri.https(_baseUrl, 'products/${product.id}.json');
    final resp = await http.put(url, body: product.toJson());
    final decodedData = resp.body;
    // print(decodedData);
    //update logic list

    final index =
        this.products.indexWhere((element) => element.id == product.id);
    this.products[index] = product;
    return product.id!;
  }

  Future<String> createProduct(Product product) async {
    final url = Uri.https(_baseUrl, 'products.json');
    final resp = await http.post(url, body: product.toJson());
    final decodedData = json.decode(resp.body);
    // print(decodedData);
    product.id = decodedData['name'];
    this.products.add(product);

    return product.id!;
  }

  void updateSelectedProductImage(String path) {
    this.selectedProduct.picture = path;
    this.newPictureFile = File.fromUri(Uri(path: path));
    notifyListeners();
  }

  Future<String?> uploadImage() async {
    if (this.newPictureFile == null) return null;
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/dtcmmwhl1/image/upload?upload_preset=g7vpmxsl');
    final imageUploadRequest = http.MultipartRequest('POST', url);
    final file =
        await http.MultipartFile.fromPath('file', newPictureFile!.path);
    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);
    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('Algo salio mal');
      print(resp.body);
      return null;
    }
    this.newPictureFile = null;

    final decodeData = json.decode(resp.body);
    // print(resp.body);
    return decodeData['secure_url'];
  }
}
