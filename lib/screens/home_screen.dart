import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:login/models/models.dart';
import 'package:login/screens/screens.dart';
import 'package:login/services/services.dart';
import 'package:login/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsService = Provider.of<ProductsServices>(context);
    final authService = Provider.of<AuthServices>(context, listen: false);

    if (productsService.isLoading) return LoadingScreen();
    return Scaffold(
        appBar: AppBar(
          title: Text('Productos'),
          actions: [
            IconButton(
                onPressed: () {
                  authService.logout();
                  Navigator.pushReplacementNamed(context, 'login');
                },
                icon: Icon(Icons.login_outlined))
          ],
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              productsService.selectedProduct =
                  new Product(available: false, name: '', price: 0);
              Navigator.pushNamed(context, 'product');
            },
            child: Icon(Icons.add_business)),
        body: StaggeredGridView.countBuilder(
          physics: BouncingScrollPhysics(),
          crossAxisCount: 4,
          itemCount: productsService.products.length,
          itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                productsService.selectedProduct =
                    productsService.products[index].copy();
                print(productsService.products[index].copy().name);
                Navigator.pushNamed(context, 'product');
              },
              child: ProductCard(
                product: productsService.products[index],
              )),
          staggeredTileBuilder: (index) =>
              StaggeredTile.count(2, index.isEven ? 2 : 3),
          mainAxisSpacing: 2.0,
          crossAxisSpacing: 2.0,
        ));
  }
}
