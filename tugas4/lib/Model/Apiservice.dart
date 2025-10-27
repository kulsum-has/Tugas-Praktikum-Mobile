import 'dart:convert';
import 'package:http/http.dart' as http;

class Artikel{

  final String kategori;
  final String? deskripsi;
  final String? gambar;

  Artikel({
    required this.kategori, this.deskripsi, this.gambar
  });

  factory Artikel.fromJson(Map<String, dynamic> json){
    return Artikel(
      kategori: json['strCategory'],
      deskripsi: json['strCategoryDescription'],
      gambar: json['strCategoryThumb']
      );
  }
}


class Apiservice {

  static const _baseUrl = "https://www.themealdb.com/api/json/v1/1/categories.php";


  Future<List<Artikel>> fetchArticles() async{

    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if(response.statusCode == 200){
        final Map<String, dynamic> json = jsonDecode(response.body);
        final List<dynamic> articlesjson = json['categories'];
        return articlesjson.map( (json) => Artikel.fromJson(json) ).toList();

      } else {
        throw Exception('Failed to Load : ${response.statusCode} ');
      }
    } catch (e) {
      throw Exception('Failed to Connect $e');
    }
  }
}