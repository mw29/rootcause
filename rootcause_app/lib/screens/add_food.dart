import 'package:flutter/material.dart';
import 'package:rootcause_app/screens/scan.dart';
import 'package:rootcause_app/widgets/header.dart';

class AddFoodScreen extends StatefulWidget {
  const AddFoodScreen({super.key});
  @override
  State<AddFoodScreen> createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends State<AddFoodScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: FilledButton(
                  onPressed:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ScanScreen(),
                        ),
                      ),
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
              GestureDetector(
                onTap: () => print("Add Food Manually Pressed"),
                child: Text(
                  "Add Food Manually",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
