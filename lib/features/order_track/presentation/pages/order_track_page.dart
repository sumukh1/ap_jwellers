import 'package:flutter/material.dart';
import 'package:myapp/static/AppColors.dart';

class OrderTrackPage extends StatelessWidget {
  static const String routeName = '/orderTrack';

  const OrderTrackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Track Order'),
        backgroundColor: AppColors.primaryColor,
      ),
      body: const Center(
        child: Text('Order Track Page'),
      ),
    );
  }
}