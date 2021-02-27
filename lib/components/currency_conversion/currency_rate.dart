import 'dart:convert';
import 'package:http/http.dart' as http;

class CurrencyExchangeRate {
  static var rates;

  CurrencyExchangeRate() {
    getCurrencyData();
  }

  static void getCurrencyData() async {
    http.Response response =
        await http.get('https://api.exchangeratesapi.io/latest');
    if (response.statusCode == 200) {
      String data = response.body;
      rates = jsonDecode(data)["rates"];
    }
  }

  static double getCurrencyExchange(String fromCurrency, String toCurrency) {
    double fromRate = ((rates as Map)[fromCurrency] as double);
    double toRate = ((rates as Map)[toCurrency] as double);
    return (fromRate / toRate);
  }

  static double covertCurrency(
      double currencyValue, String fromCurrency, String toCurrency) {
    //Code Here
    return getCurrencyExchange(toCurrency, fromCurrency) *
        currencyValue; //Replace Code Here
  }
}
