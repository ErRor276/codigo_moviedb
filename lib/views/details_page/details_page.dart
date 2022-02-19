import 'package:flutter/material.dart';

import '../../common/constants/_constants.dart';
import '../../common/models/_models.dart';
import '../home_page/widgets/_widgets.dart';
import 'widgets/details_content.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({
    Key? key,
    required this.movie,
    this.onTapFavorite,
  }) : super(key: key);

  final Movie movie;
  final VoidCallback? onTapFavorite;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.topLeft,
                children: [
                  Container(
                    height: 240,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      image: DecorationImage(
                          image: cachedImageProvider(
                            "$imageURL${movie.backdropPath}",
                          ),
                          fit: BoxFit.cover),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(28),
                        bottomRight: Radius.circular(28),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.arrow_back_ios,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              DetailsContent(
                movie: movie,
                onTapFavorite: onTapFavorite,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Center(
                  child: Text(
                    "Book Tickets",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
