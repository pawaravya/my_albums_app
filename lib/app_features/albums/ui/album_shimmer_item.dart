import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AlbumShimmerItem extends StatelessWidget {
  const AlbumShimmerItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          contentPadding: const EdgeInsets.all(12),
          leading: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          title: Container(
            height: 16,
            width: double.infinity,
            color: Colors.white,
            margin: const EdgeInsets.symmetric(vertical: 4),
          ),
          subtitle: Container(
            height: 14,
            width: 100,
            color: Colors.white,
            margin: const EdgeInsets.symmetric(vertical: 4),
          ),
        ),
      ),
    );
  }
}
