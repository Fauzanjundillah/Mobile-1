class Article {
  final String judul;
  final String? deskripsi;
  final String? linkGambar;

  Article({required this.judul, this.deskripsi, this.linkGambar});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      judul: json['title'] ?? 'tidak ada judul',
      deskripsi: json['description'] as String?,
      linkGambar: json['urlToImage'] as String?,
    );
  }
}
