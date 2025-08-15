import 'package:flutter/material.dart';
import 'package:myapp/core/widget/form.dart';
import 'package:myapp/static/AppColors.dart'; // Assuming AppColors is in static

class GiftsView extends StatelessWidget {
  const GiftsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10, // Placeholder count
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min, // Use min to wrap content
              children: [
                // Placeholder Image
                Container(
                  height: 150,
                  width: double.infinity, // Make image placeholder fill width
                  color: AppColors.grey.withOpacity(0.5), // Placeholder color
                  // You can replace this with an actual Image widget later, using BoxFit.cover
                ),
                const SizedBox(height: 12),
                Text(
                  'Gift Item ${index + 1}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor,
                  ),
                ),
                const SizedBox(height: 8),
                Expanded( // Allow description to take available space
                  child: Text(
                    'A lovely gift description goes here. This is a placeholder for a longer description to see how the text wraps and the layout adjusts. We can add more details about the gift item here.',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textColor.withOpacity(0.7),
                    ),
                    maxLines: 3, // Limit description to a few lines
                    overflow: TextOverflow.ellipsis, // Add ellipsis if text overflows
                  ),
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Button(
                    label: 'Buy Now', // Keep ElevatedButton as is for now
                    child: Text(
                      'Buy Now',
                      style: TextStyle(color: AppColors.buttonText),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}