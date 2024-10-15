import 'package:flutter/material.dart';
import '../models/school.dart';

class SchoolDetailDialog extends StatelessWidget {
  final School school;

  const SchoolDetailDialog({Key? key, required this.school}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0), // Köşeleri yuvarlak
      ),
      title: Text(
        school.name,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), // Başlık stilini belirledik
      ),
      content: SingleChildScrollView( // İçeriğin kaydırılabilir olmasını sağla
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: _buildDetails(), // Detayları oluştur
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Diyalog kutusunu kapat
          },
          child: Text('Kapat'),
        ),
      ],
    );
  }

  List<Widget> _buildDetails() {
    List<Widget> details = [];
    
    void addDetail(String title, String value) {
      if (value != '0') {
        details.add(_buildDetailRow(title, value));
      }
    }

    addDetail('Açılış Yılı:', '${school.acilisYili}');
    addDetail('Okul Türü:', school.okulTuru);
    addDetail('Müdür:', school.mudur);
    addDetail('Müdür Telefon:', school.mudurTelefon);
    addDetail('Öğretim Şekli:', school.ogretimSekli);
    addDetail('Derslik Sayısı:', '${school.derslikSayisi}');
    addDetail('Şube Sayısı:', '${school.subeSayisi}');
    addDetail('Öğretmen Sayısı:', '${school.ogretmenSayisi}');
    addDetail('Okul Öncesi Öğrenci Sayısı:', '${school.okulOncesiOgrenci}');
    addDetail('İlkokul Öğrenci Sayısı:', '${school.ilkokulOgrenci}');
    addDetail('Ortaokul Öğrenci Sayısı:', '${school.ortaokulOgrenci}');
    addDetail('Lise Öğrenci Sayısı:', '${school.liseOgrenci}');
    addDetail('Hizmetli Sayısı:', '${school.hizmetliSayisi}');

    return details;
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0), // Satırlar arası boşluk
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }
}
