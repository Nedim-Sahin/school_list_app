import 'package:flutter/material.dart';
import '../models/school.dart';

class SchoolList extends StatelessWidget {
  final List<School> schools;
  final Function(School) onTap;

  const SchoolList({Key? key, required this.schools, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: schools.length,
      itemBuilder: (context, index) {
        final school = schools[index];
        return ListTile(
          title: Text(school.name),
          subtitle: Text("Müdür: ${school.mudur}, Öğretmen Sayısı: ${school.ogretmenSayisi}"),
          onTap: () => onTap(school),
        );
      },
    );
  }
}
