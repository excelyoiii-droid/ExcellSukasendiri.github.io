import 'package:dio/dio.dart';
import '../../../modul_04/models/announcement.dart';
import 'announcement_repository.dart';

class AnnouncementRepositoryImpl implements AnnouncementRepository {
  final Dio dio;

  AnnouncementRepositoryImpl(this.dio);

  @override
  Future<List<Announcement>> getAnnouncements({String? category}) async {
    try {
      final response = await dio.get(
        '/api/announcements',
        queryParameters: category != null ? {'category': category} : null,
      );
      final List data = response.data['data'] as List<dynamic>;
      return data
          .map((json) => Announcement.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      String errorMessage;
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          errorMessage =
              'Koneksi ke server timeout. Periksa sambungan internet Anda.';
          break;
        case DioExceptionType.connectionError:
          errorMessage =
              'Gagal terhubung ke server. Periksa koneksi data atau Wi-Fi Anda.';
          break;
        case DioExceptionType.badResponse:
          errorMessage =
              'Server merespons dengan kesalahan (${e.response?.statusCode}).';
          break;
        default:
          errorMessage =
              'Terjadi kendala jaringan: ${e.message ?? 'Kesalahan tidak diketahui'}';
      }
      throw Exception(errorMessage);
    }
  }

  @override
  Future<Announcement> addAnnouncement(Announcement announcement) async {
    try {
      final response = await dio.post(
        '/api/announcements',
        data: {
          'title': announcement.title,
          'content': announcement.content,
          'author': announcement.author,
          'description': announcement.description,
          'category': announcement.category,
          'date': announcement.date.toIso8601String(),
        },
      );
      return Announcement.fromJson(response.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      String errorMessage;
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          errorMessage =
              'Koneksi ke server timeout. Periksa sambungan internet Anda.';
          break;
        case DioExceptionType.connectionError:
          errorMessage =
              'Gagal terhubung ke server. Periksa koneksi data atau Wi-Fi Anda.';
          break;
        case DioExceptionType.badResponse:
          errorMessage =
              'Server merespons dengan kesalahan (${e.response?.statusCode}).';
          break;
        default:
          errorMessage =
              'Terjadi kendala jaringan: ${e.message ?? 'Kesalahan tidak diketahui'}';
      }
      throw Exception(errorMessage);
    }
  }
}