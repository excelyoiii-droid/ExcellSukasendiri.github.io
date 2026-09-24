import 'dart:async';
import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/task_storage.dart';


class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key, this.storage});

  /// Dapat disuntikkan dari luar (widget test atau praktikum keadaan memuat).
  final TaskStorage? storage;

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  late final TaskStorage _storage = widget.storage ?? const TaskStorage();

  List<Task>? _tugas;
  Object? _error;
  bool _sedangMenyimpan = false;

  @override
  void initState() {
    super.initState();
    unawaited(_muat());
  }

  Future<void> _muat() async {
    setState(() {
      _tugas = null;
      _error = null;
    });

    try {
      final List<Task> hasil = await _storage.muat();
      if (!mounted) return;
      setState(() => _tugas = hasil);
    } catch (e) {
      if (!mounted) return;
      setState(() => _error = e);
    }
  }

  Future<bool> _simpanDaftar(
    List<Task> daftarBaru, {
    String? pesan,
    List<Task>? daftarSebelumnya,
  }) async {
    final List<Task>? cadangan = daftarSebelumnya ?? _tugas;

    setState(() {
      _tugas = daftarBaru;
      _sedangMenyimpan = true;
    });

    try {
      await _storage.simpan(daftarBaru);
      if (!mounted) return true;
      setState(() => _sedangMenyimpan = false);
      if (pesan != null) _pesan(pesan);
      return true;
    } catch (e) {
      if (!mounted) return false;
      // Gulung balik: layar dikembalikan ke kondisi terakhir yang
      // benar-benar tersimpan.
      setState(() {
        _tugas = cadangan;
        _sedangMenyimpan = false;
      });
      _pesan('Gagal menyimpan: ${_rapikanPesan(e)}');
      return false;
    }
  }

  Future<void> _ubahStatus(Task tugas) async {
    final List<Task>? sekarang = _tugas;
    if (sekarang == null) return;

    // `map` + `copyWith`, bukan mengubah objek di tempat.
    final List<Task> baru = sekarang
        .map((Task t) => t.id == tugas.id ? t.copyWith(done: !t.done) : t)
        .toList(growable: true);

    await _simpanDaftar(baru, daftarSebelumnya: sekarang);
  }
    void _pesan(String teks) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(teks)));
  }

  String _rapikanPesan(Object error) {
    return error.toString();
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Daftar Tugas')),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Gagal memuat: ${_rapikanPesan(_error!)}'),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: _muat,
                child: const Text('Coba lagi'),
              ),
            ],
          ),
        ),
      );
    }

    final List<Task>? tugas = _tugas;
    if (tugas == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Tugas'),
        actions: [
          if (_sedangMenyimpan)
            const Padding(
              padding: EdgeInsets.all(16),
              child: SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
        ],
      ),
      body: ListView.builder(
        itemCount: tugas.length,
        itemBuilder: (context, index) {
          final Task t = tugas[index];
          return CheckboxListTile(
            title: Text(t.title),
            value: t.done,
            onChanged: (_) => _ubahStatus(t),
          );
        },
      ),
    );
  }
}
