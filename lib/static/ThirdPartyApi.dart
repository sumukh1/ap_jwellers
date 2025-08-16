// ignore: file_names
import 'dart:convert';
import 'package:http/http.dart' as http;

const gramsInOunce = 31.1034768;

class ThirdPartyApi {
  static Future<double> goldPrice24KInINRPerGram() async {
    try {
      // Step 1: Fetch Gold Price (USD/oz)
      final goldResponse =
          await http.get(Uri.parse("https://api.gold-api.com/price/XAU"));
      if (goldResponse.statusCode != 200) {
        throw Exception("Failed to load gold price");
      }
      final goldData = jsonDecode(goldResponse.body);
      final double pricePerOunceUSD = goldData["price"] * 1.0;

      // Step 2: Convert to per gram USD
      const double gramsInOunce = 31.1034768;
      final double pricePerGramUSD = pricePerOunceUSD / gramsInOunce;

      final forexResponse = await http.get(
        Uri.parse("https://api.frankfurter.app/latest?from=USD&to=INR"),
      );
      if (forexResponse.statusCode != 200) {
        throw Exception("Failed to load forex rate");
      }
      final forexData = jsonDecode(forexResponse.body);
      final double usdToInr = forexData["rates"]["INR"] * 1.0;

      return pricePerGramUSD * usdToInr;
    } catch (e) {
      return 0;
    }
  }

  static Future<double> goldSilverInINRPerGram() async {
    try {
      final silverResponse =
          await http.get(Uri.parse("https://api.gold-api.com/price/XAG"));
      if (silverResponse.statusCode != 200) {
        throw Exception("Failed to load silver price");
      }

      final silverData = jsonDecode(silverResponse.body);
      final double pricePerOunceUSD = silverData["price"] * 1.0;
      final double pricePerGramUSD = pricePerOunceUSD / gramsInOunce;
      final forexResponse = await http.get(
        Uri.parse("https://api.frankfurter.app/latest?from=USD&to=INR"),
      );
      if (forexResponse.statusCode != 200) {
        throw Exception("Failed to load forex rate");
      }
      final forexData = jsonDecode(forexResponse.body);
      final double usdToInr = forexData["rates"]["INR"] * 1.0;
      return pricePerGramUSD * usdToInr;
    } catch (e) {
      return 0;
    }
  }
}
