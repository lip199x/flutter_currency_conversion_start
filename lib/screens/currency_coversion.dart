import 'package:flutter/material.dart';
import '../components/currency_conversion/currency_selection.dart';
import './result.dart';
import '../components/currency_conversion/currency_rate.dart';

class Converter extends StatefulWidget {
  @override
  _ConverterState createState() => _ConverterState();
}

class _ConverterState extends State<Converter> {
  String fromCurrency = "THB";
  String toCurrency = "USD";
  final currencyValue = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void fromCurrencyChange(String newFromCurrency) {
    //Code Here
    setState(() {
      fromCurrency = newFromCurrency;
    });
  }

  void toCurrencyChange(String newToCurrency) {
    //Code Here
    setState(() {
      toCurrency = newToCurrency;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(10),
        width: double.infinity,
        child: Column(
          children: [
            //TextFormField
            TextFormField(
              controller: currencyValue,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
              validator: (String currencyValue) {
                if (currencyValue.isEmpty) {
                  return "Please input Number";
                } else {
                  return null;
                }
              },
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                hintText: "Enter your Number",
                hintStyle: TextStyle(color: Colors.white24),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixIcon: Icon(
                  Icons.money,
                  color: Colors.pinkAccent,
                  size: 50,
                ),
              ),
            ),

            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "From Currency:",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            // From Currency Selection

            CurrencySelection(fromCurrency, fromCurrencyChange),

            SizedBox(
              height: 30,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "To Currency:",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            // To Currency Selection
            CurrencySelection(toCurrency, toCurrencyChange),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                //Code Here
                if (_formKey.currentState.validate()) {
                  final covertedValue = CurrencyExchangeRate.covertCurrency(
                      double.parse(currencyValue.text),
                      fromCurrency,
                      toCurrency);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return Result(double.parse(currencyValue.text),
                            covertedValue, fromCurrency, toCurrency);
                      },
                    ),
                  );
                }
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.red[500],
                ),
                margin: EdgeInsets.all(10),
                alignment: Alignment.center,
                child: Text(
                  "CONVERT !",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
