import 'package:excel/excel.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import '../models/school.dart';

class SchoolService {
  Future<List<School>> loadSchools() async {
    List<School> schools = [];
    try {
      final ByteData data = await rootBundle.load('assets/school_data.xlsx');
      var bytes = data.buffer.asUint8List();
      var excel = Excel.decodeBytes(bytes);

      var sheet = excel['Sayfa1'];
      if (sheet != null) {
        for (var row in sheet.rows.skip(1)) {
          School school = School(
            name: row[2]?.value?.toString() ?? 'Unknown',
            acilisYili: row[3]?.value != null
                ? int.parse(row[3]!.value.toString())
                : 0,
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
      }
    } catch (e) {
      print("Excel dosyasını okurken hata oluştu: $e");
    }
    return schools;
  }
}
