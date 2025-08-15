import 'package:flutter/material.dart';
import 'package:myapp/static/AppColors.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner Placeholder
          Container(
            height: 150,
            color: AppColors.primary,
            child: Center(
              child: Text(
                'Promotional Banner',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.buttonText,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16.0), // Add some spacing below the banner
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Coins',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,
              ),
            ),
          ),
          // Placeholder for Coin Products
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 4, // Placeholder count
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        color: AppColors.grey, // Placeholder for image
                      ),
                      const SizedBox(width: 16.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Coin ${index + 1}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textColor)),
                          Text('\$1000', style: TextStyle(fontSize: 14, color: AppColors.buttonBackground)), // Placeholder price
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Biscuits',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,
              ),
            ),
          ),
          // Placeholder for Biscuit Products
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 4, // Placeholder count
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        color: AppColors.grey, // Placeholder for image
                      ),
                      const SizedBox(width: 16.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Biscuit ${index + 1}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textColor)),
                          Text('\$500', style: TextStyle(fontSize: 14, color: AppColors.buttonBackground)), // Placeholder price
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}