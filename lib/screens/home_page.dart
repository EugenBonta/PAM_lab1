import 'dart:math';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _value = 1; // Slider value for months
  double _calculatedAmount = 0; // Amount to be calculated
  final TextEditingController _amountController = TextEditingController(); // For loan amount input
  final TextEditingController _percentController = TextEditingController(); // For interest rate input

  void _calculateAmount() {
    setState(() {
      // Fetch values from the text fields
      double loanAmount = double.tryParse(_amountController.text) ?? 0;
      double annualInterestRate = double.tryParse(_percentController.text) ?? 0;

      // Convert annual interest rate to a monthly interest rate
      double monthlyInterestRate = annualInterestRate / 1 / 100;
      int months = _value.round();

      // Use the amortization formula if the interest rate is not 0
      if (monthlyInterestRate != 0) {
        _calculatedAmount = (loanAmount * monthlyInterestRate *
            pow(1 + monthlyInterestRate, months)) /
            (pow(1 + monthlyInterestRate, months) - 1);
      } else {
        // If the interest rate is 0, it's a simple division of loan amount by months
        _calculatedAmount = loanAmount / months;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Container(
          margin: const EdgeInsets.only(top: 80),
          child: Center(
            child: Text(
              'Loan Calculator',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                fontFamily: 'Helvetica',
              ),
            ),
          ),
        ),

        // ######### Amount #########
        Container(
          margin: const EdgeInsets.only(top: 20, left: 10),
          child: const Text(
            'Enter Amount',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Helvetica',
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5, left: 10, right: 10),
          child: TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white.withOpacity(0.6),
              hintText: 'Amount',
              hintStyle: TextStyle(
                color: Colors.grey[400],
                fontWeight: FontWeight.bold,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),

        // ######### Slider for Months #########
        Container(
          margin: const EdgeInsets.only(top: 20, left: 10),
          child: const Text(
            'Enter number of Months',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Helvetica',
            ),
          ),
        ),

        // Slider
        Container(
          child: Slider(
            value: _value,
            min: 1, // Change the minimum value to 1
            max: 60,
            divisions: 59, // Update divisions accordingly
            label: _value.round().toString(), // Show the selected value above the slider point
            onChanged: (value) {
              setState(() {
                _value = value;
              });
            },
          ),
        ),

        // Min and Max labels below the slider
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('1'), // Updated min value label
              Text('60'), // Max value
            ],
          ),
        ),

        // ######### Percent #########
        Container(
          margin: const EdgeInsets.only(top: 20, left: 10),
          child: const Text(
            'Enter % per Month',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Helvetica',
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5, left: 10, right: 10),
          child: TextField(
            controller: _percentController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white.withOpacity(0.6),
              hintText: 'Percent',
              hintStyle: TextStyle(
                color: Colors.grey[400],
                fontWeight: FontWeight.bold,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),

        // ######### Calculation Card #########
        Center(
          child: Container(
            margin: const EdgeInsets.only(top: 30, left: 10, right: 10),
            height: 180,
            width: 350, // Set a fixed width for the card container
            decoration: BoxDecoration(
              color: Colors.grey[100], // Outer card background color
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                ),
              ],
            ),
            child: Column(
              children: [
                // Top section (Text) with 70% of the height
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ), // Only top corners are rounded
                      color: const Color.fromARGB(
                          255, 225, 229, 232), // Top rectangular color
                    ),
                    child: const Text(
                      'You will pay the approximate amount monthly:',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Helvetica',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),

                // Bottom section (Number) full width
                Container(
                  width: double.infinity, // Take the full width of the parent
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ), // Only bottom corners are rounded
                    color: const Color.fromARGB(
                        255, 244, 246, 247), // Bottom rectangular color
                  ),
                  child: Text(
                    '${_calculatedAmount.toStringAsFixed(2)}€',
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Helvetica',
                      color: Color.fromARGB(255, 9, 81, 223),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),

        // ######### Calculate Button #########
        Container(
          margin: const EdgeInsets.only(top: 30, left: 10, right: 10),
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _calculateAmount,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 15),
              backgroundColor: Colors.blueAccent,
            ),
            child: const Text(
              'Calculate',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }
}