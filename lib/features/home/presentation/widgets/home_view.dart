import 'package:flutter/material.dart';
import 'package:myapp/static/AppColors.dart';
import 'package:myapp/static/ThirdPartyApi.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<StatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  double goldPrice = 0.0;
  @override
  void initState() {
    super.initState();
    fetchGoldPrice();
  }

  Future<void> fetchGoldPrice() async {
    final price = await ThirdPartyApi.goldPrice24KInINRPerGram();
    setState(() {
      goldPrice = price * 10;
    });
  }

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
              'Coins ${goldPrice}',
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
                margin:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                          Text('Coin ${index + 1}',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textColor)),
                          Text('\$1000',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors
                                      .buttonBackground)), // Placeholder price
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
                margin:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                          Text('Biscuit ${index + 1}',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textColor)),
                          Text('\$500',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors
                                      .buttonBackground)), // Placeholder price
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
