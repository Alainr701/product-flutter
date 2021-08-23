import 'package:flutter/material.dart';
import 'package:login/models/models.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        margin: EdgeInsets.all(10.0),
        height: 180,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 10),
                blurRadius: 5,
              )
            ]),
        child: Stack(
          children: [
            _BackgroundImage(
              url: product.picture,
            ),
            _ProductDetails(title: product.name, subtitle: product.id!),
            Positioned(
                top: 0, left: 0, child: _PriceProduct(price: product.price)),
            if (product.available)
              Positioned(top: 0, right: 0, child: _NotAvailable())
          ],
        ),
      ),
    );
  }
}

class _NotAvailable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 7, vertical: 10),
      child: Icon(
        Icons.card_giftcard,
        color: Colors.red,
      ),
    );
  }
}

class _PriceProduct extends StatelessWidget {
  final double price;

  const _PriceProduct({Key? key, required this.price}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), bottomRight: Radius.circular(10))),
      padding: EdgeInsets.symmetric(horizontal: 7, vertical: 10),
      child: Text('\$ ${this.price}', style: TextStyle(color: Colors.white)),
    );
  }
}

class _ProductDetails extends StatelessWidget {
  final String title;
  final String subtitle;

  const _ProductDetails({Key? key, required this.title, required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(width: double.infinity),
          Container(
              alignment: Alignment.center,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12))),
              child: Text(this.title,
                  style: TextStyle(color: Colors.white, fontSize: 14))),
          // Text(this.subtitle,
          //     style: TextStyle(color: Colors.white, fontSize: 14)),
        ],
      ),
    );
  }
}

class _BackgroundImage extends StatelessWidget {
  final String? url;

  const _BackgroundImage({Key? key, this.url}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        margin: EdgeInsets.only(bottom: 10.0),
        child: url == null
            ? Image(
                image: AssetImage('assets/no-image.png'),
                fit: BoxFit.cover,
              )
            : FadeInImage(
                placeholder: AssetImage('assets/jar-loading.gif'),
                image: NetworkImage(this.url!),
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
