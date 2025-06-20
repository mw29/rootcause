import 'package:flutter/material.dart';
import 'package:rootcause_app/widgets/header.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final List<Map<String, dynamic>> historyData = [
    {
      "date": "2025-05-17",
      "name": "Hot Chocolate",
      "emoji": "🍫",
      "correlations": [
        {
          "name": "Bloating",
          "likelihood": "high",
          "description":
              "Hot chocolate contains both sugar and lactose which can contribute to bloating.",
        },
        {
          "name": "Migraines",
          "likelihood": "low",
          "description":
              "Hot chocolate is unlikely to cause migraines due to low tyramine content.",
        },
        {
          "name": "Brain Fog",
          "likelihood": "moderate",
          "description":
              "The high carbohydrate content in hot chocolate could lead to brain fog.",
        },
      ],
    },
    {
      "date": "2025-05-17",
      "name": "Oatmeal",
      "emoji": "🥣",
      "correlations": [
        {
          "name": "Bloating",
          "description": "Same very useful information from the report",
        },
        {
          "name": "Symptom 2",
          "description": "Same very useful information from the report",
        },
      ],
    },
  ];

  Map<int, bool> expandedMap = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _buildSection("Food History", historyData),
        ),
      ),
    );
  }

  List<Widget> _buildSection(String title, List<Map<String, dynamic>> items) {
    return [
      ...items.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;
        final isExpanded = expandedMap[index] ?? false;
        final correlations = item["correlations"] as List;

        return GestureDetector(
          onTap: () {
            setState(() {
              expandedMap[index] = !isExpanded;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(28),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 18,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(item["emoji"], style: const TextStyle(fontSize: 20)),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          item["name"],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Icon(
                        isExpanded ? Icons.expand_less : Icons.expand_more,
                        size: 24,
                        color: Colors.grey[700],
                      ),
                    ],
                  ),
                  if (isExpanded && correlations.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    ...correlations.map<Widget>((symptom) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: '${symptom["name"]}: ',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(text: symptom["description"]),
                            ],
                          ),
                        ),
                      );
                    }),
                  ],
                ],
              ),
            ),
          ),
        );
      }),
    ];
  }
}
