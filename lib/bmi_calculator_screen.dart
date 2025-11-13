import 'package:flutter/material.dart';

class BMICalculatorScreen extends StatefulWidget {
  const BMICalculatorScreen({super.key});

  @override
  State<BMICalculatorScreen> createState() => _BMICalculatorScreenState();
}

class _BMICalculatorScreenState extends State<BMICalculatorScreen> {
  int _height = 170;
  int _weight = 70;
  double _bmi = 0;
  String _bmiCategory = '';
  Color _bmiColor = Colors.grey;

  @override
  void initState() {
    super.initState();
    _calculateBMI();
  }

  void _calculateBMI() {
    final heightInMeters = _height / 100;
    final bmi = _weight / (heightInMeters * heightInMeters);
    
    setState(() {
      _bmi = double.parse(bmi.toStringAsFixed(1));
      
      if (_bmi < 18.5) {
        _bmiCategory = 'Underweight';
        _bmiColor = const Color(0xFFFFB74D); // Orange
      } else if (_bmi < 25) {
        _bmiCategory = 'Normal';
        _bmiColor = const Color(0xFF4CAF50); // Green
      } else if (_bmi < 30) {
        _bmiCategory = 'Overweight';
        _bmiColor = const Color(0xFFFF9800); // Dark Orange
      } else {
        _bmiCategory = 'Obese';
        _bmiColor = const Color(0xFFF44336); // Red
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'BMI Calculator',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Height Card
            _buildMeasurementCard(
              title: 'Height',
              value: _height,
              unit: 'cm',
              min: 100,
              max: 220,
              onChanged: (value) {
                setState(() {
                  _height = value.toInt();
                });
              },
            ),
            const SizedBox(height: 20),
            
            // Weight Card
            _buildMeasurementCard(
              title: 'Weight',
              value: _weight,
              unit: 'kg',
              min: 30,
              max: 150,
              onChanged: (value) {
                setState(() {
                  _weight = value.toInt();
                });
              },
            ),
            const SizedBox(height: 32),
            
            // Calculate Button
            SizedBox(
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
            ),
            const SizedBox(height: 32),
            
            // BMI Result Cards
            _buildBMIResults(),
          ],
        ),
      ),
    );
  }

  Widget _buildMeasurementCard({
    required String title,
    required int value,
    required String unit,
    required double min,
    required double max,
    required ValueChanged<double> onChanged,
  }) {
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
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF6C757D),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                '$value',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                unit,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF6C757D),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Slider(
            value: value.toDouble(),
            min: min,
            max: max,
            divisions: (max - min).toInt(),
            onChanged: onChanged,
            activeColor: const Color(0xFF2196F3),
            inactiveColor: const Color(0xFFDEE2E6),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${min.toInt()}',
                style: const TextStyle(
                  color: Color(0xFF6C757D),
                  fontSize: 12,
                ),
              ),
              Text(
                '${max.toInt()}',
                style: const TextStyle(
                  color: Color(0xFF6C757D),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBMIResults() {
    return Column(
      children: [
        // Your BMI Card
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: _bmiColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _bmiColor.withOpacity(0.3)),
          ),
          child: Column(
            children: [
              Text(
                'Your BMI',
                style: TextStyle(
                  fontSize: 16,
                  color: _bmiColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _bmi.toString(),
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w700,
                  color: _bmiColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _bmiCategory,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: _bmiColor,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        
        // BMI Categories
        _buildBMICategories(),
      ],
    );
  }

  Widget _buildBMICategories() {
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
          _buildCategoryRow('Underweight', '0 - 18.5', const Color(0xFFFFB74D)),
          _buildDivider(),
          _buildCategoryRow('Normal', '18.5 - 25', const Color(0xFF4CAF50)),
          _buildDivider(),
          _buildCategoryRow('Overweight', '25 - 30', const Color(0xFFFF9800)),
          _buildDivider(),
          _buildCategoryRow('Obese', '30+', const Color(0xFFF44336)),
        ],
      ),
    );
  }

  Widget _buildCategoryRow(String category, String range, Color color) {
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
              category,
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
      color: Colors.grey[200],
    );
  }
}