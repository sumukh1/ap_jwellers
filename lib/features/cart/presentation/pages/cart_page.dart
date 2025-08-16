import 'package:flutter/material.dart';
import 'package:myapp/static/AppColors.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  static const String routeName = '/cart';

  static Widget builder(BuildContext context) {
    return const CartPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text('Cart'),
      ),
      body: Center(
        child: Text('Cart Page Content'),
      ),
    );
  }
}