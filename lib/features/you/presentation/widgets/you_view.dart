import 'package:flutter/material.dart';
import 'package:myapp/static/AppColors.dart';
import 'package:myapp/core/widget/styles.dart';

class YouView extends StatelessWidget {
  const YouView({super.key});

  @override
  Widget build(BuildContext context) {
    // Placeholder content for the You tab (User Profile)
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Information Section
          Card(
            elevation: 2.0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: AppColors.primary,
                        child: Icon(
                          Icons.person,
                          size: 40,
                          color: AppColors.white,
                        ),
                      ),
                      Styles.gap16,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'John Doe', // Placeholder User Name
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textColor,
                            ),
                          ),
                          Text(
                            'johndoe@example.com', // Placeholder User Email
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Styles.gap16,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Orders',
                            style:
                                TextStyle(fontSize: 14, color: AppColors.grey),
                          ),
                          Text(
                            '5', // Placeholder Order Count
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textColor),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Wishlist',
                            style:
                                TextStyle(fontSize: 14, color: AppColors.grey),
                          ),
                          Text(
                            '10', // Placeholder Wishlist Count
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Styles.gap16,

          // Order History Section
          Card(
            elevation: 2.0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order History',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textColor),
                  ),
                  Styles.gap8,
                  ListTile(
                    leading: Icon(Icons.shopping_bag_outlined),
                    title: Text('Order #12345'),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      // TODO: Navigate to order details
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.shopping_bag_outlined),
                    title: Text('Order #12344'),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      // TODO: Navigate to order details
                    },
                  ),
                  // Add more placeholder order ListTiles
                ],
              ),
            ),
          ),
          Styles.gap16,

          // Settings Section
          Card(
            elevation: 2.0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Settings',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textColor),
                  ),
                  Styles.gap8,
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Account Settings'),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      // TODO: Navigate to account settings
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.notifications),
                    title: Text('Notifications'),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      // TODO: Navigate to notifications settings
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.privacy_tip_outlined),
                    title: Text('Privacy Policy'),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      // TODO: Navigate to privacy policy
                    },
                  ),
                ],
              ),
            ),
          ),
          Styles.gap16,

          // Logout Button
          Center(
            child: ElevatedButton(
              onPressed: () {
                // TODO: Implement logout logic
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.buttonBackground,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                textStyle: TextStyle(fontSize: 16),
              ),
              child: Text(
                'Logout',
                style: TextStyle(color: AppColors.buttonText),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
