import 'package:flutter/material.dart';
import 'package:excel/excel.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle; // rootBundle kullanarak asset yüklemek için

class School {
  final String name;
  final int acilisYili;
  final String okulTuru;
  final String mudur;
  final String mudurTelefon;
  final String ogretimSekli;
  final int derslikSayisi;
  final int subeSayisi;
  final int ogretmenSayisi;
  final int okulOncesiOgrenci;
  final int ilkokulOgrenci;
  final int ortaokulOgrenci;
  final int liseOgrenci;
  final int hizmetliSayisi;

  School({
    required this.name,
    required this.acilisYili,
    required this.okulTuru,
    required this.mudur,
    required this.mudurTelefon,
    required this.ogretimSekli,
    required this.derslikSayisi,
    required this.subeSayisi,
    required this.ogretmenSayisi,
    required this.okulOncesiOgrenci,
    required this.ilkokulOgrenci,
    required this.ortaokulOgrenci,
    required this.liseOgrenci,
    required this.hizmetliSayisi,
  });
}

class SchoolSearchScreen extends StatefulWidget {
  @override
  _SchoolSearchScreenState createState() => _SchoolSearchScreenState();
}

class _SchoolSearchScreenState extends State<SchoolSearchScreen> {
  List<School> schools = [];
  List<School> filteredSchools = [];

  @override
  void initState() {
    super.initState();
    _loadExcelData(); // Load data when the screen is initialized
  }

  Future<void> _loadExcelData() async {
    try {
      // Dosyayı rootBundle ile assets klasöründen yükle
      final ByteData data = await rootBundle.load('assets/school_data.xlsx');
      var bytes = data.buffer.asUint8List();
      var excel = Excel.decodeBytes(bytes);

      // Doğru sayfayı kontrol et ve veriyi oku
      var sheet = excel['Sayfa1'];
      if (sheet != null) {
        for (var row in sheet.rows.skip(1)) {
          School school = School(
            name: row[2]?.value?.toString() ?? 'Unknown', // OKUL_KURUM_ADI
            acilisYili: row[3]?.value != null
                ? int.parse(row[3]!.value.toString())
                : 0, // ACILIS_YILI
            okulTuru: row[4]?.value?.toString() ?? '',
            mudur: row[5]?.value?.toString() ?? '',
            mudurTelefon: row[6]?.value?.toString() ?? '',
            ogretimSekli: row[7]?.value?.toString() ?? '',
            derslikSayisi: row[8]?.value != null
                ? int.parse(row[8]!.value.toString())
                : 0,
            subeSayisi: row[9]?.value != null
                ? int.parse(row[9]!.value.toString())
                : 0,
            ogretmenSayisi: row[10]?.value != null
                ? int.parse(row[10]!.value.toString())
                : 0,
            okulOncesiOgrenci: row[11]?.value != null
                ? int.parse(row[11]!.value.toString())
                : 0,
            ilkokulOgrenci: row[12]?.value != null
                ? int.parse(row[12]!.value.toString())
                : 0,
            ortaokulOgrenci: row[13]?.value != null
                ? int.parse(row[13]!.value.toString())
                : 0,
            liseOgrenci: row[14]?.value != null
                ? int.parse(row[14]!.value.toString())
                : 0,
            hizmetliSayisi: row[15]?.value != null
                ? int.parse(row[15]!.value.toString())
                : 0,
          );
          schools.add(school);
        }
        setState(() {
          filteredSchools = schools;
        });
      }
    } catch (e) {
      print("Excel dosyasını okurken hata oluştu: $e");
    }
  }

  void _filterSchools(String query) {
    setState(() {
      filteredSchools = schools
          .where((school) =>
              school.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _showSchoolDetails(BuildContext context, School school) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(school.name),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Açılış Yılı: ${school.acilisYili}'),
              Text('Okul Türü: ${school.okulTuru}'),
              Text('Müdür: ${school.mudur}'),
              Text('Müdür Telefon: ${school.mudurTelefon}'),
              Text('Öğretim Şekli: ${school.ogretimSekli}'),
              Text('Derslik Sayısı: ${school.derslikSayisi}'),
              Text('Şube Sayısı: ${school.subeSayisi}'),
              Text('Öğretmen Sayısı: ${school.ogretmenSayisi}'),
              Text('Okul Öncesi Öğrenci Sayısı: ${school.okulOncesiOgrenci}'),
              Text('İlkokul Öğrenci Sayısı: ${school.ilkokulOgrenci}'),
              Text('Ortaokul Öğrenci Sayısı: ${school.ortaokulOgrenci}'),
              Text('Lise Öğrenci Sayısı: ${school.liseOgrenci}'),
              Text('Hizmetli Sayısı: ${school.hizmetliSayisi}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
              child: Text('Kapat'),
            ),
          ],
        );
      },
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: _filterSchools,
              decoration: InputDecoration(
                labelText: 'Okul adı ile ara',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredSchools.length,
              itemBuilder: (context, index) {
                final school = filteredSchools[index];
                return ListTile(
                  title: Text(school.name),
                  subtitle: Text(
                      "Müdür: ${school.mudur}, Öğretmen Sayısı: ${school.ogretmenSayisi}"),
                  onTap: () => _showSchoolDetails(context, school),
                );
              },
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
