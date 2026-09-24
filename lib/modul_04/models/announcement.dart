class Announcement {
  final String id;
  final String title;
  final String content;
  final String author;
  final String description;
  final String category;
  final DateTime date;
  final int readCount;

  Announcement({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.description,
    required this.category,
    required this.date,
    required this.readCount,
  });

  factory Announcement.fromJson(Map<String, dynamic> json) {
    return Announcement(
      // id: json['id'] is int ? json['id'] as int : int.tryParse(json['id'].toString) ?? 0,
      id: json['id'].toString(),
      title: json['title'] as String,
      content: json['content'] as String,
      author: json['author'] as String,
      description: json['description'] as String? ?? '',
      category: json['category'] as String,
      date: DateTime.parse(json['date'] as String),
      readCount: json['readCount'] as int,
    );
  }

  static List<Announcement> getSampleAnnouncements() {
    return <Announcement>[
      Announcement(
        id: '1',
        title: 'Pendaftaran Beasiswa PPA 2026',
        content: 'Pendaftaran beasiswa PPA dibuka mulai tanggal 1 Oktober 2026.',
        author: 'Bagian Akademik Poliwangi',
        description: 'Pendaftaran beasiswa PPA dibuka mulai tanggal 1 Oktober 2026. Mahasiswa yang berminat dapat mengisi formulir pendaftaran di portal akademik.',
        category: 'Beasiswa',
        date: DateTime(2026, 9, 1),
        readCount: 120,
      ),
      Announcement(
        id: '2',
        title: 'Jadwal UTS Semester Ganjil',
        content: 'Jadwal Ujian Tengah Semester dapat dilihat di portal akademik.',
        author: 'Bagian Akademik Poliwangi',
        description: 'Jadwal Ujian Tengah Semester dapat dilihat di portal akademik.',
        category: 'Akademik',
        date: DateTime(2026, 9, 15),
        readCount: 89,
      ),
      Announcement(
        id: '3',
        title: 'Lomba Karya Ilmiah Mahasiswa',
        content: 'Pendaftaran lomba karya ilmiah tingkat nasional dibuka.',
        author: 'Bagian Kemahasiswaan',
        description: 'Pendaftaran lomba karya ilmiah tingkat nasional dibuka. Mahasiswa dapat mendaftar melalui portal kemahasiswaan.',
        category: 'Prestasi',
        date: DateTime(2026, 9, 20),
        readCount: 45,
      ),
    ];
  }
}
