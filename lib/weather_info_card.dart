import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({Key? key, required this.title, required this.info})
      : super(key: key);
  final String title;
  final String info;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, color: Colors.white),
          ),
          Text(
            info,
            style: const TextStyle(fontSize: 40.0, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
