import 'dart:io';

import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  final String? url;

  const ProductImage({Key? key, this.url}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 400,
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: _buildBoxDecoration(),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(8), child: getImage(url)),
    );
  }

  BoxDecoration _buildBoxDecoration() =>
      BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(8));
  Widget getImage(String? picture) {
    if (picture == null)
      return Image(
        image: AssetImage('assets/no-image.png'),
        fit: BoxFit.cover,
      );
    if (picture.startsWith('http')) {
      return FadeInImage(
        placeholder: AssetImage('assets/jar-loading.gif'),
        image: NetworkImage(this.url!),
        fit: BoxFit.cover,
      );
    }
    return Image.file(
      File(picture),
      fit: BoxFit.cover,
    );
  }
}
