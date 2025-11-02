import 'package:flutter/material.dart';

void main() {
  runApp(const MortgageCalculatorApp());
}

class MortgageCalculatorApp extends StatelessWidget {
  const MortgageCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mortgage Calculator',
      theme: ThemeData(
        primaryColor: const Color(0xFFD6B98B),
        scaffoldBackgroundColor: const Color(0xFFFFF5E6),
        fontFamily: 'Roboto',
      ),
      home: const MortgageCalculatorScreen(),
    );
  }
}

class MortgageCalculatorScreen extends StatefulWidget {
  const MortgageCalculatorScreen({super.key});

  @override
  State<MortgageCalculatorScreen> createState() =>
      _MortgageCalculatorScreenState();
}

class _MortgageCalculatorScreenState extends State<MortgageCalculatorScreen> {
  double homePrice = 150000;
  double downPayment = 18000;
  double interestRate = 7.5;
  int loanTerm = 30;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Header(),
              const SizedBox(height: 30),

              // Home Price Slider
              SliderInput(
                label: 'Home Price',
                value: homePrice,
                max: 9999,
                onChanged: (value) => setState(() => homePrice = value),
              ),

              const SizedBox(height: 20),

              // Down Payment Slider
              SliderInput(
                label: 'Down Payment',
                value: downPayment,
                max: 999999,
                onChanged: (value) => setState(() => downPayment = value),
              ),

              const SizedBox(height: 20),

              // Interest Rate Input
              TextInputField(
                label: 'Interest Rate',
                suffixText: '%',
                initialValue: interestRate.toString(),
                onChanged: (value) =>
                    setState(() => interestRate = double.tryParse(value) ?? 0),
              ),

              const SizedBox(height: 20),

              // Loan Term Buttons
              SelectableTermButtons(
                label: 'Loan Term (Years)',
                terms: const [30, 20, 15, 10],
                selectedTerm: loanTerm,
                onTermSelected: (term) => setState(() => loanTerm = term),
              ),

              const Spacer(),

              // Calculate Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5C3A00),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text(
                    'Calculate',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Reusable Widgets

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFD6B98B),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.home, color: Colors.white),
            ),
            const SizedBox(width: 10),
            const Text(
              'Mortgage Calculator',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const Icon(Icons.dark_mode), // optional, can remove
      ],
    );
  }
}

class SliderInput extends StatelessWidget {
  final String label;
  final double value;
  final double max;
  final ValueChanged<double> onChanged;

  const SliderInput({
    super.key,
    required this.label,
    required this.value,
    required this.max,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 8),
        Slider(
          min: 0,
          max: max,
          value: value,
          onChanged: onChanged,
          activeColor: const Color(0xFFD6B98B),
        ),
        Text('\$${value.toStringAsFixed(0)}'),
      ],
    );
  }
}

class TextInputField extends StatelessWidget {
  final String label;
  final String? suffixText;
  final String initialValue;
  final ValueChanged<String> onChanged;

  const TextInputField({
    super.key,
    required this.label,
    this.suffixText,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 8),
        TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFEEDCCF),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            suffixText: suffixText,
          ),
          controller: TextEditingController(text: initialValue),
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class SelectableTermButtons extends StatelessWidget {
  final String label;
  final List<int> terms;
  final int selectedTerm;
  final ValueChanged<int> onTermSelected;

  const SelectableTermButtons({
    super.key,
    required this.label,
    required this.terms,
    required this.selectedTerm,
    required this.onTermSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: terms.map((term) {
            final isSelected = selectedTerm == term;
            return GestureDetector(
              onTap: () => onTermSelected(term),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF5C3A00) : const Color(0xFFEEDCCF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '$term',
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
