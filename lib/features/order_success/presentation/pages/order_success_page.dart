import 'package:flutter/material.dart';
import 'package:myapp/static/AppColors.dart';

class OrderSuccessPage extends StatelessWidget {
  static const String routeName = '/order-success';

  const OrderSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Successful'),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle_outline,
              size: 100,
              color: AppColors.successColor,
            ),
            const SizedBox(height: 20),
            Text(
              'Your order has been placed successfully!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Thank you for your purchase.',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.textColor.withOpacity(0.7),
              ),
            ),
            // You can add more details here, like order number or a button to view order details
          ],
        ),
      ),
    );
  }
}