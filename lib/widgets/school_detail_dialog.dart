import 'package:flutter/material.dart';
import '../models/school.dart';

class SchoolDetailDialog extends StatelessWidget {
  final School school;

  const SchoolDetailDialog({Key? key, required this.school}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
  }
}
