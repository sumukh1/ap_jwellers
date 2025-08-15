import 'package:flutter/material.dart';
import 'package:myapp/static/AppColors.dart'; // Assuming AppColors is here
import 'package:myapp/core/widget/styles.dart'; // Assuming Styles for spacing

class EGoldView extends StatelessWidget {
  const EGoldView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Current E-Gold Price Section
          Card(
            color: AppColors.white,
            elevation: 4.0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Current E-Gold Price',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textColor,
                    ),
                  ),
                  Styles.gap8, // Assuming Styles provides spacing
                  Text(
                    '\$1950.00 / gram', // Placeholder price
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: AppColors.buttonBackground,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Styles.gap16, // Assuming Styles provides spacing

          // Buy/Sell Options Section
          Card(
            color: AppColors.white,
            elevation: 4.0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'E-Gold Actions',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textColor,
                    ),
                  ),
                  Styles.gap16, // Assuming Styles provides spacing
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Implement Buy E-Gold action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttonBackground,
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                    ),
                    child: Text(
                      'Buy E-Gold',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: AppColors.buttonText,
                      ),
                    ),
                  ),
                  Styles.gap12, // Assuming Styles provides spacing
                  OutlinedButton(
                    onPressed: () {
                      // TODO: Implement Sell E-Gold action
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: AppColors.buttonBackground),
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                    ),
                    child: Text(
                      'Sell E-Gold',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: AppColors.buttonBackground,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Styles.gap16, // Assuming Styles provides spacing

          // Graph or History Section (Placeholder)
          Expanded(
            child: Card(
              color: AppColors.white,
              elevation: 4.0,
              child: Center(
                child: Text(
                  'E-Gold Price Graph/History Placeholder',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: AppColors.grey,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}