import 'dart:convert';
import 'package:pertemuan4/models/article_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  // static const _apiKey = '7471976f73c64077b8cb6fcc567680b6';
  final String _baseUrl =
      'https://newsapi.org/v2/everything?q=tesla&from=2025-09-22&sortBy=publishedAt&apiKey=7471976f73c64077b8cb6fcc567680b6';

  Future<List<Article>> fetchArticles() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        final List<dynamic> articlesJson = json['articles'];

        return articlesJson.map((json) => Article.fromJson(json)).toList();
      } else {
        throw Exception('Gagal Memuat Artikel');
      }
    } catch (e) {
      throw Exception('Gagal Menghubungkan: $e');
    }
  }
}
