// import 'announcement_list_screen.dart';
import '../models/announcement.dart';
import 'package:flutter/material.dart';

class AnnouncementDetailScreen extends StatelessWidget {
  final Announcement announcement;

  const AnnouncementDetailScreen({
    super.key,
    required this.announcement,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(announcement.title)),
      body: Text(announcement.description),
    );
  }
}