class KrsCourse {
  final String code;
  final String name;
  final String lecturer;
  final int sks;
  final String description;

  const KrsCourse({
    required this.code,
    required this.name,
    required this.lecturer,
    required this.sks,
    required this.description,
  });

  static List<KrsCourse> getInitialCourses() {
    return const [
      KrsCourse(
        code: 'TRPL501',
        name: 'Pemrograman Perangkat Bergerak',
        lecturer: 'Sepyan Purnama Kristanto, M.Kom.',
        sks: 3,
        description: 'Mata kuliah ini membahas tentang pengembangan aplikasi mobile menggunakan Flutter. Mahasiswa akan belajar tentang widget, state management, dan integrasi dengan backend.',
      ),
      // ... tambahkan dua mata kuliah lain
    ];
  }
}