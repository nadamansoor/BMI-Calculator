import 'package:flutter/material.dart';

class BMICalculator extends StatefulWidget {
  const BMICalculator({super.key});

  @override
  State<BMICalculator> createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  String genderSelection = '';
  final TextEditingController nameController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();

  final TextEditingController heightController = TextEditingController(text: '160');
  final TextEditingController weightController = TextEditingController(text: '60');

  int height = 160;
  int weight = 60;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            CustomTextFormField(controller: birthDateController),
            const SizedBox(height: 20),
            const Row(
              children: [
                Text(
                  'Choose Gender',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
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

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Your BMI Result'),
        content: Text('Your BMI is ${bmi.toStringAsFixed(1)}'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    birthDateController.dispose();
    heightController.dispose();
    weightController.dispose();
    super.dispose();
  }
}

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;

  const CustomTextFormField({
    super.key,
    required this.controller,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
    );
  }
}

class GenderOption extends StatelessWidget {
  final String gender;
  final bool isSelected;
  final String imagePath;
  final VoidCallback onTap;

  const GenderOption({
    super.key,
    required this.gender,
    required this.isSelected,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? const Color(0xFFF1B44A) : Colors.transparent,
                width: 3,
              ),
            ),
            child: ClipOval(
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          gender,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}

class StepperBox extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final ValueChanged<String> onChanged;

  const StepperBox({
    super.key,
    required this.label,
    required this.controller,
    required this.onIncrement,
    required this.onDecrement,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        const SizedBox(height: 10),
        Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: onDecrement,
              ),
              Expanded(
                child: TextField(
                  controller: controller,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  onChanged: onChanged,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: onIncrement,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
