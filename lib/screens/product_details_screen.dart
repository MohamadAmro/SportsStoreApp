import 'package:flutter/material.dart';
import 'package:mobileproject1/models/product.dart';
import 'package:provider/provider.dart';
import 'package:mobileproject1/models/cart.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;
  final double screenWidth;

  ProductDetailsScreen({required this.product, required this.screenWidth});

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  String selectedSize = 'Small';
  String selectedColor = 'White';
  int _selectedQuantity = 1;
  double screenWidth = 0.0;

  String getProductDescription() {
    switch (widget.product.id) {
      case 1:
        return 'High-quality football designed for optimal performance and durability(Signed By the G.O.A.T CR7).';
      case 2:
        return 'Professional-grade boots engineered for speed, control, and comfort.';
      case 3:
        return 'Precision-engineered gloves for goalkeepers, offering superior grip and protection.';
      case 4:
        return 'High-performance basketball shoes designed for agility and support.';
      case 5:
        return 'Stylish and breathable jerseys for a comfortable playing experience.';
      case 6:
        return 'Cushioned and supportive running shoes for superior comfort on the track or trail.';
      case 7:
        return 'Professional-grade tennis rackets for precision and power on the court.';
      case 8:
        return 'High-performance tennis balls suitable for all court surfaces.';
      case 9:
        return 'Stylish and functional bags to carry tennis rackets, balls, and accessories.';
      case 10:
        return 'High-quality adjustable dumbbells for versatile and effective strength training at home or in the gym.';
      case 11:
        return 'Comfortable and non-slip exercise mat for floor workouts, yoga, and stretching exercises.';
      case 12:
        return 'Spacious and stylish gym bag with multiple compartments for convenient storage of gym essentials.';
      default:
        return 'No Description for a non found product in my store';
    }
  }

  @override
  Widget build(BuildContext context) {
    double discountedPrice = widget.product.price;

    if (widget.product.price > 100) {
      discountedPrice *= 0.8;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: screenWidth > 600 ? 300 : 200,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
                    child: Image.asset(widget.product.imageUrl, fit: BoxFit.fill),
                  ),
                ),
                Positioned(
                  top: 16.0,
                  left: 16.0,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.name,
                    style: TextStyle(
                      fontSize: screenWidth > 600 ? 24.0 : 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    '\$${discountedPrice.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: screenWidth > 600 ? 20.0 : 18.0,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Description:',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    getProductDescription(),
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      Text('Quantity: '),
                      DropdownButton<int>(
                        value: _selectedQuantity,
                        onChanged: (value) {
                          setState(() {
                            _selectedQuantity = value!;
                          });
                        },
                        items: List.generate(10, (index) => index + 1)
                            .map((quantity) => DropdownMenuItem<int>(
                          value: quantity,
                          child: Text(quantity.toString()),
                        ))
                            .toList(),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  _buildVariationOption(
                    'Size',
                    widget.product.name.contains('Boots')
                        ? ['40', '42', '45']
                        : (widget.product.name.contains('Db')
                        ? ['50kg', '75kg', '100kg']
                        : ['Small', 'Medium', 'Large']),
                  ),
                  SizedBox(height: 8.0),
                  _buildVariationOption('Color', ['White', 'Black', 'Red']),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      if (validateOptions()) {
                        if (widget.product.price > 100) {
                          Provider.of<Cart>(context, listen: false).addToCart(
                            productName: widget.product.name,
                            productQuantity: _selectedQuantity,
                            productPrice: discountedPrice
                          );
                        } else {
                          Provider.of<Cart>(context, listen: false).addToCart(
                              productName: widget.product.name,
                              productQuantity: _selectedQuantity,
                              productPrice: widget.product.price
                          );
                        }
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Please select valid options before adding to the cart.'),
                          ),
                        );
                      }
                    },
                    child: Text('Add to Cart'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVariationOption(String title, List<String> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$title:',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.0),
        Wrap(
          spacing: 8.0,
          children: options.map((option) {
            return ChoiceChip(
              label: Text(option),
              selected: (title == 'Size' && option == selectedSize) ||
                  (title == 'Color' && option == selectedColor),
              onSelected: (selected) {
                setState(() {
                  if (title == 'Size') {
                    selectedSize = option;
                  } else if (title == 'Color') {
                    selectedColor = option;
                  }
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  bool validateOptions() {
    return selectedSize.isNotEmpty && selectedColor.isNotEmpty;
  }
  @override
  void initState() {
    super.initState();
    screenWidth = widget.screenWidth;
  }
}
