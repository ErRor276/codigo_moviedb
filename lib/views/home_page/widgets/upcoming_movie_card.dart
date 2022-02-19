import 'package:flutter/material.dart';

import '../../../common/constants/api_constants.dart';
import '../../../common/models/_models.dart';
import '../../_views.dart';
import '_widgets.dart';

class UpcomingMovieCard extends StatelessWidget {
  const UpcomingMovieCard({
    Key? key,
    required this.movie,
    this.onTapFavorite,
  }) : super(key: key);

  final Movie movie;
  final VoidCallback? onTapFavorite;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;

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
        height: 140,
        margin: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 140,
              width: 100,
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
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 8),
                Container(
                  constraints: BoxConstraints(maxWidth: width - 160),
                  child: Text(
                    movie.overview,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 8),
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
                    ),
                    const SizedBox(width: 16),
                    const Icon(
                      Icons.comment,
                      color: Colors.yellow,
                      size: 14,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "${movie.voteCount > 1000 ? "${movie.voteCount ~/ 1000}K" : movie.voteCount}",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
