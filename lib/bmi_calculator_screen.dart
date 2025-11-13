import 'package:flutter/material.dart';

class BMICalculatorScreen extends StatefulWidget {
  const BMICalculatorScreen({super.key});

  @override
  State<BMICalculatorScreen> createState() => _BMICalculatorScreenState();
}

class _BMICalculatorScreenState extends State<BMICalculatorScreen> {
  double _height = 170;
  double _weight = 70;
  double? _bmiResult;

  void _calculateBMI() {
    final heightInMeters = _height / 100;
    final bmi = _weight / (heightInMeters * heightInMeters);
    
    setState(() {
      _bmiResult = double.parse(bmi.toStringAsFixed(1));
    });
  }

  Color _getBMIColor() {
    if (_bmiResult == null) return Colors.grey;
    if (_bmiResult! < 18.5) return const Color(0xFFFFB74D);
    if (_bmiResult! < 25) return const Color(0xFF4CAF50);
    if (_bmiResult! < 30) return const Color(0xFFFF9800);
    return const Color(0xFFF44336);
  }

  String _getBMICategory() {
    if (_bmiResult == null) return '';
    if (_bmiResult! < 18.5) return 'Underweight';
    if (_bmiResult! < 25) return 'Normal';
    if (_bmiResult! < 30) return 'Overweight';
    return 'Obese';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        title: const Text(
          'BMI Calculator',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            // Height Card - Frame 1
            _buildHeightCard(),
            const SizedBox(height: 20),
            
            // Weight Card - Frame 2  
            _buildWeightCard(),
            const SizedBox(height: 32),
            
            // Calculate Button - Frame 3
            _buildCalculateButton(),
            const SizedBox(height: 32),
            
            // BMI Result - Frame 4 (hanya muncul setelah calculate)
            if (_bmiResult != null) _buildBMIResultCard(),
            if (_bmiResult != null) const SizedBox(height: 20),
            
            // BMI Categories - Frame 5
            _buildBMICategoriesCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeightCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE9ECEF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Height',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF6C757D),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                _height.toInt().toString(),
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 4),
              const Text(
                'cm',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF6C757D),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Slider(
            value: _height,
            min: 100,
            max: 220,
            divisions: 120,
            onChanged: (value) {
              setState(() {
                _height = value;
              });
            },
            activeColor: const Color(0xFF2196F3),
            inactiveColor: const Color(0xFFDEE2E6),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                '100',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF6C757D),
                ),
              ),
              Text(
                '220',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF6C757D),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWeightCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE9ECEF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Weight',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF6C757D),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                _weight.toInt().toString(),
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 4),
              const Text(
                'kg',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF6C757D),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Slider(
            value: _weight,
            min: 30,
            max: 150,
            divisions: 120,
            onChanged: (value) {
              setState(() {
                _weight = value;
              });
            },
            activeColor: const Color(0xFF2196F3),
            inactiveColor: const Color(0xFFDEE2E6),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                '30',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF6C757D),
                ),
              ),
              Text(
                '150',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF6C757D),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCalculateButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _calculateBMI,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2196F3),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: const Text(
          'Calculate BMI',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildBMIResultCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _getBMIColor().withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _getBMIColor().withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Text(
            'Your BMI',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: _getBMIColor(),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _bmiResult!.toStringAsFixed(1),
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w700,
              color: _getBMIColor(),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _getBMICategory(),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: _getBMIColor(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBMICategoriesCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE9ECEF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'BMI Categories',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          _buildCategoryItem('Underweight', '0 - 18.5', const Color(0xFFFFB74D)),
          _buildDivider(),
          _buildCategoryItem('Normal', '18.5 - 25', const Color(0xFF4CAF50)),
          _buildDivider(),
          _buildCategoryItem('Overweight', '25 - 30', const Color(0xFFFF9800)),
          _buildDivider(),
          _buildCategoryItem('Obese', '30+', const Color(0xFFF44336)),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(String title, String range, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
          Text(
            range,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF6C757D),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 20,
      thickness: 1,
      color: Colors.grey[300],
    );
  }
}