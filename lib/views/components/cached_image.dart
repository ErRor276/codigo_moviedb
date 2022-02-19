import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

final _cacheManager = CacheManager(
  Config(
    'images',
    stalePeriod: const Duration(days: 7),
  ),
);

class CachedImage extends StatelessWidget {
  final String imageUrl;
  const CachedImage({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      cacheManager: _cacheManager,
    );
  }
}

CachedNetworkImageProvider cachedImageProvider(String url) =>
    CachedNetworkImageProvider(
      url,
      cacheManager: _cacheManager,
    );
