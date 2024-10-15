import 'package:flutter/material.dart';

class SchoolSearch extends StatelessWidget {
  final Function(String) onChanged;

  const SchoolSearch({Key? key, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: 'Okul adı ile ara',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
