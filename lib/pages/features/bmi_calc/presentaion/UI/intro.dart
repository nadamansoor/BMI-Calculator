import 'package:flutter/material.dart';
import 'bmlCalc.dart';

class BMISplashScreen extends StatelessWidget {
  const BMISplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/intro.png',
              height: 250,
            ),
            const SizedBox(height: 30),
            const Text(
              'Know Your Body Better,\nGet Your BMI Score in Less\nThan a Minute!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                color: Color(0xFF3B3B3B),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'It takes just 30 seconds — and your health is worth it!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 110),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BMICalculator()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:const Color(0xFFF1B44A),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Get Start',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
