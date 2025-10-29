import 'package:flutter/material.dart';
import 'package:pertemuan4/API/api_service.dart';
import 'package:pertemuan4/models/meal_model.dart';

void main() {
  runApp(const ArtikelApp());
}

class ArtikelApp extends StatelessWidget {
  const ArtikelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Artikel",
      home: const ArtikelScreen(),
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
  final ScrollController _scrollController = ScrollController();
  bool _showScrollToTopButton = false;

  @override
  void initState() {
    super.initState();
    _articlesFuture = ApiService().fetchMeals();

    // Pantau posisi scroll untuk munculkan tombol otomatis
    _scrollController.addListener(() {
      if (_scrollController.offset >= 300 && !_showScrollToTopButton) {
        setState(() => _showScrollToTopButton = true);
      } else if (_scrollController.offset < 300 && _showScrollToTopButton) {
        setState(() => _showScrollToTopButton = false);
      }
    });
  }

  Future<void> refreshArticles() async {
    // Fungsi ini bakal dipanggil saat user tarik ke bawah (pull-to-refresh)
    setState(() {
      _articlesFuture = ApiService().fetchMeals();
    });
  }

  void scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Artikel Terupdate"), centerTitle: true),
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
            return RefreshIndicator(
              onRefresh: refreshArticles,
              child: ListView.builder(
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  final article = articles[index];
                  return Card(
                    margin: const EdgeInsets.all(12),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
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
                              child: Center(
                                child: Text("Gambar tidak tersedia"),
                              ),
                            ),
                          const SizedBox(height: 12),
                          Text(
                            article.judul,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(child: Text('Tidak Ada Berita Terkini'));
          }
        },
      ),

      // Tombol Scroll ke Atas (muncul dinamis)
      floatingActionButton: _showScrollToTopButton
          ? FloatingActionButton(
              onPressed: scrollToTop,
              child: const Icon(Icons.arrow_upward),
            )
          : null,
    );
  }
}
