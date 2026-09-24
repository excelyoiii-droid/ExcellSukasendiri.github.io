import 'package:flutter/material.dart';
import 'package:flutter_2/modul_03/models/krs_course.dart';
import 'package:flutter_2/modul_03/widgets/krs_course_tile.dart';
import 'add_krs_screen.dart';
import 'course_detail_screen.dart';

const int batasSksSemester = 24;
const int ambangPeringatanSks = 21;

class KrsListScreen extends StatefulWidget {
  const KrsListScreen({super.key});

  @override
  State<KrsListScreen> createState() => _KrsListScreenState();
}

class _KrsListScreenState extends State<KrsListScreen> {
  /// Perhatikan `List<KrsCourse>.of(...)`.
  /// `getInitialCourses()` mengembalikan list `const`, dan list `const`
  /// TIDAK DAPAT DIUBAH. Tanpa penyalinan ini, add() dan removeWhere()
  /// akan melempar UnsupportedError saat dijalankan.
  final List<KrsCourse> _courses =
      List<KrsCourse>.of(KrsCourse.getInitialCourses());

  int get _totalSks =>
      _courses.fold(0, (jumlah, course) => jumlah + course.sks);

  void _tampilkanPesan(String pesan) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(pesan)),
    );
  }

  // Tidak ada nilai yang dikembalikan.
  void _bukaDetail(KrsCourse course) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (_) => CourseDetailScreen(course: course)
      ),
    );
  }

  // Menerima hasil lewat Navigator.pop.
  Future<void> _bukaFormTambah() async {
    final KrsCourse? courseBaru = await Navigator.push<KrsCourse>(
      context,
      MaterialPageRoute<KrsCourse>(builder: (_) => const AddKrsScreen()),
    );

    // Tombol kembali ditekan tanpa menyimpan.
    if (!mounted || courseBaru == null) return;

    final bool duplikat = _courses.any(
      (course) => course.code.toUpperCase() == courseBaru.code.toUpperCase(),
    );
    if (duplikat) {
      _tampilkanPesan('Kode ${courseBaru.code} sudah ada di rencana studi.');
      return;
    }

    final int totalBaru = _totalSks + courseBaru.sks;
    if (totalBaru > batasSksSemester) {
      _tampilkanPesan(
        'Total SKS akan menjadi $totalBaru, melebihi batas '
        '$batasSksSemester SKS.',
      );
      return;
    }

    setState(() => _courses.add(courseBaru));
    _tampilkanPesan('${courseBaru.name} ditambahkan ke rencana studi.');
  }

  Future<void> _konfirmasiHapus(KrsCourse course) async {
    // Ambil warna SEBELUM await, agar tidak memakai context
    // setelah jeda asynchronous.
    final Color errorColor = Theme.of(context).colorScheme.error;

    final bool? dikonfirmasi = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Hapus mata kuliah?'),
        content: Text(
          'Yakin ingin membatalkan pengambilan "${course.name}" '
          '(${course.sks} SKS)?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: errorColor),
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (!mounted || dikonfirmasi != true) return;

    setState(() => _courses.removeWhere((item) => item.code == course.code));
    _tampilkanPesan('${course.name} dihapus dari rencana studi.');
  }

  @override
  Widget build(BuildContext context) {
    final bool melebihiAmbang = _totalSks >= ambangPeringatanSks;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rencana Studi (KRS)'),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: melebihiAmbang
                ? Theme.of(context).colorScheme.errorContainer
                : Theme.of(context).colorScheme.primaryContainer,
            child: Text(
              'Total SKS: $_totalSks / $batasSksSemester',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Expanded(
            child: _courses.isEmpty
                ? const Center(child: Text('Belum ada mata kuliah diambil.'))
                : ListView.builder(
                    itemCount: _courses.length,
                    itemBuilder: (context, index) {
                      final course = _courses[index];
                      return KrsCourseTile(
                        course: course,
                        onTap: () => _bukaDetail(course),
                        onDelete: () => _konfirmasiHapus(course),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _bukaFormTambah,
        tooltip: 'Tambah Mata Kuliah',
        child: const Icon(Icons.add),
      ),
    );
  }
}