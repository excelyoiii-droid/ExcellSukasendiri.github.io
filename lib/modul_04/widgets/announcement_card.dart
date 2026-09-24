import 'package:flutter/material.dart';

import '../models/announcement.dart';

class AnnouncementCard extends StatelessWidget {
  const AnnouncementCard({
    super.key,
    required this.announcement,
    required this.onTap,
  });

  final Announcement announcement;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Tag kategori di kiri, tanggal di kanan.
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: warna.primaryContainer,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      announcement.category,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: warna.onPrimaryContainer,
                      ),
                    ),
                  ),
                  Text(
                    '${announcement.date.day}/${announcement.date.month}/${announcement.date.year}',
                    style: TextStyle(
                      fontSize: 12,
                      color: warna.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Judul pengumuman.
              Text(
                announcement.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),

              // Cuplikan konten.
              Text(
                announcement.content,
                style: TextStyle(
                  fontSize: 13,
                  color: warna.onSurfaceVariant,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 10),

              // Penulis dan jumlah pembaca.
              Row(
                children: <Widget>[
                  Icon(Icons.person_outline, size: 14, color: warna.outline),
                  const SizedBox(width: 4),
                  Text(
                    announcement.author,
                    style: TextStyle(fontSize: 12, color: warna.outline),
                  ),
                  const Spacer(),
                  Icon(Icons.visibility_outlined, size: 14, color: warna.outline),
                  const SizedBox(width: 4),
                  Text(
                    '${announcement.readCount}',
                    style: TextStyle(fontSize: 12, color: warna.outline),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}