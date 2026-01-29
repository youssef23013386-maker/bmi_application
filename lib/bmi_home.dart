import 'dart:math';
import 'package:bmi_application/bmi_result.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isMale = true;
  double height = 180;
  int weight = 90;
  int age = 18;

  @override
  Widget build(BuildContext context) {
    double bmi = weight / pow(height / 100, 2);

    return Scaffold(
      backgroundColor: const Color(0xFF0E0F1A),
      appBar: AppBar(
        title: const Text(
          'BMI',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF0E0F1A),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            /// MALE - FEMALE
            Expanded(
              child: Row(
                children: [
                  _genderCard(
                    icon: Icons.male,
                    text: "Male",
                    selected: isMale,
                    onTap: () {
                      setState(() => isMale = true);
                    },
                  ),
                  const SizedBox(width: 8),
                  _genderCard(
                    icon: Icons.female,
                    text: "Female",
                    selected: !isMale,
                    onTap: () {
                      setState(() => isMale = false);
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// HEIGHT
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1D1E33),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Height",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 25,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          height.round().toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          "cm",
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Slider(
                      value: height,
                      min: 60,
                      max: 220,
                      activeColor: const Color(0xFFE83D66),
                      inactiveColor: Colors.grey,
                      onChanged: (v) {
                        setState(() => height = v);
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// WEIGHT & AGE
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: _counterCard(
                      title: "Weight",
                      value: weight,
                      onPlus: () {
                        setState(() => weight++);
                      },
                      onMinus: () {
                        setState(() {
                          if (weight > 1) weight--;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _counterCard(
                      title: "Age",
                      value: age,
                      onPlus: () {
                        setState(() => age++);
                      },
                      onMinus: () {
                        setState(() {
                          if (age > 0) age--;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            /// CALCULATE BUTTON
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE83D66), // لون الصورة
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ResultScreen(bmi: bmi),
                    ),
                  );
                },
                child: const Text(
                  "Calculate",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
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

  // ================= COMPONENTS =================

  Widget _genderCard({
    required IconData icon,
    required String text,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: selected ? const Color(0xFFE83D66) : const Color(0xFF1D1E33),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: Colors.white),
              const SizedBox(height: 8),
              Text(
                text,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _counterCard({
    required String title,
    required int value,
    required VoidCallback onPlus,
    required VoidCallback onMinus,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1D1E33),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 8),
          Text(
            value.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: onMinus,
                icon: const Icon(Icons.remove, color: Colors.white),
              ),
              IconButton(
                onPressed: onPlus,
                icon: const Icon(Icons.add, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
