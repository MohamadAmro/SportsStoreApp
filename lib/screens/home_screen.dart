  import 'package:flutter/material.dart';
  import 'package:mobileproject1/models/product.dart';
  import 'package:mobileproject1/widgets/product_item.dart';
  import 'cart_screen.dart';

  class HomeScreen extends StatelessWidget {
    final List<Product> products = [
      Product(id: 1, name: 'Soccer Ball', imageUrl: 'soccerball.png', price: 79.99),
      Product(id: 2, name: 'FB Boots', imageUrl: 'footballboots.png', price: 119.99),
      Product(id: 3, name: 'GK Gloves', imageUrl: 'goalkeepergloves.png', price: 39.99),
      Product(id: 4, name: 'BB Boots', imageUrl: 'basketballboots.png', price: 59.99),
      Product(id: 5, name: 'BB Jersey', imageUrl: 'basketballjersey.png', price: 149.99),
      Product(id: 6, name: 'Running Boots', imageUrl: 'runningboots.png', price: 109.99),
      Product(id: 7, name: 'Tennis Racket', imageUrl: 'tennisracket.png', price: 19.99),
      Product(id: 8, name: 'Tennis Balls', imageUrl: 'tennisballs.png', price: 10.99),
      Product(id: 9, name: 'Tennis Bag', imageUrl: 'tennisbag.png', price: 79.99),
      Product(id: 10, name: 'Adjustable Db', imageUrl: 'adjustabledumbbells.png', price: 349.99),
      Product(id: 11, name: 'Exercise Mat', imageUrl: 'exercisemat.png', price: 19.99),
      Product(id: 12, name: 'Gym Bag', imageUrl: 'gymbag.png', price: 119.99),
    ];

    @override
    Widget build(BuildContext context) {
      double screenWidth = MediaQuery.of(context).size.width;

      int crossAxisCount = screenWidth > 600 ? 3 : 2;

      return Scaffold(
        appBar: AppBar(
          title: Text('Sports Store'),
          actions: [
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartScreen(),
                  ),
                );
              },
            ),
          ],
        ),
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            return ProductItem(product: products[index], screenWidth: screenWidth);
          },
        ),
      );
    }
  }