import 'package:BMI/pages/features/bmi_calc/presentaion/Components/stepper.dart';
import 'package:flutter/material.dart';
import 'package:BMI/pages/features/bmi_calc/presentaion/UI/bmlRes.dart';

class BMICalculator extends StatefulWidget {
  const BMICalculator({super.key});

  @override
  State<BMICalculator> createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  String genderSelection = '';
  final TextEditingController nameController = TextEditingController();

  final TextEditingController heightController = TextEditingController(text: '160');
  final TextEditingController weightController = TextEditingController(text: '60');

  int height = 160;
  int weight = 60;
  DateTime? selectedDate;

  int calculateAge(DateTime birthDate) {
    final today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month || (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'B M I',
          style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.w900),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            const SizedBox(height: 35),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Name', style: TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 10),
            CustomTextFormField(controller: nameController),
            const SizedBox(height: 20),
            const Row(
              children: [Text('Birth Date', style: TextStyle(fontSize: 16))],
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime(2000),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (picked != null) {
                  setState(() {
                    selectedDate = picked;
                  });
                }
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  selectedDate != null
                      ? '${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}'
                      : 'Select Birth Date',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Row(
              children: [
                Text('Choose Gender', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GenderOption(
                  gender: 'male',
                  isSelected: genderSelection == 'male',
                  imagePath: 'assets/images/male.jpeg',
                  onTap: () {
                    setState(() {
                      genderSelection = 'male';
                    });
                  },
                ),
                const SizedBox(width: 60),
                GenderOption(
                  gender: 'female',
                  isSelected: genderSelection == 'female',
                  imagePath: 'assets/images/female.jpeg',
                  onTap: () {
                    setState(() {
                      genderSelection = 'female';
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 30),
            StepperBox(
              label: 'Your Height(cm)',
              controller: heightController,
              onChanged: (value) {
                setState(() {
                  height = int.tryParse(value) ?? height;
                });
              },
              onIncrement: () {
                setState(() {
                  height++;
                  heightController.text = height.toString();
                });
              },
              onDecrement: () {
                setState(() {
                  if (height > 1) height--;
                  heightController.text = height.toString();
                });
              },
            ),
            const SizedBox(height: 20),
            StepperBox(
              label: 'Your Weight(kg)',
              controller: weightController,
              onChanged: (value) {
                setState(() {
                  weight = int.tryParse(value) ?? weight;
                });
              },
              onIncrement: () {
                setState(() {
                  weight++;
                  weightController.text = weight.toString();
                });
              },
              onDecrement: () {
                setState(() {
                  if (weight > 1) weight--;
                  weightController.text = weight.toString();
                });
              },
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _calculateBMI();
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  backgroundColor: const Color(0xFFF1B44A),
                ),
                child: const Text(
                  'Calculate BMI',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _calculateBMI() {
    final double heightInMeters = height / 100;
    final double bmi = weight / (heightInMeters * heightInMeters);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BMIResultScreen(
          name: nameController.text,
          gender: genderSelection,
          birthDate: selectedDate != null
              ? '${calculateAge(selectedDate!)} years old'
              : 'N/A',
          height: height.toDouble(),
          weight: weight.toDouble(),
          bmi: bmi,
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    heightController.dispose();
    weightController.dispose();
    super.dispose();
  }
}
