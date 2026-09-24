import '../../../modul_04/models/announcement.dart';
import 'announcement_repository.dart';

class SampleAnnouncementRepository implements AnnouncementRepository {
  /// Perhatikan `List<Announcement>.of(...)`.
  /// `Announcement.getSampleAnnouncements()` mengembalikan list `const`, dan
  /// list `const` TIDAK DAPAT DIUBAH. Tanpa penyalinan ini, `_items.add()`
  /// di bawah akan melempar `UnsupportedError` saat dijalankan — padahal
  /// `flutter analyze` tetap hijau.
  final List<Announcement> _items =
      List<Announcement>.of(Announcement.getSampleAnnouncements());

  @override
  Future<List<Announcement>> getAnnouncements({String? category}) async {
    if (category == null) return _items;
    return _items.where((a) => a.category == category).toList();
  }

  @override
  Future<Announcement> addAnnouncement(Announcement announcement) async {
    _items.add(announcement);
    return announcement;
  }
}