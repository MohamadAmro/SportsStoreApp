import 'package:flutter/material.dart';
import 'package:mobileproject1/models/product.dart';
import 'package:mobileproject1/screens/product_details_screen.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  final double screenWidth;

  ProductItem({required this.product, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    double discountedPrice = product.price;

    if (product.price > 100) {
      discountedPrice *= 0.8;
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(product: product, screenWidth: screenWidth),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 80,
              width: 200,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
                child: Image.asset(product.imageUrl, width: screenWidth / 2 - 12.0, height: 150, fit: BoxFit.fill),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8.0),
                  Text(
                    product.name,
                    style: TextStyle(
                      fontSize: screenWidth > 600 ? 20.0 : screenWidth < 300 ? 8.0 : 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    children: [
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: screenWidth > 600 ? 20.0 : screenWidth < 300 ? 8.0 : 16.0,
                          color: product.price > 100 ? Colors.red : Colors.green,
                          decoration: product.price > 100
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      if (product.price > 100)
                        SizedBox(width: 8.0),
                      if (product.price > 100)
                        Text(
                          '\$${discountedPrice.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: screenWidth > 600 ? 20.0 : screenWidth < 300 ? 8.0 : 16.0,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
