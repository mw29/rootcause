import 'package:flutter/material.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});
  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: FilledButton(
                onPressed: () {
                  print("Scan Foods");
                },
                style: FilledButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.document_scanner, size: 32),
                      SizedBox(width: 10),
                      Text("Scan Food", style: TextStyle(fontSize: 32)),
                    ],
                  ),
                ),
              ),
            ),
            const Text('Manual Add Button Will Go Here'),
          ],
        ),
      ),
    );
  }
}
