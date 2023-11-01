import 'package:flutter/material.dart';

class CustomCharts extends StatefulWidget {
  const CustomCharts({super.key});

  @override
  State<CustomCharts> createState() => _CustomChartsState();
}

class _CustomChartsState extends State<CustomCharts> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 350,
          left: 30,
          child: Container(
            height: 300,
            width: 300,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/statistik.png',
                  fit: BoxFit.cover,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
