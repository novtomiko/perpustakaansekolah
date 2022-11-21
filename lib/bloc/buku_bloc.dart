import 'dart:convert';
import 'package:perpustakaansekolah/helpers/api.dart';
import 'package:perpustakaansekolah/helpers/api_url.dart';
import 'package:perpustakaansekolah/model/buku.dart';

class BukuBloc{
  static Future<List<Buku>> getBukus() async {
    String apiUrl = ApiUrl.listBuku;
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    List<dynamic> listBuku = (jsonObj as Map<String, dynamic>) ['data'];
    List<Buku> bukus = [];
    for(int i=0; i < listBuku.length; i++) {
      bukus.add(Buku.fromJson(listBuku[i]));
    }
    return bukus;
  }

  static Future addBuku({Buku buku}) async {
    String apiUrl = ApiUrl.createBuku;

    var body = {
      "kode_buku": buku.kodeBuku,
      "judul_buku":buku.judulBuku,
      "penulis_buku":buku.penulisBuku,
    };

    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future<bool> updateBuku({Buku buku}) async {
    String apiUrl = ApiUrl.updateBuku(buku.id);

    var body = {
      "kode_buku": buku.kodeBuku,
      "judul_buku":buku.judulBuku,
      "penulis_buku":buku.penulisBuku,
    };
    print("Body : $body");
    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['data'];
  }

  static Future<bool> deleteBuku({int id}) async {
    String apiUrl = ApiUrl.deleteBuku(id);

    var response = await Api().delete(apiUrl);
    var jsonObj = json.decode(response.body);
    return (jsonObj as Map<String, dynamic>)['data'];
  }
}