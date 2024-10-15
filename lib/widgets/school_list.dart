import 'package:flutter/material.dart';
import '../models/school.dart';

class SchoolList extends StatelessWidget {
  final List<School> schools;
  final Function(School) onTap;

  const SchoolList({Key? key, required this.schools, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 16.0), // Yukarıdan ve aşağıdan boşluk ekliyoruz
      itemCount: schools.length,
      itemBuilder: (context, index) {
        final school = schools[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          elevation: 5, // Gölge efektini artırdık
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0), // Köşeleri daha yuvarlak yaptık
          ),
          child: InkWell( // Tıklama efektini ekliyoruz
            borderRadius: BorderRadius.circular(15.0),
            onTap: () => onTap(school),
            child: Padding(
              padding: const EdgeInsets.all(16.0), // İç boşluk
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    school.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.blue[800], // Başlık için mavi tonları
                    ),
                  ),
                  SizedBox(height: 4), // Başlık ve alt metin arasında boşluk
                  Text(
                    "Müdür: ${school.mudur}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700], // Daha koyu gri
                    ),
                  ),
                  Text(
                    "Öğretmen Sayısı: ${school.ogretmenSayisi}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600], // Daha açık gri
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
