// Model data untuk mata kuliah
class Course {
  final String code;
  final String name;
  final String lecturer;
  final int sks;
  final double progress; // progres silabus (0.0 - 1.0)
  final String room;

  const Course({
    required this.code,
    required this.name,
    required this.lecturer,
    required this.sks,
    required this.progress,
    this.room = 'Lab Komputer 3',
  });

  // Data dummy untuk bahan praktikum & testing
  static List<Course> getSampleCourses() {
    return const [
      Course(
        code: 'TRPL2B',
        name: 'Statiska',
        lecturer: 'Siska Aprilia Hardiyanti',
        sks: 2,
        progress: 0.45,
        room: 'G6.02',
      ),
      Course(
        code: 'TRPL2B',
        name: 'Metode dan Model Pengembangan Perangkat Lunak',
        lecturer: 'Ruth Ema',
        sks: 3,
        progress: 0.45,
        room: 'G6.04',
      ),
      Course(
        code: 'TRPL2B',
        name: 'Basis Data Lanjut',
        lecturer: 'Eka Mistiko Rini',
        sks: 2,
        progress: 0.45,
        room: 'Lab Basis Data',
      ),
      Course(
        code: 'TRPL2B',
        name: 'Pratikum Basis Data Lanjut',
        lecturer: 'Eka Mistiko Rini',
        sks: 3,
        progress: 0.45,
        room: 'Lab Basis Data',
      ),
      Course(
        code: 'TRPL2B',
        name: 'Rekayasa Kebutuhan Perangkat Lunak',
        lecturer: 'Eka Novita Sari',
        sks: 2,
        progress: 0.45,
        room: 'G4.01',
      ),
      Course(code: 'TRPL2B',
        name: 'Interoperabilitas',
        lecturer: 'I Wayan',
        sks: 2,
        progress: 0.45, 
        room: 'Lab TUK',
      ),
      Course(
        code: 'TRPL2B',
        name: 'Praktikum Interoperabilitas',
        lecturer: 'I Wayan',
        sks: 3,
        progress: 0.45,
        room: 'Lab TUK',
      ),
      Course(
        code: 'TRPL2B',
        name: 'Pemrograman Web Lanjut',
        lecturer: 'Devit',
        sks: 2,
        progress: 0.45,
        room: 'Lab Pemrograman 2',
      ),
      Course(
        code: 'TRPL2B',
        name: 'Praktikum Pemrograman Web Lanjut',
        lecturer: 'Devit',
        sks: 3,
        progress: 0.45,
        room: 'Lab Pemrograman 2',
      ),
      Course(
        code: 'TRPL2B',
        name: 'Pancasila',
        lecturer: 'Ninik Sri Rahayu Wilujeng',
        sks: 2,
        progress: 0.45,
        room: 'G5.01',
      ),
      Course(
        code: 'TRPL2B',
        name: 'Pemrograman Perangkat Bergerak',
        lecturer: 'Galih',
        sks: 2,
        progress: 0.45,
        room: 'Lab TUK',
      ),
      Course(
        code: 'TRPL2B',
        name: 'Praktikum Pemrograman Perangkat Bergerak',
        lecturer: 'Galih',
        sks: 3,
        progress: 0.45,
        room: 'Lab TUK',
      ),
    ];
  }
}