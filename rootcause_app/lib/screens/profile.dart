import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.close),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "About Me",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(width: 6),
                  GestureDetector(
                    onTap: () {
                      print('Info icon tapped, implement info modal');
                    },
                    child: Icon(Icons.info_outline, size: 18),
                  ),
                ],
              ),

              SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFF1F1F1),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.all(12),
                child: TextField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'Add conditions and known symptoms here...',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                    isCollapsed: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
