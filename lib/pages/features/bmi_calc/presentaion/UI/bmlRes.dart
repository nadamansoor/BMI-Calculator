import 'package:flutter/material.dart';

class BMIResultScreen extends StatelessWidget {
  final String name;
  final String gender;
  final String birthDate;
  final double height;
  final double weight;
  final double bmi;

  const BMIResultScreen({
    super.key,
    required this.name,
    required this.gender,
    required this.birthDate,
    required this.height,
    required this.weight,
    required this.bmi,
  });

  String getBMICategory() {
    if (bmi < 18.5) {
      return 'Under Weight';
    } else if (bmi < 25) {
      return 'Normal';
    } else if (bmi < 30) {
      return 'Overweight';
    } else {
      return 'Obese';
    }
  }

  String getDescription() {
    switch (getBMICategory()) {
      case 'Under Weight':
        return 'Your BMI is less than 18.5\n\nLorem ipsum dolor sit amet consectetur. Sagittis interdum dui enim imperdiet sapien cursus velit pharetra. Vivamus justo tempor dictum odio...';
      case 'Normal':
        return 'Your BMI is within the normal range.\n\nKeep up your healthy lifestyle and continue staying active and eating balanced meals.';
      case 'Overweight':
        return 'Your BMI indicates overweight.\n\nConsider a balanced diet and regular physical activity to improve your BMI.';
      case 'Obese':
        return 'Your BMI is high.\n\nConsult a healthcare provider for proper guidance and support.';
      default:
        return '';
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6F0FA),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 50),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFf7d292),
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              child: Column(
                children: [
                  Text(
                    name,
                    style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '$birthDate ${gender == 'male' ? 'male' : 'female'}',
                    style: const TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    bmi.toStringAsFixed(1),
                    style: const TextStyle(fontSize: 48, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'BMI Calc',
                    style: TextStyle(color: Colors.white60, fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '${height.toInt()} cm    |    ${weight.toInt()} kg',
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                  
                
                  Icon(
                      gender == 'male'
                          ? Icons.boy
                          : gender == 'female'
                              ? Icons.girl
                              : Icons.accessibility_new,
                      size: 90,
                      color: Colors.white,
                    )
                ],
              ),
            ),
            const SizedBox(height: 30),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF795a25),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    getBMICategory(),
                    style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    getDescription(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white70, fontSize: 15),
                  ),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor:const Color(0xFFF1B44A),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text(
                  'Calculate BMI Again',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}