import 'package:flutter/material.dart';
import 'package:pertemuan4/API/api_service.dart';
import 'package:pertemuan4/models/meal_model.dart';

void main() {
  runApp(ArtikelApp());
}

class ArtikelApp extends StatelessWidget {
  const ArtikelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Artikel",
      home: ArtikelScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ArtikelScreen extends StatefulWidget {
  const ArtikelScreen({super.key});

  @override
  State<ArtikelScreen> createState() => _ArtikelScreenState();
}

class _ArtikelScreenState extends State<ArtikelScreen> {
  late Future<List<Meal>> _articlesFuture;

  @override
  void initState() {
    super.initState();
    _articlesFuture = ApiService().fetchMeals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Artikel Terupdate"), centerTitle: true),
      body: FutureBuilder<List<Meal>>(
        future: _articlesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Terjadi kesalahan: ${snapshot.error}',
                textAlign: TextAlign.center,
              ),
            );
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final articles = snapshot.data!;
            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                return Card(
                  margin: EdgeInsets.all(12),
                  elevation: 4,
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        if (article.linkGambar != null &&
                            article.linkGambar!.isNotEmpty)
                          Image.network(
                            article.linkGambar!,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.broken_image,
                                size: 100,
                                color: Colors.grey,
                              );
                            },
                          )
                        else
                          const SizedBox(
                            height: 100,
                            child: Center(child: Text("Gambar tidak tersedia")),
                          ),
                        SizedBox(height: 12),
                        Text(
                          article.judul,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Text('Tidak Ada Berita Terkini');
          }
        },
      ),
    );
  }
}
