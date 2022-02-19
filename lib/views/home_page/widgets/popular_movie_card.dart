import 'package:flutter/material.dart';

import '../../../common/constants/api_constants.dart';
import '../../../common/models/_models.dart';
import '../../_views.dart';
import '_widgets.dart';

class PopularMovieCard extends StatelessWidget {
  const PopularMovieCard({
    Key? key,
    required this.movie,
    this.onTapFavorite,
  }) : super(key: key);

  final Movie movie;
  final VoidCallback? onTapFavorite;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => DetailsPage(
            movie: movie,
            onTapFavorite: onTapFavorite,
          ),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(right: 16, top: 16),
        width: 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 160,
              width: 120,
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: cachedImageProvider(
                    "$imageURL${movie.posterPath}",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              movie.title,
              style: const TextStyle(fontSize: 14),
              maxLines: 2,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: 14,
                ),
                const SizedBox(width: 8),
                Text(
                  "${movie.voteAverage * 10}%",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                    fontWeight: FontWeight.w300,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
