import 'package:flutter/material.dart';
import 'package:loancalculator/screens/home_page.dart';

void main() => runApp(LoanCalculator(
));

class LoanCalculator extends StatelessWidget {
  LoanCalculator({super.key});

  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      home: Scaffold(
          body: HomePage()
      )

    );

  }
}

