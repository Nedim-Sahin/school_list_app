import 'package:flutter/material.dart';

class SchoolSearch extends StatelessWidget {
  final Function(String) onChanged;

  const SchoolSearch({Key? key, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0), // Daha fazla boşluk ekledik
      child: TextField(
        onChanged: onChanged,
        style: TextStyle(color: Colors.black, fontSize: 16), // Yazı rengi ve boyutu
        decoration: InputDecoration(
          labelText: 'Okul adı ile ara',
          labelStyle: TextStyle(color: Colors.grey[600]), // Etiket rengi
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0), // Köşeleri yuvarlak
            borderSide: BorderSide(color: Colors.blue, width: 2), // Kenar rengi ve kalınlığı
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0), // Fokuslandığında da köşeleri yuvarlak
            borderSide: BorderSide(color: Colors.blueAccent, width: 2), // Fokuslandığında kenar rengi
          ),
          filled: true, // Arka plan rengini doldur
          fillColor: Colors.blue[50], // Arka plan rengi
          prefixIcon: Icon(Icons.search, color: Colors.blue), // Arama simgesi
          contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0), // İç boşluk
        ),
      ),
    );
  }
}

class SchoolSearchScreen extends StatefulWidget {
  @override
  _SchoolSearchScreenState createState() => _SchoolSearchScreenState();
}

class _SchoolSearchScreenState extends State<SchoolSearchScreen> {
  List<String> schools = List.generate(100, (index) => 'School $index'); // Örnek okul verisi
  List<String> filteredSchools = [];

  @override
  void initState() {
    super.initState();
    filteredSchools = schools; // Başlangıçta tüm okulları göster
  }

  void _filterSchools(String query) {
    setState(() {
      filteredSchools = schools
          .where((school) => school.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Okul Arama"),
      ),
      body: SingleChildScrollView( // Kaydırma alanı ekledik
        child: Column(
          children: [
            SchoolSearch(onChanged: _filterSchools),
            SizedBox(height: 16), // Arama alanı ile liste arasında boşluk
            ListView.builder(
              shrinkWrap: true, // Kaydırılabilir alan için boyut
              physics: NeverScrollableScrollPhysics(), // Bu alanı kaydırılmaz hale getir
              itemCount: filteredSchools.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(filteredSchools[index]),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SchoolSearchScreen(),
  ));
}
