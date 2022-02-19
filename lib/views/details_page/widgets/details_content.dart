import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../common/models/_models.dart';

class DetailsContent extends HookWidget {
  const DetailsContent({
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

    final _favorite = useState(movie.favorite);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: width - 160,
                child: Text(
                  movie.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          _favorite.value = !_favorite.value;
                          onTapFavorite!();
                        },
                        child: Icon(
                          Icons.favorite,
                          color: _favorite.value ? Colors.red : Colors.grey,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "${movie.voteAverage * 10}%",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                          fontWeight: FontWeight.w300,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "${movie.voteCount} votes",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            "Movie description",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            movie.overview,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
