import 'package:flutter/material.dart';

class Assignment07ListView extends StatelessWidget {
  const Assignment07ListView({super.key});

  static const List<String> names = [
    'Klay Lewis',
    'Ehsan Woodard',
    'River Bains',
    'Toyah Downs',
    'Tyla Kane',
    'Marcus Romero',
    'Farrah Parkes',
    'John Smith',
  ];

  String getTeamName(int index) {
    final teamIndex = (index ~/ 3) % 3;
    return 'Team ${String.fromCharCode(65 + teamIndex)}';
  }

  String getInitials(String name) {
    final words = name.trim().split(RegExp(r'\s+'));
    if (words.length >= 2) {
      return '${words[0][0]}${words[1][0]}'.toUpperCase();
    }
    return words.isNotEmpty ? words[0][0].toUpperCase() : '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Assignment-07 : List View')),
      body: ListView.builder(
        itemCount: names.length,
        itemBuilder: (context, index) {
          final isFirstInTeam = index % 3 == 0;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isFirstInTeam)
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    getTeamName(index),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              Card(
                child: ListTile(
                  leading: CircleAvatar(child: Text(getInitials(names[index]))),
                  title: Text(names[index]),
                  trailing: Icon(Icons.arrow_circle_right),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
