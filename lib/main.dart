import 'package:flutter/material.dart';
import 'models/school.dart';
import 'services/school_service.dart';
import 'widgets/school_search.dart';
import 'widgets/school_list.dart';
import 'widgets/school_detail_dialog.dart';

class SchoolSearchScreen extends StatefulWidget {
  @override
  _SchoolSearchScreenState createState() => _SchoolSearchScreenState();
}

class _SchoolSearchScreenState extends State<SchoolSearchScreen> {
  List<School> schools = [];
  List<School> filteredSchools = [];
  final SchoolService schoolService = SchoolService();

  @override
  void initState() {
    super.initState();
    _loadSchools();
  }

  Future<void> _loadSchools() async {
    final loadedSchools = await schoolService.loadSchools();
    setState(() {
      schools = loadedSchools;
      filteredSchools = loadedSchools;
    });
  }

  void _filterSchools(String query) {
    setState(() {
      filteredSchools = schools
          .where((school) => school.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _showSchoolDetails(BuildContext context, School school) {
    showDialog(
      context: context,
      builder: (context) => SchoolDetailDialog(school: school),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Okul Arama"),
      ),
      body: Column(
        children: [
          SchoolSearch(onChanged: _filterSchools),
          Expanded(
            child: SchoolList(
              schools: filteredSchools,
              onTap: (school) => _showSchoolDetails(context, school),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SchoolSearchScreen(),
  ));
}
